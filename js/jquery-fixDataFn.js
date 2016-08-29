/**
 * small additional fix to make the pkp.js handler stuff (wich is an increadibly huge library for small functions) 
 * compatible with the jQuery3/magration-enviroment we made.
 * 
 * The following issue was not fixed in the jQuery migration library.
 * 
 * See jQuery-Documentation on data():
 * 
 * > undefined is not recognized as a data value. Calls such as .data( "name", undefined ) will return the jQuery object that it was called on, allowing for chaining. 
 * 
 * @link http://api.jquery.com/data/
 * 
 * this leads to an error in js/classes/Handler.js line 38
 * 
 */
var oData = jQuery.fn.data;
jQuery.fn.data = function() {	
	if (typeof arguments[1] === "undefined") {
		return undefined;
	}

    // Now go back to jQuery's original size()
    return oData.apply(this, arguments);
};