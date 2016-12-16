</div><!-- main! -->

{if !$pdfViewerpage}
	<div id="sidebar" class='col-md-3'>
		<div id="rightSidebar">
			
			{include file="article/meta.tpl"}
			{daian_article}
			{if $rightSidebarCode}
				<div class="panel panel-default">
					<div class="panel-body">
						{$rightSidebarCode}
					</div>
				</div>
			{/if}
		</div>
	</div>
{/if}


</div><!-- body -->

{idai_footer}

{get_debug_info}
{if $enableDebugStats}{include file=$pqpTemplate}{/if}

</div><!-- container -->
</body>
</html>