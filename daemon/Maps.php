<?php
/**
 * EasySCP a Virtual Hosting Control Panel
 * Copyright (C) 2010-2013 by Easy Server Control Panel - http://www.easyscp.net
 *
 * This work is licensed under the Creative Commons Attribution-NoDerivs 3.0 Unported License.
 * To view a copy of this license, visit http://creativecommons.org/licenses/by-nd/3.0/.
 *
 * @link 		http://www.easyscp.net
 * @author 		EasySCP Team
 */
 
	$ProcedureMap = array(
		'100'	=>	'DaemonCore',
		'110'	=>	'DaemonDomain',
		'120'	=>	'DaemonNameserver',
		'130'	=>	'DaemonMail',
		'140'	=>	'DaemonFTP',
		'150'	=>	'DaemonSQL',
		'160'	=>	'DaemonSystem'
	);

	$StatusMap = array(
		'100'	=>	'CORE',
		'110'	=>	'DOMAIN',
		'120'	=>	'DNS',
		'130'	=>	'MAIL',
		'140'	=>	'FTP',
		'150'	=>	'SQL',
		'160'	=>	'SYSTEM',
		'200'	=>	'OK',
		'201'	=>	'WAITING',
		'202'	=>	'AUTHENTICATED',
		'203'	=>	'AUTHREQUIRED',
		'204'	=>	'CLOSING',
		'404'	=>	'DOMAIN NOT FOUND',
		'500'	=>	'INTERNAL ERROR',
		'501'	=>	'DATABASE SERVER GONE'
	);
?>