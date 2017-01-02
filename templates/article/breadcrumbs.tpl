<ol class="breadcrumb">
	<li><a href="{getOJSDomain}">{translate key="navigation.home"}</a></li>
	<li><a href="{getOJSDomain}/{getOJSFolder}">{translate key="plugins.themes.dainst.journals"}</a></li>
	{if $currentJournal}
		<li><a href="{$currentJournal->getUrl()|strip_tags|escape}">{$currentJournal->getLocalizedTitle()|strip_tags|escape}</a></li>
	{/if}
	{if $issue}<li><a href="{url page="issue" op="view" path=$issue->getBestIssueId($currentJournal)}" target="_parent">{$issue->getIssueIdentification(false,true)|escape}</a></li>{/if}
	<li><a href="{url page="article" op="view" path=$articleId|to_array:$galleyId}" class="current" target="_parent">{$article->getFirstAuthor(true)|escape}</a></li>

	{if $pdfViewerpage}
		<li class="right"><a href='#' id='article-meta-toggler'>{translate key="plugins.themes.dainst.meta"} <b class="caret"></b></a></li>
	{/if}

</ol>