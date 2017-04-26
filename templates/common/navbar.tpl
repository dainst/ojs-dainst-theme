{**
 * templates/common/navbar.tpl
 *
 * Copyright (c) 2013-2016 Simon Fraser University Library
 * Copyright (c) 2003-2016 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Navigation Bar
 *
 *}


  <ul class="nav navbar-nav navbar-right">
	
	{* removed buttons
	<li id="home"><a href="{url page="index"}">{translate key="navigation.home"}</a></li>
	<li id="about"><a href="{url page="about"}">{translate key="navigation.about"}</a></li>

	{if $isUserLoggedIn}
		<li id="userHome"><a href="{url journal="index" page="user"}">{translate key="navigation.userHome"}</a></li>
	{else}
		<li id="login"><a href="{url page="login"}">{translate key="navigation.login"}</a></li>
		{if !$hideRegisterLink}
			<li id="register"><a href="{url page="user" op="register"}">{translate key="navigation.register"}</a></li>
		{/if}
	{/if}
	*}

	{if $currentJournal && $currentJournal->getSetting('publishingMode') != $smarty.const.PUBLISHING_MODE_NONE}
		<li class="navItem" id="sidebarNavigation">
			<a class="dropdown-toggle" data-toggle="dropdown" href="#">{$currentJournal->getLocalizedTitle()}<b class="caret"></b></a>
			<ul class="dropdown-menu">			
				<li id="current"><a href="{url page="issue" op="current"}">{translate key="navigation.current"}</a></li>
				<li id="archives"><a href="{url page="issue" op="archive"}">{translate key="navigation.archives"}</a></li>
				<li id="search"><a href="{url page="search"}">{translate key="navigation.search"}</a></li>
				{*<li><a href="{url page="issue" op="archive"}">{translate key="navigation.browse"} {translate key="navigation.browseByIssue"}</a></li>*}
				<li><a href="{url page="search" op="authors"}">{translate key="navigation.browse"} {translate key="navigation.browseByAuthor"}</a></li>
				<li><a href="{url page="search" op="titles"}">{translate key="navigation.browse"} {translate key="navigation.browseByTitle"}</a></li>
				{call_hook name="Plugins::Blocks::Navigation::BrowseBy"}
			</ul>
		</li>
	{/if}
	
	{if $currentJournal && $hasOtherJournals}
		<li class="navItem" id="sidebarNavigationOther">
			<a class="dropdown-toggle" data-toggle="dropdown" href="#">
				<span class='nav-label'>{translate key="plugins.themes.dainst.otherStuff"}</span>
				<b class="caret"></b>
			</a>


				<ul class="dropdown-menu">
					<li><a href="{url journal="index"}">{translate key="navigation.otherJournals"}</a></li>
					{if $siteCategoriesEnabled}<li><a href="{url journal="index" page="search" op="categories"}">{translate key="navigation.categories"}</a></li>{/if}
				</ul>

			<!--<li><a href="https://journals.dainst.org/monographs">{translate key="plugins.themes.dainst.omp"}</a></li>-->

		</li>
	{/if}

	{if $siteCategoriesEnabled}
		<li id="categories"><a href="{url journal="index" page="search" op="categories"}">{translate key="navigation.categories"}</a></li>
	{/if}{* $categoriesEnabled *}

	{if !$currentJournal || $currentJournal->getSetting('publishingMode') != $smarty.const.PUBLISHING_MODE_NONE}
		
	{/if}



	{if $enableAnnouncements}
		<li id="announcements"><a href="{url page="announcement"}">{translate key="announcement.announcements"}</a></li>
	{/if}{* enableAnnouncements *}

	{call_hook name="Templates::Common::Header::Navbar::CurrentJournal"}

	{foreach from=$navMenuItems item=navItem key=navItemKey}
		{if $navItem.url != '' && $navItem.name != ''}
			<li class="navItem" id="navItem-{$navItemKey|escape}"><a href="{if $navItem.isAbsolute}{$navItem.url|escape}{else}{$baseUrl}{$navItem.url|escape}{/if}">{if $navItem.isLiteral}{$navItem.name|escape}{else}{translate key=$navItem.name}{/if}</a></li>
		{/if}
	{/foreach}
	
	
	{* replaces block.notification *}
	
	{if $currentJournal}
		<li class="navItem" id="notification">
			<a class="dropdown-toggle" data-toggle="dropdown" href="#">
				<span class="glyphicon glyphicon-comment"></span>
				<span class="longlabel">{translate key="notification.notifications"}<b class="caret"></b></span>
			</a>
			<ul class="dropdown-menu">
				<li class='dropdown-title'>{translate key="notification.notifications"}</li>
				{if $isUserLoggedIn}
					<li><a href="{url page="notification"}">{translate key="common.view"}</a>
				{if $unreadNotifications > 0}{translate key="notification.notificationsNew" numNew=$unreadNotifications}{/if}</li>
					<li><a href="{url page="notification" op="settings"}">{translate key="common.manage"}</a></li>
				{else}
					<li><a href="{url page="notification"}">{translate key="common.view"}</a></li>
					<li><a href="{url page="notification" op="subscribeMailList"}">{translate key="notification.subscribe"}</a></li>
				{/if}
			</ul>
		</li>
	{/if}
	
	{* replaces block.languageToggle *}
	
	{if $enableLanguageToggle}
		<li class="navItem" id="sidebarLanguageToggle">
			<script type="text/javascript">

				function changeLanguageD(lang) {ldelim}
					var new_locale = lang;	
					var redirect_url = '{url|escape:"javascript" page="user" op="setLocale" path="NEW_LOCALE" source=$smarty.server.REQUEST_URI escape=false}';
					redirect_url = redirect_url.replace("NEW_LOCALE", new_locale);
					window.location.href = redirect_url;
				{rdelim}

			</script>
			<a class="dropdown-toggle" data-toggle="dropdown" href="#">{translate key="common.language"}<b class="caret"></b></a>
			
			<ul class="dropdown-menu">
				{foreach from=$languageToggleLocales item=lang key=langKey}
					<li><a href='#' onclick="changeLanguageD('{$langKey}'); return false;">{$lang}</a></li>
				{/foreach}
			</ul>
			
		</li>
	{/if}

	<li class="navItem" id="sidebarDainstAbout">
		<a href="http://www.dainst.org/publikationen/e-publikationen">{translate key="plugins.themes.dainst.aboutLink"}</a>
	</li>

</ul>

