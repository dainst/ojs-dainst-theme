{**
 * templates/user/registerSite.tpl
 *
 * Copyright (c) 2013-2016 Simon Fraser University Library
 * Copyright (c) 2003-2016 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Site registration.
 *
 *}
{strip}
{assign var="pageTitle" value="user.register"}
{include file="common/header.tpl"}
{/strip}



<div id="journals">
{iterate from=journals item=journal}
	{if !$notFirstJournal}
		{translate key="user.register.selectJournal"}:
		<ul>
		{assign var=notFirstJournal value=1}
	{/if}
	<li><a href="{url journal=$journal->getPath() page="user" op="register"}">{$journal->getLocalizedTitle()|escape}</a></li>
{/iterate}
{if $journals->wasEmpty()}
	{translate key="user.register.noJournals"}
{else}
	</ul>
{/if}
</div>

<h3>{translate key="plugins.themes.dainst.registerInformation"}</h3>
<div class="well">{translate key="plugins.themes.dainst.registerInformationText"}</div>
<script>
	{literal}
	function showTermsOfUse() {
		jQuery('#idai-footer-termsOfUse').click();
	}
	function showImprint() {
		jQuery('#idai-footer-imprint').click();
	}

	{/literal}
</script>

{include file="common/footer.tpl"}

