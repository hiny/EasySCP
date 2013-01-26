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
			<li><a>{$TR_EMAIL_SETUP}</a></li>
		</ul>
	</div>
	<div class="left_menu">{include file="$MENU"}</div>
	<div class="main">
		{if isset($MESSAGE)}
		<div class="{$MSG_TYPE}">{$MESSAGE}</div>
		{/if}
		<h2 class="email"><span>{$TR_EMAIL_SETUP}</span></h2>
		<form action="settings_welcome_mail.php" method="post" id="admin_email_setup">
			<fieldset>
				<legend>{$TR_MESSAGE_TEMPLATE_INFO}</legend>
				<table>
					<tr>
						<td>{$TR_USER_LOGIN_NAME}</td>
						<td>{literal}{USERNAME}{/literal}</td>
					</tr>
					<tr>                        
						<td>{$TR_USER_PASSWORD}</td>
						<td>{literal}{PASSWORD}{/literal}</td>
					</tr>
					<tr>
						<td>{$TR_USER_REAL_NAME}</td>
						<td>{literal}{NAME}{/literal}</td>
					</tr>
					<tr>
						<td>{$TR_USERTYPE}</td>
						<td>{literal}{USERTYPE}{/literal}</td>
					</tr>
					<tr>
						<td>{$TR_BASE_SERVER_VHOST}</td>
						<td>{literal}{BASE_SERVER_VHOST}{/literal}</td>
					</tr>
					<tr>
						<td>{$TR_BASE_SERVER_VHOST_PREFIX}</td>
						<td>{literal}{BASE_SERVER_VHOST_PREFIX}{/literal}</td>
					</tr>
				</table>
			</fieldset>
			<fieldset>
				<legend>{$TR_MESSAGE_TEMPLATE}</legend>
				<table>
					<tr>
						<td>&nbsp;</td>
						<td><label for="auto_subject"><b>{$TR_SUBJECT}</b></label></td>
						<td><input type="text" name="auto_subject" id="auto_subject" value="{$SUBJECT_VALUE}" /></td>                        
					</tr>
					<tr>
						<td>&nbsp;</td>
						<td><label for="auto_message"><b>{$TR_MESSAGE}</b></label></td>
						<td><textarea name="auto_message" id="auto_message" cols="80" rows="30">{$MESSAGE_VALUE}</textarea></td>
					</tr>
					<tr>
						<td>{$TR_SENDER_EMAIL}</td>
						<td colspan="2" class="content">{$SENDER_EMAIL_VALUE}</td>
					</tr>
					<tr>
						<td>{$TR_SENDER_NAME}</td>
						<td colspan="2">{$SENDER_NAME_VALUE}</td>
					</tr>
				</table>
			</fieldset>
            <div class="buttons">
				<input type="hidden" name="uaction" value="email_setup" />
                <input type="submit" name="Submit" value="{$TR_APPLY_CHANGES}" />
			</div>
		</form>
	</div>
{include file='admin/footer.tpl'}