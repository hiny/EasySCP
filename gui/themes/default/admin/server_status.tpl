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
			<li><a>{$TR_SERVER_STATUS}</a></li>
		</ul>
	</div>
	<div class="left_menu">{include file="$MENU"}</div>
	<div class="main">
		{if isset($MESSAGE)}
		<div class="{$MSG_TYPE}">{$MESSAGE}</div>
		{/if}
		<h2 class="serverstatus"><span>{$TR_SERVER_STATUS}</span></h2>
		<table>
			<tr>
				<th>{$TR_HOST}</th>
				<th>{$TR_SERVICE}</th>
				<th>{$TR_STATUS}</th>
			</tr>
			{section name=i loop=$HOST}
			<tr>
				<td class="{$CLASS[i]}">{$HOST[i]} (Port {$PORT[i]})</td>
				<td class="{$CLASS[i]}">{$SERVICE[i]}</td>
				<td class="{$CLASS[i]}">{$STATUS[i]}</td>
			</tr>
			{/section}
		</table>
	</div>
{include file='admin/footer.tpl'}