<?php
/**
 * EasySCP a Virtual Hosting Control Panel
 * Copyright (C) 2010-2012 by Easy Server Control Panel - http://www.easyscp.net
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

/**
 * Statische Klasse für Socketzugriffe.
 *
 */
class SocketHandler {

	private static $Socket;
	private static $Socket_Bind;
	private static $Client;

	static public function Create($Interface, $Type, $Protocol) {
		self::$Socket = socket_create($Interface, $Type, $Protocol);
		if (self::$Socket !== false)
		{
			return true;
		} else {
			return false;
		}
	}

	static public function Bind($MyAddress="127.0.0.1", $MyPort) {
		self::$Socket_Bind = socket_bind(self::$Socket, $MyAddress, $MyPort);
		if (self::$Socket_Bind !== false)
		{
			return true;
		} else {
			return false;
		}
	}

	static public function Listen()
	{
		if (socket_listen(self::$Socket) !== FALSE)
		{
			return true;
		} else {
			return false;
		}
	}

	static public function Accept()
	{
		if (self::$Client = @socket_accept(self::$Socket))
		{

			return self::$Client;
		} else {
			return false;
		}
	}

	static public function Write($MSG)
	{
		return socket_write(self::$Client, $MSG);
	}

	static public function Read()
	{
		return @socket_read(self::$Client, 1024, PHP_NORMAL_READ);
	}

	static public function CloseClient($Status)
	{
		global $StatusMap;

		$Close_MSG = $Status." ".$StatusMap[$Status]."\n";
		self::Write($Close_MSG);
		socket_close(self::$Client);
	}

	static public function Close($Status)
	{
		self::CloseClient($Status);
		socket_close(self::$Socket);
	}

	static public function Block($block)
	{
	    if ($block === true){
		// Block socket type
		socket_set_block(self::$Socket);
	    } else {
		// Non block socket type
		socket_set_nonblock(self::$Socket);
	    }
	}
}
?>