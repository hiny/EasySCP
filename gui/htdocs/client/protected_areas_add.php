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
$template = 'client/protected_areas_add.tpl';

$dmn_id = get_user_domain_id($sql, $_SESSION['user_id']);

protect_area($tpl, $sql, $dmn_id);

gen_protect_it($tpl, $sql, $dmn_id);

// static page messages
gen_logged_from($tpl);

check_permissions($tpl);

$tpl->assign(
	array(
		'TR_PAGE_TITLE'		=> tr('EasySCP - Client/Webtools'),
		'TR_HTACCESS'		=> tr('Protected areas'),
		'TR_PROTECT_DIR'	=> tr('Protect this area'),
		'TR_PATH'			=> tr('Path'),
		'TR_USER'			=> tr('Users'),
		'TR_GROUPS'			=> tr('Groups'),
		'TR_PROTECT_IT'		=> tr('Protect it'),
		'TR_USER_AUTH'		=> tr('User auth'),
		'TR_GROUP_AUTH'		=> tr('Group auth'),
		'TR_AREA_NAME'		=> tr('Area name'),
		'TR_PROTECT_IT'		=> tr('Protect it'),
		'TR_UNPROTECT_IT'	=> tr('Unprotect it'),
		'TR_AREA_NAME'		=> tr('Area name'),
		'TR_CANCEL'			=> tr('Cancel'),
		'TR_MANAGE_USRES'	=> tr('Manage users and groups'),
		'CHOOSE_DIR'		=> tr('Choose dir')
	)
);

gen_client_mainmenu($tpl, 'client/main_menu_webtools.tpl');
gen_client_menu($tpl, 'client/menu_webtools.tpl');

gen_page_message($tpl);

if ($cfg->DUMP_GUI_DEBUG) {
	dump_gui_debug($tpl);
}

$tpl->display($template);

unset_messages();

/**
 * @todo use db prepared statements
 */
function protect_area($tpl, $sql, $dmn_id) {

	$cfg = EasySCP_Registry::get('Config');

	if (!isset($_POST['uaction']) || $_POST['uaction'] != 'protect_it') {
		return;
	}

	if (!isset($_POST['users']) && !isset($_POST['groups'])) {
		set_page_message(tr('Please choose user or group'), 'warning');
		return;
	}

	if (empty($_POST['paname'])) {
		set_page_message(tr('Please enter area name'), 'warning');
		return;
	}

	if (empty($_POST['other_dir'])) {
		set_page_message(tr('Please enter area path'), 'warning');
		return;
	}

	$path = clean_input($_POST['other_dir'], false);

	// Cleanup path:
	// Adds a slash as a first char of the path if it doesn't exists
	// Removes the double slashes
	// Remove the trailing slash if it exists
	if ($path != '/') {
		$clean_path = array();

		foreach (explode(DIRECTORY_SEPARATOR, $path) as $dir) {
			if ($dir != '') {
				$clean_path[] = $dir;
			}
		}

		$path = '/' . implode(DIRECTORY_SEPARATOR, $clean_path);
	}

	// Check if path is allowed
	// @todo: valid directories (e.g. /htdocs/disabled/) are excluded (false positive)
	// @todo: This need to be reviewed on change of alias system
	$forbiddenDirnames = ('/^\/.*\/?(backups|disabled|errors|logs|phptmp)\/*$/i');
	$forbidden = preg_match($forbiddenDirnames, $path);
	if ($forbidden === 1) {
		set_page_message(
			tr('The path selected is a system path that cannot be secured.'),
			'warning'
		);
		return;
	}

	$domain = $_SESSION['user_logged'];

	// Check for existing directory
	// We need to use the virtual file system
	$vfs = new EasySCP_VirtualFileSystem($domain, $sql);
	$res = $vfs->exists($path);
	if (!$res) {
		set_page_message(
			tr("%s doesn't exist", $path),
			'error'
		);
		return;
	}

	$ptype = $_POST['ptype'];

	if (isset($_POST['users'])) {
		$users = $_POST['users'];
	}
	if (isset($_POST['groups'])) {
		$groups = $_POST['groups'];
	}
	$area_name = $_POST['paname'];

	$user_id = '';
	$group_id = '';
	if ($ptype == 'user') {
		for ($i = 0, $cnt_users = count($users); $i < $cnt_users; $i++) {
			if ($cnt_users == 1 || $cnt_users == $i + 1) {
				$user_id .= $users[$i];
				if ($user_id == '-1' || $user_id == '') {
					set_page_message(
						tr('You cannot protect area without selected user(s)!'),
						'warning'
					);
					return;
				}
			} else {
				$user_id .= $users[$i] . ',';
			}
		}
		$group_id = 0;
	} else {
		for ($i = 0, $cnt_groups = count($groups); $i < $cnt_groups; $i++) {
			if ($cnt_groups == 1 || $cnt_groups == $i + 1) {
				$group_id .= $groups[$i];
				if ($group_id == '-1' || $group_id == '') {
					set_page_message(
						tr('You cannot protect area without selected group(s)'),
						'warning'
					);
					return;
				}
			} else {
				$group_id .= $groups[$i] . ',';
			}
		}
		$user_id = 0;
	}
	// let's check if we have to update or to make new enrie
	$alt_path = $path . "/";
	$query = "
		SELECT
			`id`
		FROM
			`htaccess`
		WHERE
			`dmn_id` = ?
		AND
			(`path` = ? OR `path` = ?)
	;";

	$rs = exec_query($sql, $query, array($dmn_id, $path, $alt_path));
	$toadd_status = $cfg->ITEM_ADD_STATUS;
	$tochange_status = $cfg->ITEM_CHANGE_STATUS;

	if ($rs->recordCount() !== 0) {
		$update_id = $rs->fields['id'];
		// @todo Can we move $update_id to the prepared statement variables?
		$query = "
			UPDATE
				`htaccess`
			SET
				`user_id` = ?,
				`group_id` = ?,
				`auth_name` = ?,
				`path` = ?,
				`status` = ?
			WHERE
				`id` = '$update_id';
		";

		exec_query($sql, $query, array($user_id, $group_id, $area_name, $path, $tochange_status));
		send_request();
		set_page_message(tr('Protected area updated successfully!'), 'success');
	} else {
		$query = "
			INSERT INTO `htaccess`
				(`dmn_id`, `user_id`, `group_id`, `auth_type`, `auth_name`, `path`, `status`)
			VALUES
				(?, ?, ?, ?, ?, ?, ?);
		";

		exec_query($sql, $query, array($dmn_id, $user_id, $group_id, 'Basic' , $area_name, $path, $toadd_status));
		send_request();
		set_page_message(tr('Protected area created successfully!'), 'success');
	}

	user_goto('protected_areas.php');
}

/**
 * @param EasySCP_TemplateEngine $tpl
 * @param EasySCP_Database $sql
 * @param int $dmn_id
 */
function gen_protect_it($tpl, $sql, &$dmn_id) {

	$cfg = EasySCP_Registry::get('Config');

	if (!isset($_GET['id'])) {
		$edit = 'no';
		$type = 'user';
		$user_id = 0;
		$group_id = 0;
		$tpl->assign(
			array(
				'CDIR' => '',
				'PATH' => '',
				'AREA_NAME' => ''
			)
		);
	} else {
		$edit = 'yes';
		$ht_id = $_GET['id'];

		$tpl->assign('CDIR', $ht_id);
		$tpl->assign(
			array(
				'CDIR' => $ht_id,
				'UNPROTECT_IT' => true
			)
		);

		$query = "
			SELECT
				*
			FROM
				`htaccess`
			WHERE
				`dmn_id` = ?
			AND
				`id` = ?;
		";

		$rs = exec_query($sql, $query, array($dmn_id, $ht_id));

		if ($rs->recordCount() == 0) {
			user_goto('protected_areas_add.php');
		}

		$user_id = $rs->fields['user_id'];
		$group_id = $rs->fields['group_id'];
		$status = $rs->fields['status'];
		$path = $rs->fields['path'];
		$auth_name = $rs->fields['auth_name'];
		$ok_status = $cfg->ITEM_OK_STATUS;
		if ($status !== $ok_status) {
			set_page_message(
				tr('Protected area status should be OK if you want to edit it!'),
				'error'
			);
			user_goto('protected_areas.php');
		}

		$tpl->assign(
			array(
				'PATH' => tohtml($path),
				'AREA_NAME' => tohtml($auth_name),
			)
		);
		// let's get the htaccess management type
		if ($user_id !== 0 && $group_id == 0) {
			// we have only user htaccess
			$type = 'user';
		} else if ($group_id !== 0 && $user_id == 0) {
			// we have only groups htaccess
			$type = 'group';
		} else if ($group_id == 0 && $user_id == 0) {
			// we have unsr and groups htaccess
			$type = 'both';
		}
	}
	// this area is not secured by htaccess
	if ($edit == 'no' || $rs->recordCount() == 0 || $type == 'user') {
		$tpl->assign(
			array(
				'USER_CHECKED' => $cfg->HTML_CHECKED,
				'GROUP_CHECKED' => "",
				'USER_FORM_ELEMENS' => "false",
				'GROUP_FORM_ELEMENS' => "true",
			)
		);
	}

	if ($type == 'group') {
		$tpl->assign(
			array(
				'USER_CHECKED' => "",
				'GROUP_CHECKED' => $cfg->HTML_CHECKED,
				'USER_FORM_ELEMENS' => "true",
				'GROUP_FORM_ELEMENS' => "false",
			)
		);
	}

	$query = "
		SELECT
			*
		FROM
			`htaccess_users`
		WHERE
			`dmn_id` = ?;
	";

	$rs = exec_query($sql, $query, $dmn_id);

	if ($rs->recordCount() == 0) {
		$tpl->assign(
			array(
				'USER_VALUE'	=> "-1",
				'USER_LABEL'	=> tr('You have no users !'),
				'USER_SELECTED'	=> ''
			)
		);
	} else {
		while (!$rs->EOF) {
			$usr_id = explode(',', $user_id);
			for ($i = 0, $cnt_usr_id = count($usr_id); $i < $cnt_usr_id; $i++) {
				if ($edit == 'yes' && $usr_id[$i] == $rs->fields['id']) {
					$i = $cnt_usr_id + 1;
					$usr_selected = $cfg->HTML_SELECTED;
				} else {
					$usr_selected = '';
				}
			}

			$tpl->append(
				array(
					'USER_VALUE'	=> $rs->fields['id'],
					'USER_LABEL'	=> tohtml($rs->fields['uname']),
					'USER_SELECTED'	=> $usr_selected
				)
			);

			$rs->moveNext();
		}
	}

	$query = "
		SELECT
			*
		FROM
			`htaccess_groups`
		WHERE
			`dmn_id` = ?
	;";

	$rs = exec_query($sql, $query, $dmn_id);

	if ($rs->recordCount() == 0) {
		$tpl->assign(
			array(
				'GROUP_VALUE'	=> "-1",
				'GROUP_LABEL'	=> tr('You have no groups!'),
				'GROUP_SELECTED'=> ''
			)
		);
	} else {
		while (!$rs->EOF) {
			$grp_id = explode(',', $group_id);
			for ($i = 0, $cnt_grp_id = count($grp_id); $i < $cnt_grp_id; $i++) {
				if ($edit == 'yes' && $grp_id[$i] == $rs->fields['id']) {
					$i = $cnt_grp_id + 1;
					$grp_selected = $cfg->HTML_SELECTED;
				} else {
					$grp_selected = '';
				}
			}

			$tpl->append(
				array(
					'GROUP_VALUE'	=> $rs->fields['id'],
					'GROUP_LABEL'	=> tohtml($rs->fields['ugroup']),
					'GROUP_SELECTED'=> $grp_selected
				)
			);
			$rs->moveNext();
		}
	}
}
?>