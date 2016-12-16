/**
 * set height of vier object to what is good for you
 */
function setViewerHeight() {
	console.log('resize');
	
	function getOffset( id ) {
		var el =  document.getElementById(id);
	    var _x = 0;
	    var _y = 0;
	    while( el && !isNaN( el.offsetLeft ) && !isNaN( el.offsetTop ) ) {
	        _x += el.offsetLeft - el.scrollLeft;
	        _y += el.offsetTop - el.scrollTop;
	        el = el.offsetParent;
	    }
	    return { top: _y, left: _x };
	}

	var body = document.body;
    var html = document.documentElement;
    //var height = Math.max(body.scrollHeight, body.offsetHeight, html.clientHeight, html.scrollHeight, html.offsetHeight);
	var height = html.clientHeight;
	var y = getOffset('dainstPdfViewer').top;
	var newHeight = height - y - 20;
	
	document.getElementById('dainstPdfViewer').style.height = newHeight + 'px';
	
	console.log('height: ', height, 'y: ', y);

    //document.getElementById('dainstPdfViewer').height = Height + 40;
}


jQuery(document).ready(function() {
	
	var openMeta = function(event) {
		jQuery('#article-meta').toggle(true);
		event.stopImmediatePropagation();
		closeMetaDelayStop();
    }
	
	var closeMeta = function(event) {
		jQuery('#article-meta').toggle(false);
		if (event) {
			event.stopImmediatePropagation();
		}
		closeMetaDelayStop();
	}
	
	var toggleMeta = function(event) {
		jQuery('#article-meta').toggle();
		event.stopImmediatePropagation();
		closingMeta = false;
		closeMetaDelayStop();
    }

	var closingMeta = false;
	var closingMetaTimeout = false;
	
	var closeMetaDelay = function() {
		closingMeta = true;
		closingMetaTimeout = setTimeout(closeMeta, 500);
	}
	
	var closeMetaDelayStop = function() {
		if (closingMeta) {
			closingMeta = false;
			clearTimeout(closingMetaTimeout);
		}
	}

	
	jQuery('#article-meta-toggler').mouseenter(openMeta);
	jQuery('#article-meta-toggler').click(toggleMeta);
	jQuery('#article-meta').mouseover(openMeta);
	jQuery('#article-meta-toggler').mouseleave(closeMetaDelay);
	jQuery('#article-meta').mouseleave(closeMeta);
	

})