$(document).ready(function() {
  $('.responsive-menu').click(function() { 
		if ($('.navigation').css('display') == 'none') 
			$('.navigation').css('display', 'block');
		else 
			$('.navigation').css('display', 'none');
		});
});



