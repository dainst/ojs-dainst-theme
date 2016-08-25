/*window.onerror = function(msg, file_loc, line_no) {
    console.log(msg, file_loc, line_no);
    
    var t = 'Handler.js';
    var l = t.length;
    var file = file_loc.substr(file_loc.length - l, l);
    console.log(file);
    
    
    if ((line_no == 38) && (file == t)) {
    	console.log("!!!");
    	return true;
    	
    	
    }
    
    throw new Error(file_loc + ' line ' +  line_no + ': ' + msg);
    
};*/


$(window).error(function(e){
	console.log(e);
	
	
    var t = 'Handler.js';
    var l = t.length;
    var file = e.originalEvent.filename.substr(e.originalEvent.filename.length - l, l);
    console.log(file);
    
    
    if ((e.originalEvent.lineno == 38) && (file == t)) {
    	console.log("!!!");
    	e.preventDefault();
    	return true;
    	
    	
    }
	
	
    
});