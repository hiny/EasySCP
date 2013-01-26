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
			<li><a href="server_statistic.php">{$TR_MENU_OVERVIEW}</a></li>
			<li><a href="reseller_statistics.php">{$TR_RESELLER_STATISTICS}</a></li>
			<li><a>{$TR_RESELLER_USER_STATISTICS}</a></li>
		</ul>
	</div>
	<div class="left_menu">{include file="$MENU"}</div>
	<div class="main">
		{if isset($MESSAGE)}
		<div class="{$MSG_TYPE}">{$MESSAGE}</div>
		{/if}
		<h2 class="stats"><span>{$TR_RESELLER_USER_STATISTICS}</span></h2>
		<form action="reseller_user_statistics.php?psi={$POST_PREV_PSI}" method="post" id="admin_reseller_user_statistics">
			<fieldset>
				<label for="month">{$TR_MONTH}</label>
				<select name="month" id="month">
					{section name=i loop=$MONTH_VALUE}
					<option {$MONTH_SELECTED[i]}>{$MONTH_VALUE[i]}</option>
					{/section}
				</select>
				<label for="year">{$TR_YEAR}</label>
				<select name="year" id="year">
					{section name=i loop=$YEAR_VALUE}
					<option {$YEAR_SELECTED[i]}>{$YEAR_VALUE[i]}</option>
					{/section}
				</select>
				<input type="hidden" name="name" value="{$VALUE_NAME}" />
				<input type="hidden" name="rid" value="{$VALUE_RID}" />
				<input type="hidden" name="uaction" value="show" />
				<input type="submit" name="Submit" value="{$TR_SHOW}" />
			</fieldset>
		</form>
		{if isset($DOMAIN_NAME)}
		<table>
			<thead>
				<tr>
					<th>{$TR_DOMAIN_NAME}</th>
					<th>{$TR_TRAFF}</th>
					<th>{$TR_DISK}</th>
					<th>{$TR_WEB}</th>
					<th>{$TR_FTP_TRAFF}</th>
					<th>{$TR_SMTP}</th>
					<th>{$TR_POP3}</th>
					<th>{$TR_SUBDOMAIN}</th>
					<th>{$TR_ALIAS}</th>
					<th>{$TR_MAIL}</th>
					<th>{$TR_FTP}</th>
					<th>{$TR_SQL_DB}</th>
					<th>{$TR_SQL_USER}</th>
				</tr>
			</thead>
			<tbody>
				{section name=i loop=$DOMAIN_NAME}
				<tr>
					<td><a href="domain_statistics.php?month={$MONTH[i]}&amp;year={$YEAR[i]}&amp;domain_id={$DOMAIN_ID[i]}" class="icon i_domain">{$DOMAIN_NAME[i]}</a></td>
					<td><div class="graph"><span style="width: {$TRAFF_PERCENT[i]}%">&nbsp;</span><strong>{$TRAFF_SHOW_PERCENT[i]}&nbsp;%</strong></div>{$TRAFF_MSG[i]}</td>
					<td><div class="graph"><span style="width: {$DISK_PERCENT[i]}%">&nbsp;</span><strong>{$DISK_SHOW_PERCENT[i]}&nbsp;%</strong></div>{$DISK_MSG[i]}</td>
					<td>{$WEB[i]}</td>
					<td>{$FTP[i]}</td>
					<td>{$SMTP[i]}</td>
					<td>{$POP3[i]}</td>
					<td>{$SUB_MSG[i]}</td>
					<td>{$ALS_MSG[i]}</td>
					<td>{$MAIL_MSG[i]}</td>
					<td>{$FTP_MSG[i]}</td>
					<td>{$SQL_DB_MSG[i]}</td>
					<td>{$SQL_USER_MSG[i]}</td>
				</tr>
				{/section}
			</tbody>
		</table>
		<div class="paginator">
			{if !isset($SCROLL_NEXT_GRAY)}
			<span class="icon i_next_gray">&nbsp;</span>
			{/if}
			{if !isset($SCROLL_NEXT)}
			<a href="reseller_user_statistics.php?psi={$NEXT_PSI}&amp;month={$MONTH}&amp;year={$YEAR}" title="next" class="icon i_next">next</a>
			{/if}
			{if !isset($SCROLL_PREV_GRAY)}
			<span class="icon i_prev_gray">&nbsp;</span>
			{/if}
			{if !isset($SCROLL_PREV)}
			<a href="reseller_user_statistics.php?psi={$PREV_PSI}&amp;month={$MONTH}&amp;year={$YEAR}" title="previous" class="icon i_prev">previous</a>
			{/if}
		</div>

		{else}
		<div class="info">{$TR_NO_DOMAINS}</div>
		{/if}
	</div>
{include file='admin/footer.tpl'}