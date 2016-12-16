{**
 * templates/article/header.tpl
 *
 * Copyright (c) 2013-2016 Simon Fraser University Library
 * Copyright (c) 2003-2016 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Article View -- Header component.
 *}
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="{$currentLocale|replace:"_":"-"}" xml:lang="{$currentLocale|replace:"_":"-"}">
<head>
	<title>{$article->getFirstAuthor(true)|strip_tags|escape} | {$article->getLocalizedTitle()|strip_tags|escape} | {$currentJournal->getLocalizedTitle()|strip_tags|escape}</title>
	<meta http-equiv="Content-Type" content="text/html; charset={$defaultCharset|escape}" />
	<meta name="description" content="{$article->getLocalizedTitle()|strip_tags|escape}" />
	{if $article->getLocalizedSubject()}
		<meta name="keywords" content="{$article->getLocalizedSubject()|escape}" />
	{/if}

	{if $displayFavicon}<link rel="icon" href="{$faviconDir}/{$displayFavicon.uploadName|escape:"url"}" type="{$displayFavicon.mimeType|escape}" />{/if}

	{include file="article/dublincore.tpl"}
	{include file="article/googlescholar.tpl"}
	{call_hook name="Templates::Article::Header::Metadata"}

	<link rel="stylesheet" href="{$baseUrl}/lib/pkp/styles/pkp.css" type="text/css" />
	{* 
	<link rel="stylesheet" href="{$baseUrl}/lib/pkp/styles/common.css" type="text/css" />
	<link rel="stylesheet" href="{$baseUrl}/styles/common.css" type="text/css" />
	<link rel="stylesheet" href="{$baseUrl}/styles/compiled.css" type="text/css" />
	*}
	{*<link rel="stylesheet" href="{$baseUrl}/styles/articleView.css" type="text/css" />
	{if $journalRt && $journalRt->getEnabled()}
		<link rel="stylesheet" href="{$baseUrl}/lib/pkp/styles/rtEmbedded.css" type="text/css" />
	{/if}
	*}
	{call_hook|assign:"leftSidebarCode" name="Templates::Common::LeftSidebar"}
	{call_hook|assign:"rightSidebarCode" name="Templates::Common::RightSidebar"}
	{if $leftSidebarCode || $rightSidebarCode}<link rel="stylesheet" href="{$baseUrl}/styles/sidebar.css" type="text/css" />{/if}
	{if $leftSidebarCode}<link rel="stylesheet" href="{$baseUrl}/styles/leftSidebar.css" type="text/css" />{/if}
	{* if $rightSidebarCode}<link rel="stylesheet" href="{$baseUrl}/styles/rightSidebar.css" type="text/css" />{/if *}
	{if $leftSidebarCode && $rightSidebarCode}<link rel="stylesheet" href="{$baseUrl}/styles/bothSidebars.css" type="text/css" />{/if}

	{foreach from=$stylesheets item=cssUrl}
		<link rel="stylesheet" href="{$cssUrl}" type="text/css" />
	{/foreach}

	<!-- Base Jquery -->
	<!-- Base Jquery -->
	<script type="text/javascript" src="{$baseUrl}/plugins/themes/dainst/idai-components-php/script/jquery-2.2.4.min.js"></script>
	<script type="text/javascript" src="{$baseUrl}/plugins/themes/dainst/js/jquery-migrate-1.4.1.min.js"></script>
	<script type="text/javascript" src="{$baseUrl}/lib/pkp/js/lib/jquery/plugins/jqueryUi.min.js"></script>

	<!-- Compiled scripts -->
	{if $useMinifiedJavaScript}
		<script type="text/javascript" src="{$baseUrl}/js/pkp.min.js"></script>
	{else}
		{include file="common/minifiedScripts.tpl"}
	{/if}

	{$additionalHeadData}

	{if $pdfViewerpage}
		<link rel="stylesheet" href="{$baseUrl}/plugins/themes/dainst/small_footer.css" type="text/css" />
	{/if}
	
	
</head>

<body id="pkp-{$pageTitle|replace:'.':'-'}" class="{if !$pdfViewerpage}hasDainstColorbar{/if}">
{idai_navbar subtitle="$displayPageHeaderTitle"}
	{include file="common/navbar.tpl"}
{/idai_navbar}

{if !$pdfViewerpage}
	<div id="dainstColorbar" class="dainstColor {$dainstcicolor}"></div>
{/if}

<div id="container">

{if !$pdfViewerpage}
	<div id="header" class='row'>
		<div id="headerTitle" class='col-md-11 col-md-offset-1'>
			<h1>
				{if $displayPageHeaderLogo && is_array($displayPageHeaderLogo)}
					<img src="{$publicFilesDir}/{$displayPageHeaderLogo.uploadName|escape:"url"}" width="{$displayPageHeaderLogo.width|escape}" height="{$displayPageHeaderLogo.height|escape}" {if $displayPageHeaderLogoAltText != ''}alt="{$displayPageHeaderLogoAltText|escape}"{else}alt="{translate key="common.pageHeaderLogo.altText"}"{/if} />
				{/if}
				{if $displayPageHeaderTitle && is_array($displayPageHeaderTitle)}
					<img src="{$publicFilesDir}/{$displayPageHeaderTitle.uploadName|escape:"url"}" width="{$displayPageHeaderTitle.width|escape}" height="{$displayPageHeaderTitle.height|escape}" {if $displayPageHeaderTitleAltText != ''}alt="{$displayPageHeaderTitleAltText|escape}"{else}alt="{translate key="common.pageHeader.altText"}"{/if} />
				{elseif $displayPageHeaderTitle}
					{$displayPageHeaderTitle}
				{elseif $alternatePageHeader}
					{$alternatePageHeader}
				{elseif $siteTitle}
					{$siteTitle}
				{else}
					{$applicationName}
				{/if}
			</h1>
		</div>
	</div>
{/if}
{getHtaccessDebug}

<div id="body" class='row'>
	{if !$pdfViewerpage}
		<div class='col-md-1'>
			{if $leftSidebarCode}
				<div class="panel panel-default">
					<div class="panel-body">
						{$leftSidebarCode}
					</div>
				</div>
			{/if}&nbsp;
		</div>
	{/if}
	
	{if $pdfViewerpage}
		<div id="main" class='col-md-12'>
	{else}
		<div id="main" class='col-md-8'>
	{/if}
	
	{include file="article/breadcrumbs.tpl"}