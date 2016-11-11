{**
 * breadcrumbs.tpl
 *
 *}
<ol class="breadcrumb">
	<li><a href="{getOJSDomain}">{translate key="navigation.home"}</a></li>
	<li><a href="{getOJSDomain}/{getOJSFolder}">{translate key="plugins.themes.dainst.journals"}</a></li>
	{if $currentJournal}
		<li><a href="{$currentJournal->getUrl()|strip_tags|escape}">{$currentJournal->getLocalizedTitle()|strip_tags|escape}</a></li>
	{/if}
	{foreach from=$pageHierarchy item=hierarchyLink}
		<li><a href="{$hierarchyLink[0]|escape}" class="hierarchyLink">{if not $hierarchyLink[2]}{translate key=$hierarchyLink[1]}{else}{$hierarchyLink[1]|escape}{/if}</a></li>
	{/foreach}
	{if (!$currentJournal or ($currentUrl|escape != $currentJournal->getUrl()|strip_tags|escape))}
		{* Disable linking to the current page if the request is a post (form) request. Otherwise following the link will lead to a form submission error. *}
		<li>{if $requiresFormRequest}<span class="current">{else}<a href="{$currentUrl|escape}" class="current">{/if}{$pageCrumbTitleTranslated}{if $requiresFormRequest}</span>{else}</a>{/if}</li>
	{/if}
</ol>

