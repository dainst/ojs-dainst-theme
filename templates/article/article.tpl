{**
 * templates/article/article.tpl
 *
 * Copyright (c) 2013-2016 Simon Fraser University Library
 * Copyright (c) 2003-2016 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Article View.
 *}

{strip}

{assign var=pdfViewerpage value=false}

{assign var=pubObject value=$article}

{if $galley}
	{assign var=pubObject2 value=$galley}
	{if $galley->isPdfGalley()}
		{assign var=pdfViewerpage value=true}
	{/if}
{/if}

{include file="article/header.tpl"}

{/strip}



{if $galley}
	{if $galley->isHTMLGalley()}
		<div id='article-html-galley'>{$galley->getHTMLContents()}</div>
	{elseif $galley->isPdfGalley()}
		{include file="article/pdfViewer.tpl"}
	{/if}
{else}
	
	<div id="article-page">
		<div id="article-page-topBar">
			{if is_a($article, 'PublishedArticle')}
				{assign var=galleys value=$article->getGalleys()}
			{/if}
			{if $galleys && $subscriptionRequired && $showGalleyLinks}
				<div id="accessKey">
					<img src="{$baseUrl}/lib/pkp/templates/images/icons/fulltext_open_medium.gif" alt="{translate key="article.accessLogoOpen.altText"}" />
					{translate key="reader.openAccess"}&nbsp;
					<img src="{$baseUrl}/lib/pkp/templates/images/icons/fulltext_restricted_medium.gif" alt="{translate key="article.accessLogoRestricted.altText"}" />
					{if $purchaseArticleEnabled}
						{translate key="reader.subscriptionOrFeeAccess"}
					{else}
						{translate key="reader.subscriptionAccess"}
					{/if}
				</div>
			{/if}
		</div>
		
		<div id="article-page-body">
		
			{if $coverPagePath}
				<div id="articleCoverImage"><img src="{$coverPagePath|escape}{$coverPageFileName|escape}"{if $coverPageAltText != ''} alt="{$coverPageAltText|escape}"{else} alt="{translate key="article.coverPage.altText"}"{/if}{if $width} width="{$width|escape}"{/if}{if $height} height="{$height|escape}"{/if}/>
				</div>
			{/if}
			{call_hook name="Templates::Article::Article::ArticleCoverImage"}
			
			<h2 id="authorString">{$article->getAuthorString()|escape}</h2>
			<h2 id="articleTitle">{$article->getLocalizedTitle()|strip_unsafe_html}</h2>

			{if $article->getLocalizedAbstract()}
				<h4>{translate key="article.abstract"}</h4>
				<div id="article-abstract" class="article-page-section">{$article->getLocalizedAbstract()|strip_unsafe_html|nl2br}</div>
			{/if}
		
			{if $article->getLocalizedSubject()}
				<h4>{translate key="article.subject"}</h4>
				<div id="article-subject" class="article-page-section">{$article->getLocalizedSubject()|escape}</div>
			{/if}
		
			{if (!$subscriptionRequired || $article->getAccessStatus() == $smarty.const.ARTICLE_ACCESS_OPEN || $subscribedUser || $subscribedDomain)}
				{assign var=hasAccess value=1}
			{else}
				{assign var=hasAccess value=0}
			{/if}
			{if $galleys}
				<h4>{translate key="reader.fullText"}</h4>
					<div id="articleFullText" class="article-page-section">
					{if $hasAccess || ($subscriptionRequired && $showGalleyLinks)}
						{foreach from=$article->getGalleys() item=galley name=galleyList}
							<a href="{url page="article" op="view" path=$article->getBestArticleId($currentJournal)|to_array:$galley->getBestGalleyId($currentJournal)}" class="file" {if $galley->getRemoteURL()}target="_blank"{else}target="_parent"{/if}>{$galley->getGalleyLabel()|escape}</a>
							{if $subscriptionRequired && $showGalleyLinks && $restrictOnlyPdf}
								{if $article->getAccessStatus() == $smarty.const.ARTICLE_ACCESS_OPEN || !$galley->isPdfGalley()}
									<img class="accessLogo" src="{$baseUrl}/lib/pkp/templates/images/icons/fulltext_open_medium.gif" alt="{translate key="article.accessLogoOpen.altText"}" />
								{else}
									<img class="accessLogo" src="{$baseUrl}/lib/pkp/templates/images/icons/fulltext_restricted_medium.gif" alt="{translate key="article.accessLogoRestricted.altText"}" />
								{/if}
							{/if}
						{/foreach}
						{if $subscriptionRequired && $showGalleyLinks && !$restrictOnlyPdf}
							{if $article->getAccessStatus() == $smarty.const.ARTICLE_ACCESS_OPEN}
								<img class="accessLogo" src="{$baseUrl}/lib/pkp/templates/images/icons/fulltext_open_medium.gif" alt="{translate key="article.accessLogoOpen.altText"}" />
							{else}
								<img class="accessLogo" src="{$baseUrl}/lib/pkp/templates/images/icons/fulltext_restricted_medium.gif" alt="{translate key="article.accessLogoRestricted.altText"}" />
							{/if}
						{/if}
					{else}
						<a href="{url page="about" op="subscriptions"}" target="_parent">{translate key="reader.subscribersOnly"}</a>
					{/if}
				</div>
			{/if}
			{if $citationFactory->getCount()}
				
				<h4>{translate key="submission.citations"}</h4>
				<div id="articleCitations" class="article-page-section">
					<div>
						{iterate from=citationFactory item=citation}
							<p>{$citation->getRawCitation()|strip_unsafe_html}</p>
						{/iterate}
					</div>
				</div>
			{/if}
		</div>
	</div>
{/if}


{include file="article/footer.tpl"}