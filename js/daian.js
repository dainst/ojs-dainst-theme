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

