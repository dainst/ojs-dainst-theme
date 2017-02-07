/**
 *  unfortunately the very complex pkp javascripüt is to complcated to integrate with and I do my own thing...
 */

jQuery(document).ready(function() {
	$(document).on('#toggleRegisterFields', 'click', toggleRegisterFields)

}

function toggleRegisterFields() {
	$('.toggleableRegisterField').toggle();
}