{**
 * templates/user/register.tpl
 *
 * Copyright (c) 2013-2016 Simon Fraser University Library
 * Copyright (c) 2003-2016 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * User registration form.
 *
 *}
{strip}
	{assign var="pageTitle" value="user.register"}
	{include file="common/header.tpl"}
{/strip}

{if $implicitAuth === true && !Validation::isLoggedIn()}
	<div class="well"><a href="{url page="login" op="implicitAuthLogin"}">{translate key="user.register.implicitAuth"}</a></div>
{else}
	<form id="registerForm" method="post" action="{url op="registerUser"}">

		<div class="alert alert-info">
			<div><a href="#why">{translate key="plugins.themes.dainst.registerWhy"}</a></div>

			{if !$implicitAuth || ($implicitAuth === $smarty.const.IMPLICIT_AUTH_OPTIONAL && !Validation::isLoggedIn())}
				{if !$existingUser}
					{url|assign:"url" page="user" op="register" existingUser=1}
					<div>{translate key="user.register.alreadyRegisteredOtherJournal" registerUrl=$url}</div>
				{else}
					{url|assign:"url" page="user" op="register"}
					<div>{translate key="user.register.notAlreadyRegisteredOtherJournal" registerUrl=$url}</div>
					<input type="hidden" name="existingUser" value="1"/>
				{/if}

				{if $implicitAuth === $smarty.const.IMPLICIT_AUTH_OPTIONAL}
					<div><a href="{url page="login" op="implicitAuthLogin"}">{translate key="user.register.implicitAuth"}</a></div>
				{/if}
			{/if}
		</div>

		{if !$implicitAuth || ($implicitAuth === $smarty.const.IMPLICIT_AUTH_OPTIONAL && !Validation::isLoggedIn())}
			<h3>{translate key="user.profile"}</h3>

			{include file="common/formErrors.tpl"}

			{if $existingUser}
				<div class="well">{translate key="user.register.loginToRegister"}</div>
			{/if}
		{/if}{* !$implicitAuth || ($implicitAuth === $smarty.const.IMPLICIT_AUTH_OPTIONAL && !Validation::isLoggedIn()) *}

		{if $source}
			<input type="hidden" name="source" value="{$source|escape}" />
		{/if}
	{/if}{* $implicitAuth === true && !Validation::isLoggedIn() *}

	<div class="well">
		<table class="data">
			{if count($formLocales) > 1 && !$existingUser}
				<tr>
					<td width="20%">{fieldLabel name="formLocale" key="form.formLanguage"}</td>
					<td width="80%">
						{url|assign:"userRegisterUrl" page="user" op="register" escape=false}
						{form_language_chooser form="registerForm" url=$userRegisterUrl}
						<div class="instruct">{translate key="form.formLanguage.description"}</div>
					</td>
				</tr>
			{/if}{* count($formLocales) > 1 && !$existingUser *}

			{if !$implicitAuth || $implicitAuth === $smarty.const.IMPLICIT_AUTH_OPTIONAL || ($implicitAuth === true && Validation::isLoggedIn())}
				{if $allowRegReader || $allowRegReader === null || $allowRegAuthor || $allowRegAuthor === null || $allowRegReviewer || $allowRegReviewer === null || ($currentJournal && $currentJournal->getSetting('publishingMode') == $smarty.const.PUBLISHING_MODE_SUBSCRIPTION && $enableOpenAccessNotification)}
					<tr>
						<td>{fieldLabel suppressId="true" name="registerAs" key="user.register.registerAs"}</td>
						<td>
							{if $allowRegReader || $allowRegReader === null}
								<input type="checkbox" name="registerAsReader" id="registerAsReader" value="1"{if $registerAsReader} checked="checked"{/if} />
								<label for="registerAsReader">{translate key="user.role.reader"}</label>: {translate key="user.register.readerDescription"}<br />
							{/if}
							{if $currentJournal && $currentJournal->getSetting('publishingMode') == $smarty.const.PUBLISHING_MODE_SUBSCRIPTION && $enableOpenAccessNotification}
								<input type="checkbox" name="openAccessNotification" id="openAccessNotification" value="1"{if $openAccessNotification} checked="checked"{/if} />
								<label for="openAccessNotification">{translate key="user.role.reader"}</label>: {translate key="user.register.openAccessNotificationDescription"}<br />
							{/if}
							{if $allowRegAuthor || $allowRegAuthor === null}
								<input type="checkbox" name="registerAsAuthor" id="registerAsAuthor" value="1"{if $registerAsAuthor} checked="checked"{/if} />
								<label for="registerAsAuthor">{translate key="user.role.author"}</label>: {translate key="user.register.authorDescription"}<br />
							{/if}
							{if $allowRegReviewer || $allowRegReviewer === null}
								<input type="checkbox" name="registerAsReviewer" id="registerAsReviewer" value="1"{if $registerAsReviewer} checked="checked"{/if} />
								<label for="registerAsReviewer">{translate key="user.role.reviewer"}</label>: {if $existingUser}{translate key="user.register.reviewerDescriptionNoInterests"}{else}{translate key="user.register.reviewerDescription"}{/if}
							{/if}
						</td>
					</tr>
				{/if}
			{/if}

			{if !$implicitAuth || ($implicitAuth === $smarty.const.IMPLICIT_AUTH_OPTIONAL && !Validation::isLoggedIn())}

				<tr>
					<td width="20%">{fieldLabel name="username" required="true" key="user.username"}</td>
					<td width="80%">
						<input type="text" name="username" value="{$username|escape}" id="username" size="20" maxlength="32" class="textField" />
						{if !$existingUser}
							<div class="instruct">{translate key="user.register.usernameRestriction"}</div>
						{/if}{* !$existingUser *}
					</td>
				</tr>

				<tr>
					<td>{fieldLabel name="password" required="true" key="user.password"}</td>
					<td>
						<input type="password" name="password" value="{$password|escape}" id="password" size="20" class="textField" />
						{if !$existingUser}
							<div class="instruct">{translate key="user.register.passwordLengthRestriction" length=$minPasswordLength}</div>
						{/if}
					</td>
				</tr>

				{if !$existingUser}
					<tr>
						<td>{fieldLabel name="password2" required="true" key="user.repeatPassword"}</td>
						<td><input type="password" name="password2" id="password2" value="{$password2|escape}" size="20" class="textField" /></td>
					</tr>

					{if $captchaEnabled}
						<tr>
							{if $reCaptchaEnabled}
								<td>{fieldLabel name="recaptcha_challenge_field" required="true" key="common.captchaField"}</td>
								<td>
									{$reCaptchaHtml}
								</td>
							{else}
								<td>{fieldLabel name="captcha" required="true" key="common.captchaField"}</td>
								<td>
									<img src="{url page="user" op="viewCaptcha" path=$captchaId}" alt="{translate key="common.captchaField.altText"}" /><br />
									<span class="instruct">{translate key="common.captchaField.description"}</span><br />
									<input name="captcha" id="captcha" value="" size="20" maxlength="32" class="textField" />
									<input type="hidden" name="captchaId" value="{$captchaId|escape:"quoted"}" />
								</td>
							{/if}
						</tr>
					{/if}{* $captchaEnabled *}

					<tr class="toggleableRegisterField">
						<td>{fieldLabel name="salutation" key="user.salutation"}</td>
						<td><input type="text" name="salutation" id="salutation" value="{$salutation|escape}" size="20" maxlength="40" class="textField" /></td>
					</tr>

					<tr>
						<td>{fieldLabel name="firstName" required="true" key="user.firstName"}</td>
						<td><input type="text" id="firstName" name="firstName" value="{$firstName|escape}" size="20" maxlength="40" class="textField" /></td>
					</tr>

					<tr class="toggleableRegisterField">
						<td>{fieldLabel name="middleName" key="user.middleName"}</td>
						<td><input type="text" id="middleName" name="middleName" value="{$middleName|escape}" size="20" maxlength="40" class="textField" /></td>
					</tr>

					<tr>
						<td>{fieldLabel name="lastName" required="true" key="user.lastName"}</td>
						<td><input type="text" id="lastName" name="lastName" value="{$lastName|escape}" size="20" maxlength="90" class="textField" /></td>
					</tr>

					<tr class="toggleableRegisterField">
						<td>{fieldLabel name="initials" key="user.initials"}</td>
						<td>
							<input type="text" id="initials" name="initials" value="{$initials|escape}" size="5" maxlength="5" class="textField" />
							<div class="instruct">{translate key="user.initialsExample"}</div>
						</td>
					</tr>

					<tr class="toggleableRegisterField">
						<td>{fieldLabel name="gender-m" key="user.gender"}</td>
						<td>
							<select name="gender" id="gender" size="1" class="selectMenu form-control">
								{html_options_translate options=$genderOptions selected=$gender}
							</select>
						</td>
					</tr>

					<tr class="toggleableRegisterField">
						<td>{fieldLabel name="affiliation" key="user.affiliation"}</td>
						<td>
							<textarea id="affiliation" class="form-control textArea" name="affiliation[{$formLocale|escape}]" rows="5" cols="40">{$affiliation[$formLocale]|escape}</textarea>
							<div class="instruct">{translate key="user.affiliation.description"}</div>
						</td>
					</tr>

					<tr class="toggleableRegisterField">
						<td>{fieldLabel name="signature" key="user.signature"}</td>
						<td><textarea name="signature[{$formLocale|escape}]" id="signature" rows="5" cols="40" class="form-control textArea">{$signature[$formLocale]|escape}</textarea></td>
					</tr>

					<tr>
						<td>{fieldLabel name="email" required="true" key="user.email"}</td>
						<td><input type="text" id="email" name="email" value="{$email|escape}" size="30" maxlength="90" class="textField" />
							{if $privacyStatement}<div class="instruct"></div><a class="action" href="#privacyStatement">{translate key="user.register.privacyStatement"}</a></td>{/if}
						</td>
					</tr>

					<tr>
						<td>{fieldLabel name="confirmEmail" required="true" key="user.confirmEmail"}</td>
						<td><input type="text" id="confirmEmail" name="confirmEmail" value="{$confirmEmail|escape}" size="30" maxlength="90" class="textField" /></td>
					</tr>

					<tr class="toggleableRegisterField">
						<td>{fieldLabel name="orcid" key="user.orcid"}</td>
						<td><input type="text" id="orcid" name="orcid" value="{$orcid|escape}" size="40" maxlength="255" class="textField" />
							<div class="instruct">{translate key="user.orcid.description"}</div>
						</td>
					</tr>

					<tr class="toggleableRegisterField">
						<td>{fieldLabel name="userUrl" key="user.url"}</td>
						<td><input type="text" id="userUrl" name="userUrl" value="{$userUrl|escape}" size="30" maxlength="255" class="textField" /></td>
					</tr>

					<tr class="toggleableRegisterField">
						<td>{fieldLabel name="phone" key="user.phone"}</td>
						<td><input type="text" name="phone" id="phone" value="{$phone|escape}" size="15" maxlength="24" class="textField" /></td>
					</tr>

					<tr class="toggleableRegisterField">
						<td>{fieldLabel name="fax" key="user.fax"}</td>
						<td><input type="text" name="fax" id="fax" value="{$fax|escape}" size="15" maxlength="24" class="textField" /></td>
					</tr>

					<tr class="toggleableRegisterField">
						<td>{fieldLabel name="mailingAddress" key="common.mailingAddress"}</td>
						<td><textarea name="mailingAddress" id="mailingAddress" rows="3" cols="40" class="form-control textArea">{$mailingAddress|escape}</textarea></td>
					</tr>

					<tr class="toggleableRegisterField">
						<td>{fieldLabel name="country" key="common.country"}</td>
						<td>
							<select name="country" id="country" class="selectMenu form-control">
								<option value=""></option>
								{html_options options=$countries selected=$country}
							</select>
						</td>
					</tr>

					<tr class="toggleableRegisterField">
						<td>{fieldLabel name="biography" key="user.biography"}<br />{translate key="user.biography.description"}</td>
						<td><textarea name="biography[{$formLocale|escape}]" id="biography" rows="5" cols="40" class="form-control textArea">{$biography[$formLocale]|escape}</textarea></td>
					</tr>

					<tr>
						<td>{fieldLabel name="sendPassword" key="user.sendPassword"}</td>
						<td>
							<input type="checkbox" name="sendPassword" id="sendPassword" value="1"{if $sendPassword} checked="checked"{/if} /> <label for="sendPassword">{translate key="user.sendPassword.description"}</label>
						</td>
					</tr>

					{if count($availableLocales) > 1}
						<tr>
							<td>{translate key="user.workingLanguages"}</td>
							<td>{foreach from=$availableLocales key=localeKey item=localeName}
									<input type="checkbox" name="userLocales[]" id="userLocales-{$localeKey|escape}" value="{$localeKey|escape}"{if in_array($localeKey, $userLocales)} checked="checked"{/if} /> <label for="userLocales-{$localeKey|escape}">{$localeName|escape}</label><br />
								{/foreach}
							</td>
						</tr>
					{/if}{* count($availableLocales) > 1 *}
				{/if}{* !$existingUser *}
			{/if}{* !$implicitAuth || ($implicitAuth === $smarty.const.IMPLICIT_AUTH_OPTIONAL && !Validation::isLoggedIn()) *}


{if !$implicitAuth || $implicitAuth === $smarty.const.IMPLICIT_AUTH_OPTIONAL || ($implicitAuth === true && Validation::isLoggedIn())}


			<tr>
				<td></td>
				<td>
					{if !$implicitAuth || $implicitAuth === $smarty.const.IMPLICIT_AUTH_OPTIONAL}
						<div class="instruct">{translate key="common.requiredField"}</div>
						<div class="instruct"><a id='toggleRegisterFields' href="#">{translate key="plugins.themes.dainst.showAllFields"}</a></div>
					{/if}{* !$implicitAuth || $implicitAuth === $smarty.const.IMPLICIT_AUTH_OPTIONAL *}
				</td>
			</tr>

			<tr>
				<td></td>
				<td>
					<div class="idai-infobox-toggle" style="display:inline-block; float:right">
						<input type="button" value="{translate key="user.register"}" class="btn btn-success" />
						<div id="termsOfUseBox" class="idai-infobox">
							<p>{translate key="plugins.themes.dainst.termsOfUseText"}</p>
							<input type="submit" value="{translate key="plugins.themes.dainst.termsOfUseRead"}" class="btn infobox-button btn-success" />
							<input type="button" value="{translate key="common.cancel"}" class="btn infobox-button btn-danger" />
						</div>
					</div>

					<input type="button" value="{translate key="common.cancel"}" class="btn btn-danger" style="float:right; margin-right: 5px" onclick="document.location.href='{url page="index" escape=false}'" />

				</td>

			</tr>

		</table>
	</div>

{/if}{* !$implicitAuth || $implicitAuth === $smarty.const.IMPLICIT_AUTH_OPTIONAL || ($implicitAuth === true && Validation::isLoggedIn()) *}

</form>

<h3 id="why">{translate key="plugins.themes.dainst.registerInformation"}</h3>
<div class="well registerInformation">
	{translate key="plugins.themes.dainst.registerInformationText"}
</div>

{if $privacyStatement}
	<h3>{translate key="user.register.privacyStatement"}</h3>
	<div id="privacyStatement" class="well registerInformation">
		{$privacyStatement|nl2br}
	</div>
{/if}


<script>
	{literal}
	jQuery(document).ready(function() {
		jQuery('#toggleRegisterFields').click(function() {
			jQuery('.toggleableRegisterField').toggle();
		});
		jQuery('#toggleRegisterFields').click(function() {
			jQuery('.toggleableRegisterField').toggle();
		});
	});
	{/literal}
</script>

{include file="common/footer.tpl"}

