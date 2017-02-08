{**
 * templates/common/footer.tpl
 *
 * Copyright (c) 2013-2016 Simon Fraser University Library
 * Copyright (c) 2000-2016 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Common site footer.
 *
 *}
{if $displayCreativeCommons}
	{translate key="common.ccLicense"}
{/if}
{call_hook name="Templates::Common::Footer::PageFooter"}
{if $pageFooter}
	<br /><br />
	<div id="pageFooter">{$pageFooter}</div>
{/if}
</div><!-- content -->
</div><!-- main -->


<div id="sidebar" class='col-md-3'>
	

	<div id="rightSidebar">
		{if $homepageImage}
			<div id="homepageImage">
				<img src="{$publicFilesDir}/{$homepageImage.uploadName|escape:"url"}"
					 width="{$homepageImage.width|escape}"
					 height="{$homepageImage.height|escape}"
					 {if $homepageImageAltText != ''}alt="{$homepageImageAltText|escape}"{else}alt="{translate key="common.journalHomepageImage.altText"}"{/if} />
			</div>
		{else}
			<div id='dainstLogo'>&nbsp;</div>
		{/if}



		{if $rightSidebarCode}
			<div class="panel panel-default">
				<div class="panel-body">
					{$rightSidebarCode}
				</div>
			</div>
		{/if}
	</div>
</div>



</div><!-- body -->
{idai_footer}

{get_debug_info}
{if $enableDebugStats}{include file=$pqpTemplate}{/if}

</div><!-- container -->
</body>
</html>
