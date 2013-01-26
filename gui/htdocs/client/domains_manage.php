<?php
/**
 * EasySCP a Virtual Hosting Control Panel
 * Copyright (C) 2010-2013 by Easy Server Control Panel - http://www.easyscp.net
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 2
 * of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
 *
 * @link 		http://www.easyscp.net
 * @author 		EasySCP Team
 */

require '../../include/easyscp-lib.php';

check_login(__FILE__);

$cfg = EasySCP_Registry::get('Config');

$tpl = EasySCP_TemplateEngine::getInstance();
$template = 'client/domains_manage.tpl';

// dynamic page data.

gen_user_sub_list($tpl, $sql, $_SESSION['user_id']);
gen_user_als_list($tpl, $sql, $_SESSION['user_id']);
gen_user_dns_list($tpl, $sql, $_SESSION['user_id']);

// static page messages.
gen_logged_from($tpl);

check_permissions($tpl);

$tpl->assign(
	array(
		'TR_PAGE_TITLE'		=> tr('EasySCP - Client/Manage Domains'),
		'TR_MANAGE_DOMAINS'	=> tr('Manage domains'),
		'TR_DOMAIN_ALIASES'	=> tr('Domain aliases'),
		'TR_ALS_NAME'		=> tr('Name'),
		'TR_ALS_MOUNT'		=> tr('Mount point'),
		'TR_ALS_FORWARD'	=> tr('Forward'),
		'TR_ALS_STATUS'		=> tr('Status'),
		'TR_ALS_ACTION'		=> tr('Action'),
		'TR_SUBDOMAINS'		=> tr('Subdomains'),
		'TR_SUB_NAME'		=> tr('Name'),
		'TR_SUB_MOUNT'		=> tr('Mount point'),
		'TR_SUB_FORWARD'	=> tr('Forward'),
		'TR_SUB_STATUS'		=> tr('Status'),
		'TR_SUB_ACTION'		=> tr('Actions'),
		'TR_MESSAGE_DELETE'	=> tr('Are you sure you want to delete %s and the associated directory?', true, '%s'),
		'TR_DNS'			=> tr("DNS zone's records"),
		'TR_DNS_NAME'		=> tr('Name'),
		'TR_DNS_CLASS'		=> tr('Class'),
		'TR_DNS_TYPE'		=> tr('Type'),
		'TR_DNS_ACTION'		=> tr('Actions'),
		'TR_DNS_DATA'		=> tr('Record data'),
		'TR_DNS_STATUS'		=> tr('Status'),
		'TR_DOMAIN_NAME'	=> tr('Domain')
	)
);

gen_client_mainmenu($tpl, 'client/main_menu_manage_domains.tpl');
gen_client_menu($tpl, 'client/menu_manage_domains.tpl');

gen_page_message($tpl);

if ($cfg->DUMP_GUI_DEBUG) {
	dump_gui_debug($tpl);
}

$tpl->display($template);

unset_messages();

// page functions.

/**
 * @param EasySCP_TemplateEngine $tpl
 * @param EasySCP_Database $sql
 * @param int $user_id
 * @return void
 */
function gen_user_dns_list($tpl, $sql, $user_id) {
	$domain_id = get_user_domain_id($sql, $user_id);
	$cfg = EasySCP_Registry::get('Config');

	$query = "
		SELECT
			`domain_dns`.`domain_dns_id`,
			`domain_dns`.`domain_id`,
			`domain_dns`.`domain_dns`,
			`domain_dns`.`domain_class`,
			`domain_dns`.`domain_type`,
			`domain_dns`.`domain_text`,
			IFNULL(`domain_aliasses`.`alias_name`, `domain`.`domain_name`) AS 'domain_name',
			IFNULL(`domain_aliasses`.`alias_status`, `domain`.`domain_status`) AS 'domain_status',
			`domain_dns`.`protected`
		FROM
			`domain_dns`
			LEFT JOIN `domain_aliasses` USING (`alias_id`, `domain_id`),
			`domain`
		WHERE
			`domain_dns`.`domain_id` = ?
		AND
			`domain`.`domain_id` = `domain_dns`.`domain_id`
		ORDER BY
			`domain_id`,
			`alias_id`,
			`domain_dns`,
			`domain_type`
	;";

	$rs = exec_query($sql, $query, $domain_id);
	if ($rs->recordCount() == 0) {
		$tpl->assign(
			array(
				'DNS_MSG'		=> tr("Manual zone's records list is empty!"),
				'DNS_MSG_TYPE'	=> 'info',
				'DNS_LIST'		=> ''
			)
		);
	} else {

		while (!$rs->EOF) {
			list($dns_action_delete, $dns_action_script_delete) = gen_user_dns_action(
				'Delete', $rs->fields['domain_dns_id'],
				($rs->fields['protected'] == 'no') ? $rs->fields['domain_status'] : $cfg->ITEM_PROTECTED_STATUS
			);

			list($dns_action_edit, $dns_action_script_edit) = gen_user_dns_action(
				'Edit', $rs->fields['domain_dns_id'],
				($rs->fields['protected'] == 'no') ? $rs->fields['domain_status'] :$cfg->ITEM_PROTECTED_STATUS
			);

			$domain_name = decode_idna($rs->fields['domain_name']);
			$sbd_name = $rs->fields['domain_dns'];
			$sbd_data = $rs->fields['domain_text'];
			$sbd_status = $rs->fields['domain_status'];
			$tpl->append(
				array(
					'DNS_DOMAIN'				=> tohtml($domain_name),
					'DNS_NAME'					=> tohtml($sbd_name),
					'DNS_CLASS'					=> tohtml($rs->fields['domain_class']),
					'DNS_TYPE'					=> tohtml($rs->fields['domain_type']),
					'DNS_DATA'					=> tohtml($sbd_data),
					'DNS_STATUS'				=> translate_dmn_status($sbd_status),
//					'DNS_ACTION_SCRIPT_EDIT'	=> $sub_action,
					'DNS_ACTION_SCRIPT_DELETE'	=> tohtml($dns_action_script_delete),
					'DNS_ACTION_DELETE'			=> tohtml($dns_action_delete),
					'DNS_ACTION_SCRIPT_EDIT'	=> tohtml($dns_action_script_edit),
					'DNS_ACTION_EDIT'			=> tohtml($dns_action_edit),
					'DNS_TYPE_RECORD'			=> tr("%s record", $rs->fields['domain_type'])
				)
			);
			$rs->moveNext();
		}

		$tpl->assign('DNS_MESSAGE', '');
	}
}

function gen_user_dns_action($action, $dns_id, $status) {

	$cfg = EasySCP_Registry::get('Config');

	if ($status == $cfg->ITEM_OK_STATUS) {
		return array(tr($action), 'dns_'.strtolower($action).'.php?edit_id='.$dns_id);
	} elseif($action != 'Edit' && $status == $cfg->ITEM_PROTECTED_STATUS) {
		return array(tr('N/A'), 'protected');
	}

	return array(tr('N/A'), '#');
}

function gen_user_sub_action($sub_id, $sub_status) {

	$cfg = EasySCP_Registry::get('Config');

	if ($sub_status === $cfg->ITEM_OK_STATUS) {
		return array(tr('Delete'), "subdomain_delete.php?id=$sub_id");
	} else {
		return array(tr('N/A'), '#');
	}
}

function gen_user_alssub_action($sub_id, $sub_status) {

	$cfg = EasySCP_Registry::get('Config');

	if ($sub_status === $cfg->ITEM_OK_STATUS) {
		return array(tr('Delete'), "alssub_delete.php?id=$sub_id");
	} else {
		return array(tr('N/A'), '#');
	}
}

function gen_user_sub_forward($sub_id, $sub_status, $url_forward, $dmn_type) {

	$cfg = EasySCP_Registry::get('Config');

	if ($sub_status === $cfg->ITEM_OK_STATUS) {
		return array(
			$url_forward === 'no' || $url_forward === NULL
			?
				'-'
			:
				$url_forward,
			'subdomain_edit.php?edit_id='.$sub_id.'&amp;dmn_type='.$dmn_type, tr('Edit')
		);
	} else if ($sub_status === $cfg->ITEM_ORDERED_STATUS) {
		return array(
			$url_forward === 'no' || $url_forward === NULL
			?
				'-'
			:
				$url_forward, '#', tr('N/A')
			);
	} else {
		return array(tr('N/A'), '#', tr('N/A'));
	}
}

/**
 * @param EasySCP_TemplateEngine $tpl
 * @param EasySCP_Database $sql
 * @param int $user_id
 */
function gen_user_sub_list($tpl, $sql, $user_id) {

	$domain_id = get_user_domain_id($sql, $user_id);

	$query = "
		SELECT
			`subdomain_id`,
			`subdomain_name`,
			`subdomain_mount`,
			`subdomain_status`,
			`subdomain_url_forward`,
			`domain_name`
		FROM
			`subdomain` JOIN `domain`
		ON
			`subdomain`.`domain_id` = `domain`.`domain_id`
		WHERE
			`subdomain`.`domain_id` = ?
		ORDER BY
			`subdomain_name`
	;";

	$query2 = "
		SELECT
			`subdomain_alias_id`,
			`subdomain_alias_name`,
			`subdomain_alias_mount`,
			`subdomain_alias_url_forward`,
			`subdomain_alias_status`,
			`alias_name`
		FROM
			`subdomain_alias` JOIN `domain_aliasses`
		ON
			`subdomain_alias`.`alias_id` = `domain_aliasses`.`alias_id`
		WHERE
			`domain_id` = ?
		ORDER BY
			`subdomain_alias_name`
	;";

	$rs = exec_query($sql, $query, $domain_id);
	$rs2 = exec_query($sql, $query2, $domain_id);

	if (($rs->recordCount() + $rs2->recordCount()) == 0) {
		$tpl->assign(array(
			'SUB_MSG'		=> tr('Subdomain list is empty!'),
			'SUB_MSG_TYPE'	=> 'info',
			'SUB_LIST'		=> '')
		);
	} else {
		while (!$rs->EOF) {

			list($sub_action, $sub_action_script) = gen_user_sub_action($rs->fields['subdomain_id'], $rs->fields['subdomain_status']);
			list($sub_forward, $sub_edit_link, $sub_edit) = gen_user_sub_forward($rs->fields['subdomain_id'], $rs->fields['subdomain_status'], $rs->fields['subdomain_url_forward'], 'dmn');
			$sbd_name = decode_idna($rs->fields['subdomain_name']);
			$dmn_name = decode_idna($rs->fields['domain_name']);
			$sub_forward = decode_idna($sub_forward);
			$tpl->append(
				array(
					'SUB_NAME'			=> tohtml($sbd_name),
					'SUB_ALIAS_NAME'	=> tohtml($dmn_name),
					'SUB_MOUNT'			=> tohtml($rs->fields['subdomain_mount']),
					'SUB_FORWARD'		=> $sub_forward,
					'SUB_STATUS'		=> translate_dmn_status($rs->fields['subdomain_status']),
					'SUB_EDIT_LINK'		=> $sub_edit_link,
					'SUB_EDIT'			=> $sub_edit,
					'SUB_ACTION'		=> $sub_action,
					'SUB_ACTION_SCRIPT'	=> $sub_action_script
				)
			);
			$rs->moveNext();
		}
		while (!$rs2->EOF) {
			list($sub_action, $sub_action_script) = gen_user_alssub_action($rs2->fields['subdomain_alias_id'], $rs2->fields['subdomain_alias_status']);
			list($sub_forward, $sub_edit_link, $sub_edit) = gen_user_sub_forward($rs2->fields['subdomain_alias_id'], $rs2->fields['subdomain_alias_status'], $rs2->fields['subdomain_alias_url_forward'], 'als');
			$sbd_name = decode_idna($rs2->fields['subdomain_alias_name']);
			$sub_forward = decode_idna($sub_forward);
			$tpl->append(
				array(
					'SUB_NAME'			=> tohtml($sbd_name),
					'SUB_ALIAS_NAME'	=> tohtml($rs2->fields['alias_name']),
					'SUB_MOUNT'			=> tohtml($rs2->fields['subdomain_alias_mount']),
					'SUB_FORWARD'		=> $sub_forward,
					'SUB_STATUS'		=> translate_dmn_status($rs2->fields['subdomain_alias_status']),
					'SUB_EDIT_LINK'		=> $sub_edit_link,
					'SUB_EDIT'			=> $sub_edit,
					'SUB_ACTION'		=> $sub_action,
					'SUB_ACTION_SCRIPT'	=> $sub_action_script
				)
			);
			$rs2->moveNext();
		}

		$tpl->assign('SUB_MESSAGE', '');
	}
}

function gen_user_als_action($als_id, $als_status) {

	$cfg = EasySCP_Registry::get('Config');

	if ($als_status === $cfg->ITEM_OK_STATUS) {
		return array(tr('Delete'), 'alias_delete.php?id=' . $als_id);
	} else if ($als_status === $cfg->ITEM_ORDERED_STATUS) {
		return array(tr('Delete order'), 'alias_order_delete.php?del_id=' . $als_id);
	} else {
		return array(tr('N/A'), '#');
	}
}

function gen_user_als_forward($als_id, $als_status, $url_forward) {

	if ($url_forward === 'no') {
		if ($als_status === 'ok') {
			return array("-", "alias_edit.php?edit_id=" . $als_id, tr("Edit"));
		} else if ($als_status === 'ordered') {
			return array("-", "#", tr("N/A"));
		} else {
			return array(tr("N/A"), "#", tr("N/A"));
		}
	} else {
		if ($als_status === 'ok') {
			return array($url_forward, "alias_edit.php?edit_id=" . $als_id, tr("Edit"));
		} else if ($als_status === 'ordered') {
			return array($url_forward, "#", tr("N/A"));
		} else {
			return array(tr("N/A"), "#", tr("N/A"));
		}
	}
}

/**
 * @param EasySCP_TemplateEngine $tpl
 * @param EasySCP_Database $sql
 * @param int $user_id
 */
function gen_user_als_list($tpl, $sql, $user_id) {

	$domain_id = get_user_domain_id($sql, $user_id);

	$query = "
		SELECT
			`alias_id`,
			`alias_name`,
			`alias_status`,
			`alias_mount`,
			`alias_ip_id`,
			`url_forward`
		FROM
			`domain_aliasses`
		WHERE
			`domain_id` = ?
		ORDER BY
			`alias_mount`,
			`alias_name`
	;";

	$rs = exec_query($sql, $query, $domain_id);

	if ($rs->recordCount() == 0) {
		$tpl->assign(array(
			'ALS_MSG'		=> tr('Alias list is empty!'),
			'ALS_MSG_TYPE'	=> 'info',
			'ALS_LIST'		=> '')
		);
	} else {
		while (!$rs->EOF) {

			list($als_action, $als_action_script) = gen_user_als_action($rs->fields['alias_id'], $rs->fields['alias_status']);
			list($als_forward, $alias_edit_link, $als_edit) = gen_user_als_forward($rs->fields['alias_id'], $rs->fields['alias_status'], $rs->fields['url_forward']);

			$alias_name = decode_idna($rs->fields['alias_name']);
			$als_forward = decode_idna($als_forward);
			$tpl->append(
				array(
					'ALS_NAME'			=> tohtml($alias_name),
					'ALS_MOUNT'			=> tohtml($rs->fields['alias_mount']),
					'ALS_STATUS'		=> translate_dmn_status($rs->fields['alias_status']),
					'ALS_FORWARD'		=> tohtml($als_forward),
					'ALS_EDIT_LINK'		=> $alias_edit_link,
					'ALS_EDIT'			=> $als_edit,
					'ALS_ACTION'		=> $als_action,
					'ALS_ACTION_SCRIPT'	=> $als_action_script
				)
			);
			$rs->moveNext();
		}

		$tpl->assign('ALS_MESSAGE', '');
	}
}
?>