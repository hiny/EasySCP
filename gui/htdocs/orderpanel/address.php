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

$cfg = EasySCP_Registry::get('Config');

$tpl = EasySCP_TemplateEngine::getInstance();
$template = 'orderpanel/address.tpl';

if (isset($_SESSION['user_id']) && isset($_SESSION['plan_id'])) {
	$user_id = $_SESSION['user_id'];
	$plan_id = $_SESSION['plan_id'];
} else {
	throw new EasySCP_Exception_Production(
		tr('You do not have permission to access this interface!')
	);
}

if (isset($_POST['uaction']) && $_POST['uaction'] == 'address')
	check_address_data($tpl);

if ((isset($_SESSION['fname']) && $_SESSION['fname'] != '')
	&& (isset($_SESSION['email']) && $_SESSION['email'] != '')
	&& (isset($_SESSION['lname']) && $_SESSION['lname'] != '')
	&& (isset($_SESSION['zip']) && $_SESSION['zip'] != '')
	&& (isset($_SESSION['city']) && $_SESSION['city'] != '')
	&& (isset($_SESSION['state']) && $_SESSION['state'] != '')
	&& (isset($_SESSION['country']) && $_SESSION['country'] != '')
	&& (isset($_SESSION['street1']) && $_SESSION['street1'] != '')
	&& (isset($_SESSION['phone']) && $_SESSION['phone'] != '')
	&& !isset($_GET['edit'])
	) {
	user_goto('chart.php');
}

// static page messages
$tpl->assign(
	array(
		'TR_ADDRESS'	=> tr('Enter Address'),
		'TR_FIRSTNAME'	=> tr('First name'),
		'TR_LASTNAME'	=> tr('Last name'),
		'TR_COMPANY'	=> tr('Company'),
		'TR_POST_CODE'	=> tr('Zip/Postal code'),
		'TR_CITY'		=> tr('City'),
		'TR_STATE'		=> tr('State/Province'),
		'TR_COUNTRY'	=> tr('Country'),
		'TR_STREET1'	=> tr('Street 1'),
		'TR_STREET2'	=> tr('Street 2'),
		'TR_EMAIL'		=> tr('Email'),
		'TR_PHONE'		=> tr('Phone'),
		'TR_GENDER'		=> tr('Gender'),
		'TR_MALE'		=> tr('Male'),
		'TR_FEMALE'		=> tr('Female'),
		'TR_UNKNOWN'	=> tr('Unknown'),
		'TR_FAX'		=> tr('Fax'),
		'TR_CONTINUE'	=> tr('Continue'),
		'NEED_FILLED'	=> tr('* denotes mandatory field.'),
		'THEME_CHARSET'	=> tr('encoding')
	)
);

gen_purchase_haf($tpl, $sql, $user_id);
gen_address($tpl, $sql, $user_id, $plan_id);

gen_page_message($tpl);

if ($cfg->DUMP_GUI_DEBUG) {
	dump_gui_debug($tpl);
}

$tpl->display($template);

unset_messages();

/*
 * functions start
 */

/**
 * @param EasySCP_pTemplate $tpl
 * @param EasySCP_Database $sql
 * @param int $user_id
 * @param int $plan_id
 */
function gen_address($tpl, $sql, $user_id, $plan_id) {

	$cfg = EasySCP_Registry::get('Config');

	if (isset($_POST['fname'])) {
		$first_name = clean_input($_POST['fname']);
	} else if (isset($_SESSION['fname'])) {
		$first_name = $_SESSION['fname'];
	} else {
		$first_name = '';
	}

	if (isset($_POST['lname'])) {
		$last_name = clean_input($_POST['lname']);
	} else if (isset($_SESSION['lname'])) {
		$last_name = $_SESSION['lname'];
	} else {
		$last_name = '';
	}

	if (isset($_POST['email'])) {
		$email = clean_input($_POST['email']);
	} else if (isset($_SESSION['email'])) {
		$email = $_SESSION['email'];
	} else {
		$email = '';
	}

	if (isset($_POST['gender']) && (in_array($_POST['gender'], array('M', 'F', 'U')))) {
		$gender = $_POST['gender'];
	} else if (isset($_SESSION['gender'])) {
		$gender = $_SESSION['gender'];
	} else {
		$gender = 'U';
	}

	if (isset($_POST['firm'])) {
		$company = clean_input($_POST['firm']);
	} else if (isset($_SESSION['firm'])) {
		$company = $_SESSION['firm'];
	} else {
		$company = '';
	}

	if (isset($_POST['zip'])) {
		$postal_code = clean_input($_POST['zip']);
	} else if (isset($_SESSION['zip'])) {
		$postal_code = $_SESSION['zip'];
	} else {
		$postal_code = '';
	}

	if (isset($_POST['city'])) {
		$city = clean_input($_POST['city']);
	} else if (isset($_SESSION['city'])) {
		$city = $_SESSION['city'];
	} else {
		$city = '';
	}

	if (isset($_POST['state'])) {
		$state = clean_input($_POST['state']);
	} else if (isset($_SESSION['state'])) {
		$state = $_SESSION['state'];
	} else {
		$state = '';
	}

	if (isset($_POST['country'])) {
		$country = clean_input($_POST['country']);
	} else if (isset($_SESSION['country'])) {
		$country = $_SESSION['country'];
	} else {
		$country = '';
	}

	if (isset($_POST['street1'])) {
		$street1 = clean_input($_POST['street1']);
	} else if (isset($_SESSION['street1'])) {
		$street1 = $_SESSION['street1'];
	} else {
		$street1 = '';
	}

	if (isset($_POST['street2'])) {
		$street2 = clean_input($_POST['street2']);
	} else if (isset($_SESSION['street2'])) {
		$street2 = $_SESSION['street2'];
	} else {
		$street2 = '';
	}

	if (isset($_POST['phone'])) {
		$phone = clean_input($_POST['phone']);
	} else if (isset($_SESSION['phone'])) {
		$phone = $_SESSION['phone'];
	} else {
		$phone = '';
	}

	if (isset($_POST['fax'])) {
		$fax = clean_input($_POST['fax']);
	} else if (isset($_SESSION['fax'])) {
		$fax = $_SESSION['fax'];
	} else {
		$fax = '';
	}

	$tpl->assign(
		array(
			'VL_USR_NAME'		=> tohtml($first_name),
			'VL_LAST_USRNAME'	=> tohtml($last_name),
			'VL_EMAIL'			=> tohtml($email),
			'VL_USR_FIRM'		=> tohtml($company),
			'VL_USR_POSTCODE'	=> tohtml($postal_code),
			'VL_USRCITY'		=> tohtml($city),
			'VL_USRSTATE'		=> tohtml($state),
			'VL_COUNTRY'		=> tohtml($country),
			'VL_STREET1'		=> tohtml($street1),
			'VL_STREET2'		=> tohtml($street2),
			'VL_PHONE'			=> tohtml($phone),
			'VL_FAX'			=> tohtml($fax),
			'VL_MALE'			=> (($gender === 'M') ? $cfg->HTML_SELECTED : ''),
			'VL_FEMALE'			=> (($gender === 'F') ? $cfg->HTML_SELECTED : ''),
			'VL_UNKNOWN'		=> (($gender == 'U') ? $cfg->HTML_SELECTED : '')
		)
	);
}

function check_address_data($tpl) {

	unset($_GET['edit']); // @todo why unset GET['edit']?
	if ((isset($_POST['fname']) && $_POST['fname'] != '')
			&& (isset($_POST['email']) && $_POST['email'] != '')
			&& chk_email($_POST['email'])
			&& (isset($_POST['lname']) && $_POST['lname'] != '')
			&& (isset($_POST['zip']) && $_POST['zip'] != '')
			&& (isset($_POST['city']) && $_POST['city'] != '')
			&& (isset($_POST['country']) && $_POST['country'] != '')
			&& (isset($_POST['street1']) && $_POST['street1'] != '')
			&& (isset($_POST['phone']) && $_POST['phone'] != '')
	) {
		$_SESSION['fname']		= clean_input($_POST['fname']);
		$_SESSION['lname']		= clean_input($_POST['lname']);
		$_SESSION['email']		= clean_input($_POST['email']);
		$_SESSION['zip']		= clean_input($_POST['zip']);
		$_SESSION['city']		= clean_input($_POST['city']);
		$_SESSION['state']		= clean_input($_POST['state']);
		$_SESSION['country']	= clean_input($_POST['country']);
		$_SESSION['street1']	= clean_input($_POST['street1']);
		$_SESSION['phone']		= clean_input($_POST['phone']);

		if (isset($_POST['firm']) && $_POST['firm'] != '') {
			$_SESSION['firm'] = clean_input($_POST['firm']);
		}

		if (isset($_POST['gender'])
				&& get_gender_by_code($_POST['gender'], true) !== null) {
			$_SESSION['gender'] = $_POST['gender'];
		} else {
			$_SESSION['gender'] = '';
		}

		if (isset($_POST['street2']) && $_POST['street2'] != '') {
			$_SESSION['street2'] = clean_input($_POST['street2']);
		}

		if (isset($_POST['fax']) && $_POST['fax'] != '') {
			$_SESSION['fax'] = clean_input($_POST['fax']);
		}

		user_goto('chart.php');
	} else {
		set_page_message(tr('Please fill out all needed fields!'), 'warning');
		$_GET['edit'] = "yes";
	}
}

// functions end
?>