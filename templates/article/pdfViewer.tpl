{**
 * templates/article/pdfViewer.tpl
 *
 *
 * Embedded PDF viewer.
 *}

{include file="article/meta.tpl"}

{url|assign:"pdfUrl" op="viewFile" path=$articleId|to_array:$galley->getBestGalleyId($currentJournal) escape=false}

{pdf_viewer file="$pdfUrl" article="$articleId"}

{*debugPubIDSettings pubObject=$article*}

<div style="clear: both;"></div>
