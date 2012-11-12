<?php
/**
 * EasySCP a Virtual Hosting Control Panel
 * Copyright (C) 2010-2012 by Easy Server Control Panel - http://www.easyscp.net
 *
 * This work is licensed under the Creative Commons Attribution-NoDerivs 3.0 Unported License.
 * To view a copy of this license, visit http://creativecommons.org/licenses/by-nd/3.0/.
 *
 * @link 		http://www.easyscp.net
 * @author 		EasySCP Team
 */

/**
 * Handles DaemonCore requests.
 *
 * @param string $Input
 * @return boolean
 */
function DaemonCore($Input) {
	$retVal = null;
	switch ($Input) {
		case 'checkAll':
			System_Daemon::info('Running checkAllData subprocess.');
			$retVal = checkAllData();
			System_Daemon::info('Finished checkAllData subprocess.');
			break;
		case 'Restart':
			System_Daemon::info('Running Restart subprocess.');
			SocketHandler::Close(900);
			sleep(3);
			System_Daemon::restart();
			break;
		default:
			System_Daemon::warning("Don't know what to do with " . $Input);
			$retVal = false;
			break;
	}
	return $retVal;
}

/**
 * Checks all data eg. Domain, Mail.
 * 
 * @return boolean
 */
function checkAllData() {
	$retVal = null;
	$sql_query = "
	    SELECT
			domain_name
	    FROM
			domain
	    WHERE
	    	domain_status
	    IN (
			'toadd',
			'change',
			'restore',
			'toenable',
			'todisable'
		)
		ORDER BY
			domain_name
	";
	foreach (DB::query($sql_query) as $row) {
		require_once('DaemonDomain.php');
		$retVal = DaemonDomain($row['domain_name']);
		if($retVal == false){
			return false;
		}

	}
	return $retVal;
}
?>