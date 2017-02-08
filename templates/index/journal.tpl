{**
 * templates/index/journal.tpl
 *
 * Copyright (c) 2013-2016 Simon Fraser University Library
 * Copyright (c) 2003-2016 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Journal index page.
 *
 *}
{strip}
{assign var="pageTitleTranslated" value=$siteTitle}
{include file="common/header.tpl"}
{/strip}

<div>


	
	{if $journalDescription}
		<div id="journalDescription">{$journalDescription}</div>
	{/if}
	
	{call_hook name="Templates::Index::journal"}
	

	{if $additionalHomeContent}
		<p>
			<a id="showAdditionalHomeContent">{translate key="plugins.themes.dainst.showAdditionalHomeContent"}</a>
			<div id="additionalHomeContent">{$additionalHomeContent}</div>
		</p>
	{/if}
	
	{if $enableAnnouncementsHomepage}
		{* Display announcements *}
		<div id="announcementsHome">
			<h3>{translate key="announcement.announcementsHome"}</h3>
			{include file="announcement/list.tpl"}	
			<table class="announcementsMore">
				<tr>
					<td><a href="{url page="announcement"}">{translate key="announcement.moreAnnouncements"}</a></td>
				</tr>
			</table>
		</div>
	{/if}
	
	{* Display the table of contents or cover page of the current issue. 
	{if $issue && $currentJournal->getSetting('publishingMode') != $smarty.const.PUBLISHING_MODE_NONE}
		<br />
		<h3>{$issue->getIssueIdentification()|strip_unsafe_html|nl2br}</h3>
		{include file="issue/view.tpl"}
	{/if}
	{* *}
	<div style="clear:both"></div>
</div>
<h3>{translate key="plugins.themes.dainst.archive"}</h3>
{journal_archive}

<script>
	{literal}
		jQuery(document).ready(function() {
			jQuery('#showAdditionalHomeContent').click(function() {
				jQuery('#showAdditionalHomeContent').toggle();
				jQuery('#additionalHomeContent').toggle();
			})
		})
	{/literal}
</script>

{include file="common/footer.tpl"}