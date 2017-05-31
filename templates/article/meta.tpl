<div class="panel panel-default" {if $pdfViewerpage}id="article-meta"{/if}>
	<div class="panel-heading">{translate key="plugins.themes.dainst.meta"}</div>
	<div class="panel-body">

		{*article*}
		{foreach from=$pubIdPlugins item=pubIdPlugin}
			{if $issue->getPublished()}
				{assign var=pubId value=$pubIdPlugin->getPubId($pubObject)}
			{else}
				{assign var=pubId value=$pubIdPlugin->getPubId($pubObject, true)}{* Preview rather than assign a pubId *}
			{/if}
			{if $pubId}
				<div>{$pubIdPlugin->getPubIdDisplayType()|escape}: {if $pubIdPlugin->getResolvingURL($currentJournal->getId(), $pubId)|escape}<a id="pub-id::{$pubIdPlugin->getPubIdType()|escape}" href="{$pubIdPlugin->getResolvingURL($currentJournal->getId(), $pubId)|escape}">{$pubId|escape}</a>{else}{$pubId|escape}{/if}</div>
			{/if}
		{/foreach}

		{*galley (on galley page) *}
		{if $pubObject2}
			{foreach from=$pubIdPlugins item=pubIdPlugin}
				{if $issue->getPublished()}
					{assign var=pubId value=$pubIdPlugin->getPubId($pubObject2)}
				{else}
					{assign var=pubId value=$pubIdPlugin->getPubId($pubObject2, true)}{* Preview rather than assign a pubId *}
				{/if}
				{if $pubId}
					<div>{$pubIdPlugin->getPubIdDisplayType()|escape}: {if $pubIdPlugin->getResolvingURL($currentJournal->getId(), $pubId)|escape}<a id="pub-id::{$pubIdPlugin->getPubIdType()|escape}" href="{$pubIdPlugin->getResolvingURL($currentJournal->getId(), $pubId)|escape}">{$pubId|escape}</a>{else}{$pubId|escape}{/if}</div>
				{/if}
			{/foreach}
		{/if}

		{* galleys (on article page *}
		{if $galleys}
			{foreach from=$pubIdPlugins item=pubIdPlugin}
				{foreach from=$galleys item=galley name=galleyList}
					{if $issue->getPublished()}
						{assign var=galleyPubId value=$pubIdPlugin->getPubId($galley)}
					{else}
						{assign var=galleyPubId value=$pubIdPlugin->getPubId($galley, true)}{* Preview rather than assign a pubId *}
					{/if}
					{if $galleyPubId}
						<div>{$pubIdPlugin->getPubIdDisplayType()|escape} ({$galley->getGalleyLabel()|escape}): {if $pubIdPlugin->getResolvingURL($currentJournal->getId(), $galleyPubId)|escape}<a id="pub-id::{$pubIdPlugin->getPubIdType()|escape}-g{$galley->getId()}" href="{$pubIdPlugin->getResolvingURL($currentJournal->getId(), $galleyPubId)|escape}">{$galleyPubId|escape}</a>{else}{$galleyPubId|escape}{/if}</div>
					{/if}
				{/foreach}
			{/foreach}
		{/if}

		{call_hook name="Templates::Article::MoreInfo"}
		{include file="article/comments.tpl"}
		
	</div>
</div>