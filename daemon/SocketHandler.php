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

/**
 * Statische Klasse für Socket zugriffe.
 *
 */
class SocketHandler {

	private static $Socket;
	private static $Socket_Bind;
	private static $Client = Null;

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
		return socket_write(self::$Client, $MSG."\n");
	}

	static public function Read()
	{
		return @socket_read(self::$Client, 1024, PHP_NORMAL_READ);
	}

	static public function CloseClient($Status)
	{
		if (self::$Client != Null) {
			@socket_shutdown(self::$Client, 2); //Schließe den Socket in beiden Richtungen
			socket_close(self::$Client);
			self::$Client = Null;
		}
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