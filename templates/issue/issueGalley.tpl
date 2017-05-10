{**
 * templates/issue/issueGalley.tpl
 *
 * Copyright (c) 2013-2016 Simon Fraser University Library
 * Copyright (c) 2003-2016 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Issue galley view for PDF files.
 *}
{assign var=pdfViewerpage value=true}
{include file="issue/header.tpl"}
{url|assign:"pdfUrl" op="viewFile" path=$issueId|to_array:$galley->getBestGalleyId($currentJournal)}
{pdf_viewer file="$pdfUrl" article="$articleId"}

{include file="common/footer.tpl"}
