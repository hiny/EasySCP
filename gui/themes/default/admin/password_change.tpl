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
			<li><a href="index.php">{$TR_MENU_OVERVIEW}</a></li>
			<li><a>{$TR_CHANGE_PASSWORD}</a></li>
		</ul>
	</div>
	<div class="left_menu">{include file="$MENU"}</div>
	<div class="main">
		{if isset($MESSAGE)}
		<div class="{$MSG_TYPE}">{$MESSAGE}</div>
		{/if}
		<h2 class="password"><span>{$TR_CHANGE_PASSWORD}</span></h2>
		<form action="password_change.php" method="post" id="admin_password_change">
			<table>
				<tr>
					<td><label for="curr_pass">{$TR_CURR_PASSWORD}</label></td>
					<td><input type="password" name="curr_pass" id="curr_pass" value=""/></td>
				</tr>
				<tr>
					<td><label for="pass">{$TR_PASSWORD}</label></td>
					<td><input type="password" name="pass" id="pass" value="" /></td>
				</tr>
				<tr>
					<td><label for="pass_rep">{$TR_PASSWORD_REPEAT}</label></td>
					<td><input type="password" name="pass_rep" id="pass_rep" value="" /></td>
				</tr>
			</table>
			<div class="buttons">
				<input type="hidden" name="uaction" value="updt_pass" />
				<input name="Submit" type="submit" value="{$TR_UPDATE_PASSWORD}" />
			</div>
		</form>
	</div>
{include file='admin/footer.tpl'}