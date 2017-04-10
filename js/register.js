/**
 *  unfortunately the very complex pkp javascript is to complicated to integrate with and I do my own thing...
 */

jQuery(document).ready(function() {
	$(document).on('#toggleRegisterFields', 'click', toggleRegisterFields)

}

function toggleRegisterFields() {
	$('.toggleableRegisterField').toggle();
}