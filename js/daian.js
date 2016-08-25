/**
 * daian-object
 * 
 * loads and presents annotation data
 * 
 */
var daian = {};
	
daian.init = function(objectId) {
	daian.get(hardcodedId.get());
	daian.object = $('#' + objectId);
}

daian.get = function(id) {
	$.ajax({
	  url:		"http://nlp.dainst.org:3000/annotations/" + id,
	  type: 	"get",
	  success:	function(data) {
		console.log(data);
		
		daian.block('Persons', 'user', data.persons);
		daian.block('Keyterms', 'tags', data.keyterms);
		daian.block('Places', 'map-marker', data.locations, daian.map);
		daian.block('Places', 'map-marker', data.locations);
		
	  },
	  error:	function(e){
		console.log("ERROR", e);
	  }
	});
}

daian.block = function(title, glyphicon, data, populationFn) {
	var block		= $("<div class='daian-block daian-loader panel panel-default'></div>");
	var blocktitle	= $('<div class="panel-heading"><h3 class="panel-title">' + title + '<span class="glyphicon glyphicon-' + glyphicon + ' pull-right"></h3></span></div>')
	var blockbody	= $('<div class="panel-body"></div>')
	block.append(blocktitle);
	block.append(blockbody);
	daian.object.append(block)
	
	populationFn = populationFn || daian.populate;
	
	populationFn(blockbody, data);
	
}

/**
 * goes throw an array of "units" (such as keywords, places etc) and 
 * - removes dublicates
 * - counts accurances
 * - find max and min occurance
 */
daian.sanitizeUnits = function(units) {
	var uniqueUnits = {};
	
	units.sort(sort_by('value'));
	
	$.each(units, function(k, unit) {
		unit.sanitizedValue = sanitizeLetters(unit.value);
		
		if (typeof uniqueUnits[unit.sanitizedValue] === "undefined") {
			uniqueUnits[unit.sanitizedValue] = unit;
			uniqueUnits[unit.sanitizedValue].occurences = 1; 
		} else {
			uniqueUnits[unit.sanitizedValue].occurences += 1;
		}
		
	});
	
	return uniqueUnits;
}

/**
 * takes uniqueUnits - array and counts the
 * max and min
 */
daian.unitBoundaries = function(units) {
	var maxOccurance = 1;
	var minOccurance = 1000;
	$.each(units, function(k, unit) {
		maxOccurance = Math.max(maxOccurance, unit.occurences);
		minOccurance = Math.min(minOccurance, unit.occurences);
	});
	
	console.log("maxmin: " + minOccurance + '-' + maxOccurance);
	return {
		max: maxOccurance,
		min: minOccurance
	}
}

daian.populate = function(block, units) {

	var uniqueUnits = daian.sanitizeUnits(units);
	
	$.each(uniqueUnits, function(k, unit) {	
		var entry = "<div class='daian-block-entry'>" + unit.sanitizedValue + '<span class="badge pull-right">' +  unit.occurences + "</span></div>";
		var $entry = $(entry);
		daian.references($entry, unit.references);		
		//console.log(entry);
		if (typeof block.append === "function") {
			block.append($entry);
		}
		return entry
	})
	
}

daian.map = function(block, units) {
	block.append($('<div id="daian-map" style="height:300px"></div>'));
	
	var uniqueUnits = daian.sanitizeUnits(units);
	var b = daian.unitBoundaries(uniqueUnits);
	
	try {
		map = new L.Map('daian-map');
	} catch (err) {
		console.log(err);
		return;
	}

	var osmUrl='http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png';
	var osmAttrib='Map data © <a href="http://openstreetmap.org">OpenStreetMap</a> contributors';
	var osm = new L.TileLayer(osmUrl, {minZoom: 1, maxZoom: 16, attribution: osmAttrib});		
	var markers = [];
	
	$.each(uniqueUnits, function(k, unit) {
		//console.log(unit);
		try {
			
			if ((typeof unit.coordinates === "undefined") || (typeof unit.coordinates[0] === "undefined") || (unit.coordinates[0] == "")) {
				return;
			}
			
			var radius = (unit.occurences - b.min) / (b.max - b.min) * (8 - 2) + 2;
			//console.log(radius);
			
			//var marker = L.marker([parseFloat(unit.coordinates[0]), parseFloat(unit.coordinates[1])]).addTo(map);
			var marker = L.circleMarker([parseFloat(unit.coordinates[0]), parseFloat(unit.coordinates[1])], {radius:radius}).addTo(map);
			marker.bindPopup(unit.sanitizedValue + '<span class="badge">' +  unit.occurences + "</span>");
			
			markers.push(marker);
		} catch (err) {
			console.log(err);
		}
	});
	
	var markergroup = new L.featureGroup(markers);
	
	map.fitBounds(markergroup.getBounds());
	map.addLayer(osm);
}

daian.references = function(block, data) {
	if ((typeof data === "undefined") || (data.length == 0)) {
		return;
	}
	$.each(data, function(type, ref) {
		
		var refurl = false;
		var reftag = false;
		
		if (type == 'geonames') {
			var refurl = 'http://www.geonames.org/' + ref;
			var reftag = "Geonames";
		}
		
		var code = (refurl) ? '<a class="daian-reference btn btn-xs btn-default" target="_blank" href="' + refurl + '">' +  reftag + '</a>' : '';
		
		if (refurl && (typeof block.append === "function")) {
			//console.log(type, ref, refurl, reftag,  block);
			block.append(code);
		}
		return code;
		
	});
}

$(document).ready(function() {
	console.log("ok");
	daian.init('idai_annotations');
});



/**
 * other nice functions
 */



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

/**
 * 
 * DOUGLAS aDaMs -> Douglas Adams
 * 
 * 
 * @param string
 * @returns
 */
function sanitizeLetters(string) {
	var result = [];
	
	$.each(string.split(" "), function(k, token) {
		result.push(token.charAt(0).toUpperCase() + token.slice(1).toLowerCase());
	});
	
    return result.join(" ");
}

/**
 * creates sorting functions for arrays of objects
 * @param field
 * @param reverse
 * @param primer
 * @returns {Function}
 */
function sort_by(field, reverse, primer){
   var key = primer ? 
       function(x) {return primer(x[field])} : 
       function(x) {return x[field]};

   reverse = !reverse ? 1 : -1;

   return function (a, b) {
       return a = key(a), b = key(b), reverse * ((a > b) - (b > a));
     } 
}