{include file='admin/header.tpl'}
<body>
	<div class="header">
		{include file="$MAIN_MENU"}
		<div class="logo">
			<img src="{$THEME_COLOR_PATH}/images/easyscp_logo.png" alt="EasySCP logo" />
			<img src="{$THEME_COLOR_PATH}/images/easyscp_webhosting.png" alt="EasySCP - Easy Server Control Panel" />
		</div>
	</div>
	<div class="location">
		<ul class="location-menu">
			<li><a href="../index.php?logout" class="logout">{$TR_MENU_LOGOUT}</a></li>
		</ul>
		<ul class="path">
			<li><a href="settings.php">{$TR_MENU_OVERVIEW}</a></li>
			<li><a>{$TR_SERVER_TRAFFIC_SETTINGS}</a></li>
		</ul>
	</div>
	<div class="left_menu">{include file="$MENU"}</div>
	<div class="main">
		{if isset($MESSAGE)}
		<div class="{$MSG_TYPE}">{$MESSAGE}</div>
		{/if}
		<h2 class="general"><span>{$TR_SERVER_TRAFFIC_SETTINGS}</span></h2>
		<form action="settings_server_traffic.php" method="post" id="admin_modify_server_traffic_settings">
			<fieldset>
				<legend>{$TR_SET_SERVER_TRAFFIC_SETTINGS}</legend>
				<table>
					<tr>
						<td><label for="max_traffic">{$TR_MAX_TRAFFIC}</label></td>
						<td><input type="text" name="max_traffic" id="max_traffic" value="{$MAX_TRAFFIC}" /></td>
					</tr>
					<tr>
						<td><label for="traffic_warning">{$TR_WARNING}</label></td>
						<td><input type="text" name="traffic_warning" id="traffic_warning" value="{$TRAFFIC_WARNING}" /></td>
					</tr>
				</table>
			</fieldset>
			<div class="buttons">
				<input type="hidden" name="uaction" value="modify" />
				<input type="submit" name="Submit"  value="{$TR_MODIFY}" />
			</div>
		</form>
	</div>
{include file='admin/footer.tpl'}