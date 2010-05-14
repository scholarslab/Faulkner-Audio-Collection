$(document).ready(function() {
	// js-only styles
	$('dl').css('cursor','pointer');
	$('dl a').css('text-decoration','none');
	$('dl a').css('font-weight','normal');
	
	$('dl:odd').css('background-color','#f5f5f5');
	$('dl:even').css('background-color','#eed');
	
	$('dl').hover(function() {
		$(this).css('background-color','#e4ebfd');
	}, function() {
		if($(this).is('dl:nth-child(odd)')) {
			$(this).css('background-color','#f5f5f5');
		} else {
			$(this).css('background-color','#eed');
		}
	});
	
	$('dl').click(function() {
		window.location = $(this).find('a').attr('href');
	});
});
