{**
 * plugins/themes/custom/settingsForm.tpl
 *
 * Copyright (c) 2013-2016 Simon Fraser University Library
 * Copyright (c) 2003-2016 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Custom Theme plugin settings
 *
 *}
 
{strip}
{assign var="pageTitle" value="plugins.themes.dainst.colorsheme"}
{include file="common/header.tpl"}
{/strip}

<div id="customThemeSettings">

<form method="post" action="{plugin_url path="settings"}">
{include file="common/formErrors.tpl"}


<div style='clear:both'>
	{foreach key=name item=css from=$colorz}
		{assign var='smartyisfuck' value='background-color'} 
		<div style='float:left; width: 14em; background-color: {$css.$smartyisfuck}; color: white'><label style='color: white'>
			<input type='radio' name='dainstcicolor' value='{$name}' {if ($name == $colorsel)}checked='checked'{/if} />{$name} {$css.alias}</label>
		</div>
	{/foreach}
</div>
<div style='clear:both'></div>


<br/>


<input type="submit" name="save" class="button defaultButton" value="{translate key="common.save"}"/>
<input type="button" class="button" value="{translate key="common.cancel"}" onclick="history.go(-1)"/>
</form>

<p><span class="formRequired">{translate key="common.requiredField"}</span></p>
</div>
{include file="common/footer.tpl"}
