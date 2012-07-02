<?php
/**
 * @param $Input
 * @return bool
 */
function DaemonMail($Input) {

	$sql_param = array(
		':domain_id' => $Input
	);
	$sql_query = "
		SELECT
			d.domain_name,
			m.*
		FROM
			domain d,
			mail_users m
		WHERE
			m.domain_id = d.domain_id
		AND
			d.domain_id = :domain_id
		AND
			status <> 'ok'
	";

	// Einzelne Schreibweise
	DB::prepare($sql_query);
	//$result = DB::prepare($sql_query);
	//$result->execute($sql_param);
	//while( $row = $result->fetch() ){
	foreach (DB::execute($sql_param) as $row) {
			switch($row['status']){
			case 'change':
				DaemonMailChange($row);
				break;
			case 'delete':
				DaemonMailDelete($row);
				break;
			case 'ok':
				System_Daemon::info('Nichts zu tun');
				break;
			case 'restore':
				break;
			case 'toadd':
				DaemonMailAdd($row);
				break;
			case 'todisable':
				break;
			case 'toenable':
				break;
			default:
				System_Daemon::info('Unbekannter Mail Status');
		}
	}

	/*
	$cfg = EasySCP_Registry::get('Config');

	if ( DB::getInstance() ){
		System_Daemon::info('Database access success.');
	}

	$sql_param = array(
		':domain_name' => $Input
	);
	$sql_query = "
		SELECT
			d.domain_name,
			d.domain_gid,
			d.domain_uid,
			d.domain_php,
			d.domain_cgi,
			i.ip_number
		FROM
			domain d,
			server_ips i
		WHERE
			d.domain_name = :domain_name
		AND
			d.domain_ip_id = i.ip_id

	";

	// Einzelne Schreibweise
	DB::prepare($sql_query);
	if ( $row = DB::execute($sql_param, true) ){
		require_once('Smarty/Smarty.class.php');
		$tpl = new Smarty();
		$tpl->caching = false;
		$tpl->setTemplateDir(
			array(
				'EasySCP' => '/etc/easyscp/'
			)
		);
		$tpl->setCompileDir('/tmp/templates_c/');

		// echo var_dump($row);
		$tpl->assign(
			array(
				"DOMAIN_IP"					=>	$row['ip_number'],
				"DOMAIN_UID"				=>	'vu'.$row['domain_uid'],
				"DOMAIN_GID"				=>	'vu'.$row['domain_gid'],
				"DOMAIN_NAME"				=>	$row['domain_name'],
				"WWW_DIR"					=>	$cfg->APACHE_WWW_DIR,
				"BASE_SERVER_VHOST"			=>	$cfg->BASE_SERVER_VHOST,
				"AWSTATS"					=>	($cfg->AWSTATS_ACTIVE == 'yes') ? true : false,
				"DOMAIN_CGI"				=>	($row['domain_cgi'] == 'yes') ? true : false,
				"DOMAIN_PHP"				=>	($row['domain_php'] == 'yes') ? true : false,
				"CUSTOM_SITES_CONFIG_DIR"	=>	$cfg->APACHE_CUSTOM_SITES_CONFIG_DIR
			)
		);

		$config = $tpl->fetch("apache/parts/vhost.tpl");

		file_put_contents($cfg->APACHE_SITES_DIR.'/'.$Input.'.conf', $config);

	}

	*/

	System_Daemon::info('Alles Ok');

	return true;
}

function DaemonMailAdd($row) {
	$mail_ok = true;
	if ( $row['mail_type'] == 'normal_mail'){
		DaemonMailAdd_normal_mail($row);
	}

	if ( $row['mail_type'] == 'normal_forward'){
		DaemonMailAdd_normal_forward($row);
	}

	if ( $row['mail_type'] == 'normal_mail,normal_forward'){
		DaemonMailAdd_normal_mail($row);
		DaemonMailAdd_normal_forward($row);
	}

	if ( $mail_ok ){
		$sql_param = array(
			':mail_id'=> $row['mail_id']
		);
		$sql_query = "
			UPDATE
				`easyscp`.`mail_users`
			SET
				`status` = 'ok'
			WHERE
				`mail_id` = :mail_id
		";
		DB::prepare($sql_query);
		DB::execute($sql_param);
	}
}

function DaemonMailChange($row) {
	$mail_ok = true;
	if ( $row['mail_type'] == 'normal_mail'){
		DaemonMailDelete_normal_mail($row);
		DaemonMailAdd_normal_mail($row);
	}

	if ( $mail_ok ){
		$sql_param = array(
			':mail_id'=> $row['mail_id']
		);
		$sql_query = "
			UPDATE
				`easyscp`.`mail_users`
			SET
				`status` = 'ok'
			WHERE
				`mail_id` = :mail_id
		";
		DB::prepare($sql_query);
		DB::execute($sql_param);
	}
}

function DaemonMailDelete($row) {
	$mail_ok = true;
	if ( $row['mail_type'] == 'normal_mail'){
		DaemonMailDelete_normal_mail($row);
	}

	if ( $row['mail_type'] == 'normal_forward'){
		DaemonMailDelete_normal_forward($row);
	}

	if ( $row['mail_type'] == 'normal_mail,normal_forward'){
		DaemonMailDelete_normal_mail($row);
		DaemonMailDelete_normal_forward($row);
	}

	if ( $mail_ok ){
		$cfg = EasySCP_Registry::get('Config');

		System_Daemon::info('Delete Mail User Directory ' . $cfg['MTA_VIRTUAL_MAIL_DIR'] . '/' . $row['domain_name'] . '/' . $row['mail_acc']);
		if (file_exists($cfg['MTA_VIRTUAL_MAIL_DIR'] . '/' . $row['domain_name'] . '/' . $row['mail_acc'])){
			exec('rm -R ' . $cfg['MTA_VIRTUAL_MAIL_DIR'] . '/' . $row['domain_name'] . '/' . $row['mail_acc']);
		}

		$sql_param = array(
			':mail_id'=> $row['mail_id']
		);
		$sql_query = "
			DELETE FROM
				`easyscp`.`mail_users`
			WHERE
				`mail_id` = :mail_id
		";
		DB::prepare($sql_query);
		DB::execute($sql_param);
	}
}

function DaemonMailAdd_normal_mail($row) {
	$sql_param = array(
		':email'=> $row['mail_addr'],
		':pass' => decrypt_db_password($row['mail_pass'])
	);
	$sql_query = "
		INSERT INTO
			`mail`.`users`
				(`email`, `password`)
		VALUES
			(:email, ENCRYPT(:pass))
	";
	DB::prepare($sql_query);
	DB::execute($sql_param);
}

function DaemonMailAdd_normal_forward($row) {
	if(strpos($row['mail_forward'], ",") !== false){
		$row['mail_forward'] = str_replace(",", " ", $row['mail_forward']);
	}
	$sql_param = array(
		':source'		=> $row['mail_acc'] . '@' . $row['domain_name'],
		':destination'	=> $row['mail_forward']
	);
	$sql_query = "
		INSERT INTO
			`mail`.`forwardings`
				(`source`, `destination`)
		VALUES
			(:source, :destination)
	";
	DB::prepare($sql_query);
	DB::execute($sql_param);
}

function DaemonMailDelete_normal_mail($row) {
	$sql_param = array(
		':email'=> $row['mail_addr']
	);
	$sql_query = "
		DELETE FROM
			`mail`.`users`
		WHERE
			`email` = :email
	";
	DB::prepare($sql_query);
	DB::execute($sql_param);
}

function DaemonMailDelete_normal_forward($row) {
	$sql_param = array(
		':source'		=> $row['mail_acc'] . '@' . $row['domain_name'],
		':destination'	=> $row['mail_forward']
	);
	$sql_query = "
		DELETE FROM
			`mail`.`forwardings`
		WHERE
			`source` = :source
		AND
			`destination` = :destination
	";
	DB::prepare($sql_query);
	DB::execute($sql_param);
}
?>