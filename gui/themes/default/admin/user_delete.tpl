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
			<li><a href="manage_users.php">{$TR_MENU_OVERVIEW}</a></li>
			<li><a>{$TR_DELETE_DOMAIN}</a></li>
		</ul>
	</div>
	<div class="left_menu">{include file="$MENU"}</div>
	<div class="main">
		{if isset($MESSAGE)}
		<div class="{$MSG_TYPE}">{$MESSAGE}</div>
		{/if}
		<h2 class="domains"><span>{$TR_DELETE_DOMAIN} - {$DOMAIN_NAME}</span></h2>
		<fieldset>
		<legend>{$TR_DOMAIN_SUMMARY}</legend>
			{if isset($MAIL_ADDR)}
			<table>
				<thead>
					<tr>
						<th colspan="2">{$TR_DOMAIN_EMAILS}</th>
					</tr>
				</thead>
				<tbody>
					{section name=i loop=$MAIL_ADDR}
					<tr>
						<td style="width: 350px;">{$MAIL_ADDR[i]}</td>
						<td>{$MAIL_TYPE[i]}</td>
					</tr>
					{/section}
				</tbody>
			</table>
			{/if}
			{if isset($FTP_USER)}
			<table>
				<thead>
					<tr>
						<th colspan="2">{$TR_DOMAIN_FTPS}</th>
					</tr>
				</thead>
				<tbody>
					{section name=i loop=$FTP_USER}
					<tr>
						<td style="width: 350px;">{$FTP_USER[i]}</td>
						<td>{$FTP_HOME[i]}</td>
					</tr>
					{/section}
				</tbody>
			</table>
			{/if}
			{if isset($ALS_NAME)}
			<table>
				<thead>
					<tr>
						<th colspan="2">{$TR_DOMAIN_ALIASES}</th>
					</tr>
				</thead>
				<tbody>
					{section name=i loop=$ALS_NAME}
					<tr>
						<td style="width: 350px;">{$ALS_NAME[i]}</td>
						<td>{$ALS_MNT[i]}</td>
					</tr>
					{/section}
				</tbody>
			</table>
			{/if}
			{if isset($SUB_NAME)}
			<table>
				<thead>
					<tr>
						<th colspan="2">{$TR_DOMAIN_SUBS}</th>
					</tr>
				</thead>
				<tbody>
					{section name=i loop=$SUB_NAME}
					<tr>
						<td style="width: 350px;">{$SUB_NAME[i]}</td>
						<td>{$SUB_MNT[i]}</td>
					</tr>
					{/section}
				</tbody>
			</table>
			{/if}
			{if isset($DB_NAME)}
			<table>
				<thead>
					<tr>
						<th colspan="2">{$TR_DOMAIN_DBS}</th>
					</tr>
				</thead>
				<tbody>
					{section name=i loop=$DB_NAME}
					<tr>
						<td style="width: 350px;">{$DB_NAME[i]}</td>
						<td>{$DB_USERS[i]}</td>
					</tr>
					{/section}
				</tbody>
			</table>
			{/if}
			<form action="user_delete.php" method="post" id="admin_delete_domain">
				<div class="buttons">
					<input type="hidden" name="domain_id" value="{$DOMAIN_ID}" />
					<div class="info">{$TR_REALLY_WANT_TO_DELETE_DOMAIN}</div><br />
					<input type="checkbox" name="delete" id="delete" value="1" /> <label for="delete">{$TR_YES_DELETE_DOMAIN}</label><br />
					<br />
					<input type="submit" name="Submit" value="{$TR_BUTTON_DELETE}" />
				</div>
			</form>
		</fieldset>
	</div>
{include file='admin/footer.tpl'}