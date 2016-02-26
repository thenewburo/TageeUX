$(function () {
	
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
	$('.view-section li a').click(function(){
		var newLink = $(this).html();
		$(".view span").html(newLink);
		return false;
	});
	
	
});