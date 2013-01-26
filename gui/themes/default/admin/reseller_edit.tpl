{include file='admin/header.tpl'}
<body>
	<script type="text/javascript">
	/*<![CDATA[*/

	/*
 	 * Global variable - TRUE if a password was generated, FALSE otherwise
 	 */
	gpwd=false;

	$(document).ready(function(){
		jQuery(':password').each(
			function(i) {
				// We ensure's the passwords fields are empty after on load because several
				// browsers fill them with the cached password (eg. Gecko's based browsers)
				jQuery(this).val('').
				// Create text input field to display generated password on mouseover
				mouseover(
					function(){
						if(gpwd){
							// First, hide the password field
							jQuery(this).hide();
							// Now create the text input field
							jQuery('<input />').attr({ type:'text',name:'ipwd'+i }).
							css({ float:'left' }).
							val(jQuery(this).val()).
							insertAfter('input[name=pass'+i+']').select().
							// Create tooltip linked to the create text input field
							EasySCPtooltips({ msg:'{$TR_CTRLC}'}).
							// Restore input password field on mouseout
							mouseout(function(){ jQuery(this).remove();jQuery(':password').show(); });
						}
					}
				);
			}
		);

		// Configure the request for password generation
		jQuery.ajaxSetup({
			url: jQuery(location).attr('pathname'),
			type:'POST',
			data:'edit_id={$EDIT_ID}&uaction=genpass',
			datatype:'text',
			beforeSend:function(xhr){ xhr.setRequestHeader('Accept','text/plain'); },
			success:function(r){ jQuery(':password').val(r).attr('readonly',true);gpwd=true; },
			error:ispCPajxError
		});

		// Adds event handler for the password generation button
		jQuery('#genpass').click(function(){ jQuery.ajax(); }).attr('disabled',false);

		// Adds event handler for the reset button
		jQuery('#pwdreset').click(
			function(){
				gpwd=false;
				jQuery(':password').val('').attr('readonly',false);
			}
		);

		// Disable the 'Enter' key to prevent multiples validation/updates process
		jQuery(':input').live('keypress',function(e){
			if(e.keyCode==13){ e.preventDefault();alert('{$TR_EVENT_NOTICE}');}
		});
	});
	/*]]>*/
	</script>
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
			<li><a href="manage_users.php">{$TR_MENU_MANAGE_USERS}</a></li>
			<li><a>{$TR_EDIT_RESELLER}</a></li>
		</ul>
	</div>
	<div class="left_menu">{include file="$MENU"}</div>
	<div class="main">
		{if isset($MESSAGE)}
		<div class="{$MSG_TYPE}">{$MESSAGE}</div>
		{/if}
		<h2 class="user"><span>{$TR_EDIT_RESELLER}</span></h2>
		<form action="reseller_edit.php" method="post" id="admin_edit_reseller">
			<fieldset>
				<legend>{$TR_CORE_DATA}</legend>
				<table>
					<tr>
						<td>{$TR_USERNAME}</td>
						<td>{$USERNAME}</td>
					</tr>
					<tr>
						<td><label for="pass0">{$TR_PASSWORD}</label></td>
						<td>
							<input type="password" name="pass0" id="pass0" value="{$VAL_PASSWORD}" style="float:left;" />
							<input type="button" name="pwdreset" id="pwdreset" value="{$TR_RESET}" style="float:right;margin-right:10px;" />
							<input type="button" name="genpass" id="genpass" value="{$TR_PASSWORD_GENERATE}" style="float:right;" />
						</td>
					</tr>
					<tr>
						<td><label for="pass1">{$TR_PASSWORD_REPEAT}</label></td>
						<td><input type="password" name="pass1" id="pass1" value="{$VAL_PASSWORD}" /></td>
					</tr>
					<tr>
						<td><label for="email">{$TR_EMAIL}</label></td>
						<td><input type="text" name="email" id="email" value="{$EMAIL}" /></td>
					</tr>
					<tr>
						<td><label for="nreseller_max_domain_cnt">{$TR_MAX_DOMAIN_COUNT}</label></td>
						<td><input type="text" name="nreseller_max_domain_cnt" id="nreseller_max_domain_cnt" value="{$MAX_DOMAIN_COUNT}" /></td>
					</tr>
					<tr>
						<td><label for="nreseller_max_subdomain_cnt">{$TR_MAX_SUBDOMAIN_COUNT}</label></td>
						<td><input type="text" name="nreseller_max_subdomain_cnt" id="nreseller_max_subdomain_cnt" value="{$MAX_SUBDOMAIN_COUNT}" /></td>
					</tr>
					<tr>
						<td><label for="nreseller_max_alias_cnt">{$TR_MAX_ALIASES_COUNT}</label></td>
						<td><input type="text" name="nreseller_max_alias_cnt" id="nreseller_max_alias_cnt" value="{$MAX_ALIASES_COUNT}" /></td>
					</tr>
					<tr>
						<td><label for="nreseller_max_mail_cnt">{$TR_MAX_MAIL_USERS_COUNT}</label></td>
						<td><input type="text" name="nreseller_max_mail_cnt" id="nreseller_max_mail_cnt" value="{$MAX_MAIL_USERS_COUNT}"/></td>
					</tr>
					<tr>
						<td><label for="nreseller_max_ftp_cnt">{$TR_MAX_FTP_USERS_COUNT}</label></td>
						<td><input type="text" name="nreseller_max_ftp_cnt" id="nreseller_max_ftp_cnt" value="{$MAX_FTP_USERS_COUNT}"/></td>
					</tr>
					<tr>
						<td><label for="nreseller_max_sql_db_cnt">{$TR_MAX_SQLDB_COUNT}</label></td>
						<td><input type="text" name="nreseller_max_sql_db_cnt" id="nreseller_max_sql_db_cnt" value="{$MAX_SQLDB_COUNT}"/></td>
					</tr>
					<tr>
						<td><label for="nreseller_max_sql_user_cnt">{$TR_MAX_SQL_USERS_COUNT}</label></td>
						<td><input type="text" name="nreseller_max_sql_user_cnt" id="nreseller_max_sql_user_cnt" value="{$MAX_SQL_USERS_COUNT}"/></td>
					</tr>
					<tr>
						<td><label for="nreseller_max_traffic">{$TR_MAX_TRAFFIC_AMOUNT}</label></td>
						<td><input type="text" name="nreseller_max_traffic" id="nreseller_max_traffic" value="{$MAX_TRAFFIC_AMOUNT}"/></td>
					</tr>
					<tr>
						<td><label for="nreseller_max_disk">{$TR_MAX_DISK_AMOUNT}</label></td>
						<td><input type="text" name="nreseller_max_disk" id="nreseller_max_disk" value="{$MAX_DISK_AMOUNT}"/></td>
					</tr>
					<tr>
						<td>{$TR_SUPPORT_SYSTEM}</td>
						<td>
							<input type="radio" name="support_system" id="support_system_yes" value="yes" {$SUPPORT_YES} /><label for="support_system_yes"> {$TR_YES}</label>
							<input type="radio" name="support_system" id="support_system_no" value="no" {$SUPPORT_NO} /><label for="support_system_no"> {$TR_NO}</label>
						</td>
					</tr>
				</table>
			</fieldset>
			<fieldset>
				<legend>{$TR_RESELLER_IPS}</legend>
				{if isset($RSL_IP_NUMBER)}
				<table>
					<tr>
						<th>{$TR_RSL_IP_NUMBER}</th>
						<th>{$TR_RSL_IP_ASSIGN}</th>
						<th>{$TR_RSL_IP_LABEL}</th>
						<th>{$TR_RSL_IP_IP}</th>
					</tr>
					{section name=i loop=$RSL_IP_NUMBER}
					<tr>
						<td>{$RSL_IP_NUMBER[i]}</td>
						<td><input type="checkbox" name="{$RSL_IP_CKB_NAME[i]}" id="{$RSL_IP_CKB_NAME[i]}" value="{$RSL_IP_CKB_VALUE[i]}" {$RSL_IP_ITEM_ASSIGNED[i]} /></td>
						<td><label for="{$RSL_IP_CKB_NAME[i]}">{$RSL_IP_LABEL[i]}</label></td>
						<td>{$RSL_IP_IP[i]}</td>
					</tr>
					{/section}
				</table>
				{/if}
			</fieldset>
			<fieldset>
				<legend>{$TR_ADDITIONAL_DATA}</legend>
				<table>
					<tr>
						<td><label for="customer_id">{$TR_CUSTOMER_ID}</label></td>
						<td><input type="text" name="customer_id" id="customer_id" value="{$CUSTOMER_ID}"/></td>
					</tr>
					<tr>
						<td><label for="first_name">{$TR_FIRST_NAME}</label></td>
						<td><input type="text" name="fname" id="first_name" value="{$FIRST_NAME}"/></td>
					</tr>
					<tr>
						<td><label for="last_name">{$TR_LAST_NAME}</label></td>
						<td><input type="text" name="lname" id="last_name" value="{$LAST_NAME}"/></td>
					</tr>
					<tr>
						<td><label for="gender">{$TR_GENDER}</label></td>
						<td>
							<select name="gender" id="gender">
								<option value="M" {$VL_MALE}>{$TR_MALE}</option>
								<option value="F" {$VL_FEMALE}>{$TR_FEMALE}</option>
								<option value="U" {$VL_UNKNOWN}>{$TR_UNKNOWN}</option>
							</select>
						</td>
					</tr>
					<tr>
						<td><label for="firm">{$TR_COMPANY}</label></td>
						<td><input type="text" name="firm" id="firm" value="{$FIRM}" /></td>
					</tr>
					<tr>
						<td><label for="street1">{$TR_STREET_1}</label></td>
						<td><input type="text" name="street1" id="street1" value="{$STREET_1}" /></td>
					</tr>
					<tr>
						<td><label for="street2">{$TR_STREET_2}</label></td>
						<td><input type="text" name="street2" id="street2" value="{$STREET_2}" /></td>
					</tr>
					<tr>
						<td><label for="zip_postal_code">{$TR_ZIP_POSTAL_CODE}</label></td>
						<td><input type="text" name="zip" id="zip_postal_code" value="{$ZIP}" /></td>
					</tr>
					<tr>
						<td><label for="city">{$TR_CITY}</label></td>
						<td><input type="text" name="city" id="city" value="{$CITY}" /></td>
					</tr>
					<tr>
						<td><label for="state">{$TR_STATE}</label></td>
						<td><input type="text" name="state" id="state" value="{$STATE}" /></td>
					</tr>
					<tr>
						<td><label for="country">{$TR_COUNTRY}</label></td>
						<td><input type="text" name="country" id="country" value="{$COUNTRY}" /></td>
					</tr>
					<tr>
						<td><label for="phone">{$TR_PHONE}</label></td>
						<td><input type="text" name="phone" id="phone" value="{$PHONE}" /></td>
					</tr>
					<tr>
						<td><label for="fax">{$TR_FAX}</label></td>
						<td><input type="text" name="fax" id="fax" value="{$FAX}" /></td>
					</tr>
				</table>
			</fieldset>
			<div class="buttons">
				<input type="hidden" name="edit_id" value="{$EDIT_ID}"/>
				<input type="hidden" name="edit_username" value="{$USERNAME}" />
				<input type="hidden" name="uaction" value="update_reseller" />
				<label for="send_data">{$TR_SEND_DATA}</label>
				<input type="checkbox" name="send_data" id="send_data" checked="checked" />
				<input type="submit" name="Submit" value="{$TR_UPDATE}" />
			</div>
		</form>
	</div>
{include file='admin/footer.tpl'}