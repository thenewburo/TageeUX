$(function () {
	
// menu for mobile
	$('#menu').click(function(){
		if( $(this).hasClass('active') ){
			$(this).removeClass('active');
			$(this).next('ul').stop(true,true).slideUp();
		}
		else{
			$(this).addClass('active');
			$(this).next('ul').stop(true,true).slideDown();
		}
		
		return false;
	});
	

	
	$('.popup-link').click(function(){
		var newContents = $(this).attr('href');
		$(".overlay-popup").fadeIn();
		$(newContents).fadeIn();
		return false;
	});
	$('.login-cancel').click(function(){
		$(".overlay-popup").fadeOut();
		$(".popup-seciton").fadeOut();
		return false;
	});
	

// overlay on gallery
	$('.overlay').click(function(){
		var newGallery = $(this).attr('href');
		$('#large_photo').fadeOut(function(){
			$(this).attr('src', newGallery).fadeIn();
		});
		return false;
	});
	
	
// view on dropdown	
	
	$('.view').click(function(){
		if( $(this).hasClass('active') ){
			$(this).removeClass('active');
			$(this).next('ul').stop(true,true).slideUp();
		}
		else{
			$(this).addClass('active');
			$(this).next('ul').stop(true,true).slideDown();
		}
		return false;
	});
	
	$('.view-section li a').click(function(){
		
		$(this).parents('ul').hide();
		$(".view").removeClass('active');
		
		$(".view-section li a").removeClass('active');
		$(this).addClass('active');
		
		
		var newLink = $(this).html();
		$(".view span").html(newLink);
		return false;
	});
	
	
	// chanel field from sidebar
	 $('.field-channel').focus(function() { // Define focus handler
            $('.channel-field-wrap ul').show();
      }).blur(function() {
            $('.channel-field-wrap ul').hide();
      });
	
	
});