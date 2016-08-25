{**
 * templates/article/pdfViewer.tpl
 *
 * Copyright (c) 2013-2016 Simon Fraser University Library
 * Copyright (c) 2003-2016 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Embedded PDF viewer.
 *}

{* The target="_parent" is for the sake of iphones, which present scroll problems otherwise. 
<div id="pdfDownloadLinkContainer">
	<a class="action pdf" id="pdfDownloadLink" target="_parent" href="{url op="download" path=$articleId|to_array:$galley->getBestGalleyId($currentJournal)}">{translate key="article.pdf.download"}</a>
</div>*}

{url|assign:"pdfUrl" op="viewFile" path=$articleId|to_array:$galley->getBestGalleyId($currentJournal) escape=false}

{translate|assign:"noPluginText" key='article.pdf.pluginMissing'}

{pdf_viewer file="$pdfUrl"}



<div style="clear: both;"></div>
