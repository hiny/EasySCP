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

if (strtolower($cfg->HOSTING_PLANS_LEVEL) != 'admin') {
	user_goto('index.php');
}

$tpl = EasySCP_TemplateEngine::getInstance();
$template = 'admin/hosting_plan_add.tpl';

if (isset($_POST['uaction']) && ('add_plan' === $_POST['uaction'])) {
	// Process data
	if (check_data_correction($tpl))
		save_data_to_db($tpl, $_SESSION['user_id']);

	gen_data_ahp_page($tpl);
} else {
	gen_empty_ahp_page($tpl);
}

// static page messages
$tpl->assign(
		array(
				'TR_PAGE_TITLE'				=> tr('EasySCP - Administrator/Add hosting plan'),
				'TR_ADD_HOSTING_PLAN'		=> tr('Add hosting plan'),
				'TR_HOSTING PLAN PROPS'		=> tr('Hosting plan properties'),
				'TR_TEMPLATE_NAME'			=> tr('Template name'),
				'TR_MAX_SUBDOMAINS'			=> tr('Max subdomains<br /><em>(-1 disabled, 0 unlimited)</em>'),
				'TR_MAX_ALIASES'			=> tr('Max aliases<br /><em>(-1 disabled, 0 unlimited)</em>'),
				'TR_MAX_MAILACCOUNTS'		=> tr('Mail accounts limit<br /><em>(-1 disabled, 0 unlimited)</em>'),
				'TR_MAX_FTP'				=> tr('FTP accounts limit<br /><em>(-1 disabled, 0 unlimited)</em>'),
				'TR_MAX_SQL'				=> tr('SQL databases limit<br /><em>(-1 disabled, 0 unlimited)</em>'),
				'TR_MAX_SQL_USERS'			=> tr('SQL users limit<br /><em>(-1 disabled, 0 unlimited)</em>'),
				'TR_MAX_TRAFFIC'			=> tr('Traffic limit [MB]<br /><em>(0 unlimited)</em>'),
				'TR_DISK_LIMIT'				=> tr('Disk limit [MB]<br /><em>(0 unlimited)</em>'),
				'TR_PHP'					=> tr('PHP'),
				'TR_CGI'					=> tr('CGI / Perl'),
				'TR_DNS'					=> tr('Allow adding records to DNS zone'),
				'TR_BACKUP'					=> tr('Backup'),
				'TR_BACKUP_DOMAIN'			=> tr('Domain'),
				'TR_BACKUP_SQL'				=> tr('SQL'),
				'TR_BACKUP_FULL'			=> tr('Full'),
				'TR_BACKUP_NO'				=> tr('No'),
				'TR_APACHE_LOGS'			=> tr('Apache logfiles'),
				'TR_AWSTATS'				=> tr('AwStats'),
				'TR_YES'					=> tr('Yes'),
				'TR_NO'						=> tr('No'),
				'TR_BILLING_PROPS'			=> tr('Billing Settings'),
				'TR_PRICE'					=> tr('Price'),
				'TR_SETUP_FEE'				=> tr('Setup fee'),
				'TR_VALUE'					=> tr('Currency'),
				'TR_PAYMENT'				=> tr('Payment period'),
				'TR_STATUS'					=> tr('Available for purchasing'),
				'TR_TEMPLATE_DESCRIPTON'	=> tr('Description'),
				'TR_EXAMPLE'				=> tr('(e.g. EUR)'),

			// BEGIN TOS
				'TR_TOS_PROPS'				=> tr('Term Of Service'),
				'TR_TOS_NOTE'				=> tr('<strong>Optional:</strong> Leave this field empty if you do not want term of service for this hosting plan.'),
				'TR_TOS_DESCRIPTION'		=> tr('Text Only'),

			// END TOS

				'TR_ADD_PLAN'				=> tr('Add plan')
		)
);

gen_admin_mainmenu($tpl, 'admin/main_menu_hosting_plan.tpl');
gen_admin_menu($tpl, 'admin/menu_hosting_plan.tpl');

gen_page_message($tpl);

if ($cfg->DUMP_GUI_DEBUG) {
	dump_gui_debug($tpl);
}

$tpl->display($template);

// Function definitions

/**
 * Generate empty form
 * @param EasySCP_TemplateEngine $tpl
 */
function gen_empty_ahp_page($tpl) {

	$cfg = EasySCP_Registry::get('Config');

	$tpl->assign(
			array(
					'HP_NAME_VALUE'			=> '',
					'TR_MAX_SUB_LIMITS'		=> '',
					'TR_MAX_ALS_VALUES'		=> '',
					'HP_MAIL_VALUE'			=> '',
					'HP_FTP_VALUE'			=> '',
					'HP_SQL_DB_VALUE'		=> '',
					'HP_SQL_USER_VALUE'		=> '',
					'HP_TRAFF_VALUE'		=> '',
					'HP_PRICE'				=> '',
					'HP_SETUPFEE'			=> '',
					'HP_VALUE'				=> '',
					'HP_PAYMENT'			=> '',
					'HP_DESCRIPTION_VALUE'	=> '',
					'HP_DISK_VALUE'			=> '',
					'TR_PHP_YES'			=> '',
					'TR_PHP_NO'				=> $cfg->HTML_CHECKED,
					'TR_CGI_YES'			=> '',
					'TR_CGI_NO'				=> $cfg->HTML_CHECKED,
					'VL_BACKUPD'			=> '',
					'VL_BACKUPS'			=> '',
					'VL_BACKUPF'			=> '',
					'VL_BACKUPN'			=> $cfg->HTML_CHECKED,
					'TR_DNS_YES'			=> '',
					'TR_DNS_NO'				=> $cfg->HTML_CHECKED,
					'TR_STATUS_YES'			=> $cfg->HTML_CHECKED,
					'TR_STATUS_NO'			=> '',
					'HP_TOS_VALUE'			=> ''
			)
	);

	$tpl->assign('MESSAGE', '');

} // end of gen_empty_hp_page()

/**
 * Show last entered data for new hp
 * @param EasySCP_TemplateEngine $tpl
 */
function gen_data_ahp_page($tpl) {

	global $hp_name, $description, $hp_php, $hp_cgi;
	global $hp_sub, $hp_als, $hp_mail;
	global $hp_ftp, $hp_sql_db, $hp_sql_user;
	global $hp_traff, $hp_disk;
	global $price, $setup_fee, $value, $payment, $status;
	global $hp_backup, $hp_dns;
	global $tos;

	$cfg = EasySCP_Registry::get('Config');

	$tpl->assign(
			array(
					'HP_NAME_VALUE'			=> tohtml($hp_name),
					'TR_MAX_SUB_LIMITS'		=> tohtml($hp_sub),
					'TR_MAX_ALS_VALUES'		=> tohtml($hp_als),
					'HP_MAIL_VALUE'			=> tohtml($hp_mail),
					'HP_FTP_VALUE'			=> tohtml($hp_ftp),
					'HP_SQL_DB_VALUE'		=> tohtml($hp_sql_db),
					'HP_SQL_USER_VALUE'		=> tohtml($hp_sql_user),
					'HP_TRAFF_VALUE'		=> tohtml($hp_traff),
					'HP_DISK_VALUE'			=> tohtml($hp_disk),
					'HP_DESCRIPTION_VALUE'	=> tohtml($description),
					'HP_PRICE'				=> tohtml($price),
					'HP_SETUPFEE'			=> tohtml($setup_fee),
					'HP_VALUE'				=> tohtml($value),
					'HP_PAYMENT'			=> tohtml($payment),
					'HP_TOS_VALUE'			=> tohtml($tos)
			)
	);

	$tpl->assign(
			array(
					'TR_PHP_YES'	=> ($hp_php == '_yes_') ? $cfg->HTML_CHECKED : '',
					'TR_PHP_NO'		=> ($hp_php == '_no_') ? $cfg->HTML_CHECKED : '',
					'TR_CGI_YES'	=> ($hp_cgi == '_yes_') ? $cfg->HTML_CHECKED : '',
					'TR_CGI_NO'		=> ($hp_cgi == '_no_') ? $cfg->HTML_CHECKED : '',
					'VL_BACKUPD'	=> ($hp_backup == '_dmn_') ? $cfg->HTML_CHECKED : '',
					'VL_BACKUPS'	=> ($hp_backup == '_sql_') ? $cfg->HTML_CHECKED : '',
					'VL_BACKUPF'	=> ($hp_backup == '_full_') ? $cfg->HTML_CHECKED : '',
					'VL_BACKUPN'	=> ($hp_backup == '_no_') ? $cfg->HTML_CHECKED : '',
					'TR_DNS_YES'	=> ($hp_dns == '_yes_') ? $cfg->HTML_CHECKED : '',
					'TR_DNS_NO'		=> ($hp_dns == '_no_') ? $cfg->HTML_CHECKED : '',
					'TR_STATUS_YES'	=> ($status) ? $cfg->HTML_CHECKED : '',
					'TR_STATUS_NO'	=> (!$status) ? $cfg->HTML_CHECKED : ''
			)
	);

} // End of gen_data_ahp_page()

/**
 * Check correction of input data
 * @param EasySCP_TemplateEngine $tpl
 */
function check_data_correction($tpl) {

	global $hp_name, $description, $hp_php, $hp_cgi;
	global $hp_sub, $hp_als, $hp_mail;
	global $hp_ftp, $hp_sql_db, $hp_sql_user;
	global $hp_traff, $hp_disk;
	global $price, $setup_fee, $value, $payment, $status;
	global $hp_backup, $hp_dns;
	global $tos;

	$ahp_error 		= array();

	$hp_name		= clean_input($_POST['hp_name']);
	$hp_sub			= clean_input($_POST['hp_sub']);
	$hp_als			= clean_input($_POST['hp_als']);
	$hp_mail		= clean_input($_POST['hp_mail']);
	$hp_ftp			= clean_input($_POST['hp_ftp']);
	$hp_sql_db		= clean_input($_POST['hp_sql_db']);
	$hp_sql_user	= clean_input($_POST['hp_sql_user']);
	$hp_traff		= clean_input($_POST['hp_traff']);
	$hp_disk		= clean_input($_POST['hp_disk']);
	$description	= clean_input($_POST['hp_description']);
	$value			= clean_input($_POST['hp_value']);
	$payment		= clean_input($_POST['hp_payment']);
	$status			= $_POST['status'];
	$tos			= clean_input($_POST['hp_tos']);

	if (empty($_POST['hp_price'])) {
		$price = 0;
	} else {
		$price = clean_input($_POST['hp_price']);
	}

	if (empty($_POST['hp_setupfee'])) {
		$setup_fee = 0;
	} else {
		$setup_fee = clean_input($_POST['hp_setupfee']);
	}



	if (isset($_POST['php'])) {
		$hp_php = $_POST['php'];
	}

	if (isset($_POST['cgi'])) {
		$hp_cgi = $_POST['cgi'];
	}

	if (isset($_POST['dns'])) {
		$hp_dns = $_POST['dns'];
	}

	if (isset($_POST['backup'])) {
		$hp_backup = $_POST['backup'];
	}

	if ($hp_name == '') {
		$ahp_error[] = tr('Incorrect template name length!');
	}
	if ($description == '') {
		$ahp_error[] = tr('Incorrect template description length!');
	}
	if (!is_numeric($price)) {
		$ahp_error[] = tr('Incorrect price syntax!');
	}

	if (!is_numeric($setup_fee)) {
		$ahp_error[] = tr('Incorrect setup fee syntax!');
	}

	if (!easyscp_limit_check($hp_sub, -1)) {
		$ahp_error[] = tr('Incorrect subdomains limit!');
	}
	if (!easyscp_limit_check($hp_als, -1)) {
		$ahp_error[] = tr('Incorrect aliases limit!');
	}
	if (!easyscp_limit_check($hp_mail, -1)) {
		$ahp_error[] = tr('Incorrect mail accounts limit!');
	}
	if (!easyscp_limit_check($hp_ftp, -1)) {
		$ahp_error[] = tr('Incorrect FTP accounts limit!');
	}
	if (!easyscp_limit_check($hp_sql_user, -1)) {
		$ahp_error[] = tr('Incorrect SQL databases limit!');
	}
	if (!easyscp_limit_check($hp_sql_db, -1)) {
		$ahp_error[] = tr('Incorrect SQL users limit!');
	}
	if (!easyscp_limit_check($hp_traff, null)) {
		$ahp_error[] = tr('Incorrect traffic limit!');
	}
	if (!easyscp_limit_check($hp_disk, null)) {
		$ahp_error[] = tr('Incorrect disk quota limit!');
	}

	if (empty($ahp_error)) {
		$tpl->assign('MESSAGE', '');
		return true;
	} else {
		set_page_message(format_message($ahp_error), 'warning');
		return false;
	}

} // end of check_data_correction()

/**
 * Add new host plan to DB
 * @param EasySCP_TemplateEngine $tpl
 * @param int $admin_id
 */
function save_data_to_db($tpl, $admin_id) {

	global $hp_name, $description, $hp_php, $hp_cgi;
	global $hp_sub, $hp_als, $hp_mail;
	global $hp_ftp, $hp_sql_db, $hp_sql_user;
	global $hp_traff, $hp_disk;
	global $price, $setup_fee, $value, $payment, $status;
	global $hp_backup, $hp_dns;
	global $tos;

	$sql = EasySCP_Registry::get('Db');

	$query = "
		SELECT
			t1.`id`, t1.`name`, t1.`reseller_id`, t1.`name`, t1.`props`,
			t1.`status`, t2.`admin_id`, t2.`admin_type`
		FROM
			`hosting_plans` AS t1,
			`admin` AS t2
		WHERE
			t2.`admin_type` = ?
		AND
			t1.`reseller_id` = t2.`admin_id`
		AND
			t1.`name` = ?
	";
	$res = exec_query($sql, $query, array('admin', $hp_name));

	if ($res->rowCount() == 1) {
		$tpl->assign('MESSAGE', tr('Hosting plan with entered name already exists!'));
	} else {
		$hp_props = "$hp_php;$hp_cgi;$hp_sub;$hp_als;$hp_mail;$hp_ftp;$hp_sql_db;$hp_sql_user;$hp_traff;$hp_disk;$hp_backup;$hp_dns";
		$query = "
			INSERT INTO
				hosting_plans(
					`reseller_id`,
					`name`,
					`description`,
					`props`,
					`price`,
					`setup_fee`,
					`value`,
					`payment`,
					`status`,
					`tos`
				) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
		";

		exec_query($sql, $query, array($admin_id, $hp_name, $description, $hp_props, $price, $setup_fee, $value, $payment, $status, $tos));

		$_SESSION['hp_added'] = '_yes_';
		user_goto('hosting_plan.php');
	}
} // end of save_data_to_db()
?>