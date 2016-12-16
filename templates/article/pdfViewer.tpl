{**
 * templates/article/pdfViewer.tpl
 *
 * Copyright (c) 2013-2016 Simon Fraser University Library
 * Copyright (c) 2003-2016 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Embedded PDF viewer.
 *}

{include file="article/meta.tpl"}

{url|assign:"pdfUrl" op="viewFile" path=$articleId|to_array:$galley->getBestGalleyId($currentJournal) escape=false}

{pdf_viewer file="$pdfUrl" article="$articleId"}



<div style="clear: both;"></div>
