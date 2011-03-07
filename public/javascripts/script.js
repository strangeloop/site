/* Author: olegnax

*/
$(document).ready(function() {
	
			jQuery('.slider').fadeIn(300);
			jQuery('#slider').fadeIn(300);
			if ($("#s4").length) {
					$(function() {
					$('#s4')
						.after('<div id="nav">') 
						.cycle({ 
						fx:     'fade', 
						speed:  1000, 
						timeout: 3000, 
						pause: 1,
						pager:  '#nav' 
					});
					});
				};
			if ($("#slider").length) {
			 $(window).load(function() {
					$('#slider').nivoSlider();
				});
			};	
			$('input[type="text"],textarea').addClass("idleField");
       		$('input[type="text"],textarea').focus(function() {
       			$(this).removeClass("idleField").addClass("focusField");
    		    if (this.value == this.defaultValue){ 
    		    	this.value = '';
				}
				if(this.value != this.defaultValue){
	    			this.select();
	    		}
    		});
    		$('input[type="text"],textarea').blur(function() {
    			$(this).removeClass("focusField").addClass("idleField");
    		    if ($.trim(this.value) == ''){
			    	this.value = (this.defaultValue ? this.defaultValue : '');
				}
    		});
			jQuery('ul.sf-menu').superfish();
			// prettyPhoto
			if ($("a[rel^='prettyPhoto']").length) {
			$("a[rel^='prettyPhoto']").prettyPhoto({theme:'light_rounded'});
			};		
			// lightbox image
			$(".video_rollover").prepend("<span></span>");
			$(".video_rollover span").stop().animate({opacity:0},0)
					
			$(".video_rollover").hover(function(){
				$(this).find("span").stop().animate({opacity:1},300)
			}, function(){
				$(this).find("span").stop().animate({opacity:0},100)
			});
			$(".image_rollover").prepend("<span></span>")
			$(".image_rollover span").stop().animate({opacity:0},0)
				
			$(".image_rollover, .videos").hover(function(){
				$(this).find("span").stop().animate({opacity:1},300)
			}, function(){
				$(this).find("span").stop().animate({opacity:0},100)
			});
			
			
			if ($(".carousel2").length) {
				   $(".carousel2").jCarouselLite({
				       btnNext: ".next",
				       btnPrev: ".prev",
				       scroll: 1
				   });
			};
	
	/*		
			$('.sidebar_menu > li.parrent').toggle(
			function() {
				$(this).addClass('sidebar_menu_act')
				$(this).find('> .sidebar_menu').stop(false, true).slideDown(500);
			},
			function() {
				$(this).removeClass('sidebar_menu_act')
				$(this).find('> .sidebar_menu').stop(false, true).slideUp(500);
				Cufon.refresh();
			}
		);
		*/
		
		
				$("#pricing_table .grid_price").hover(function() {
					$(this).stop().animate({ marginTop: "-10px", paddingTop:"25px", marginBottom: "-10px",  marginLeft: "-5px",  marginRight: "-5px", paddingLeft: "25px", paddingRight: "25px",  width: "180px",  height: "358px"  }, 200);
					$(this).find('.bottom_bg').stop().animate({height:"69px"}, 200);
					$(this).find('.bottom_bg div').stop().animate({height:"69px"}, 200);
				},function(){
					$(this).stop().animate({ marginTop: "0px", paddingTop:"15px", marginBottom: "0px",  marginLeft: "0px",  marginRight: "0px", paddingLeft: "20px", paddingRight: "20px",   width: "180px",  height: "348px" }, 300);
					$(this).find('.bottom_bg').stop().animate({height:"59px"},300);
					$(this).find('.bottom_bg div').stop().animate({height:"59px"},300);
				});
				
				
				$("#pricing_table3 .grid_price").hover(function() {
					$(this).stop().animate({ marginTop: "-10px", paddingTop:"25px", marginBottom: "-10px",  marginLeft: "-5px",  marginRight: "-5px", paddingLeft: "25px", paddingRight: "25px",  width: "225px",  height: "358px"  }, 200);
					$(this).find('.bottom_bg').stop().animate({height:"69px"}, 200);
					$(this).find('.bottom_bg div').stop().animate({height:"69px"}, 200);
				},function(){
					$(this).stop().animate({ marginTop: "0px", paddingTop:"15px", marginBottom: "0px",  marginLeft: "0px",  marginRight: "0px", paddingLeft: "20px", paddingRight: "20px",  width: "225px",  height: "348px" }, 300);
					$(this).find('.bottom_bg').stop().animate({height:"59px"},300);
					$(this).find('.bottom_bg div').stop().animate({height:"59px"},300);
				});

		/*	if (jQuery(".kwicks").length) { 
			  jQuery('.kwicks .slide .kwicks_title').css({ bottom: "0" });
			  jQuery('.kwicks .slide').fadeIn(300);  
			
			  jQuery('.kwicks').kwicks({
			   max :  940,
			   spacing : 0
			  });        
				  
				  
					jQuery('.kwicks .slide').hover(function() {
					jQuery('.kwicks_title', this).hide();
			  jQuery('.kwicks_description', this).stop().fadeTo(900, 0.8);       
				   jQuery('.kwicks_title', this).css({ top: "0" });
					jQuery('.kwicks_title', this).css({ bottom: "" });
					jQuery('.kwicks_title', this).stop().fadeTo(900, 0.8); 
			  },function(){
			  jQuery('.kwicks_description', this).hide();
				   jQuery('.kwicks_title', this).hide();
					jQuery('.kwicks_title', this).css({ top: "" });
					jQuery('.kwicks_title', this).css({ bottom: "0" });
					jQuery('.kwicks_title', this).stop().fadeTo(900, 0.8); 
					
			 });
				}
			*/
			
if ($(".checked_block").length) {			
$('input:checkbox:not([safari])').checkbox();
}			
			
	
	
	jQuery.validator.addMethod("defaultInvalid", function(value, element) {
                return value != element.defaultValue;
        }, "");
				
				
			jQuery("#contactform").validate({
				
			submitHandler: function(form) {	
							
				var $ = jQuery;
			
				$('#loader').fadeIn();
		
				var formData = $(form).serialize(),
					note = $('#Note');
			
				$.ajax({
					type: "POST",
					url: "send.php",
					data: formData,
					success: function(response) {
						if ( note.height() ) {			
							note.fadeIn('fast', function() { $(this).hide(); });
						} else {
							note.hide();
						}
		
						$('#LoadingGraphic').fadeOut('fast', function() {
							//$(this).remove();
							if (response === 'success') {
								$('#contactform').animate({opacity: 0},'fast');
							}
		
							// Message Sent? Show the 'Thank You' message and hide the form
							result = '';
							c = '';
							if (response === 'success') { 
								result = 'Your message has been sent. Thank you!';
								c = 'success';
							}
		
							note.removeClass('success').removeClass('error').text('');
							var i = setInterval(function() {
								if ( !note.is(':visible') ) {
									note.html(result).addClass(c).slideDown('fast');
									clearInterval(i);
								}
							}, 40);    
						});
					}
				});
		
				return false;
			},
			
			 rules: 
      {
       formname: "required defaultInvalid",
	   formcomments: "required defaultInvalid"
      },
			
			 messages: {
    		 formname: "Please specify your name.",
			 formcomments: "Please enter your message.",
    		 formemail: {
      			 required: "We need your email address to contact you.",
      			 email: "Your email address must be in the format of name@domain.com"
    		 }
  		 }
		});
		
		
/*		
			//When page loads...
			$(".tab_content").hide(); //Hide all content
			$("ul.tabs li:first").addClass("active").show(); //Activate first tab
			$(".tab_content:first").show(); //Show first tab content
			
			//On Click Event
			$("ul.tabs li").click(function() {
			
				$("ul.tabs li").removeClass("active"); //Remove any "active" class
				$(this).addClass("active"); //Add "active" class to selected tab
				$(".tab_content").hide(); //Hide all tab content
			
				var activeTab = $(this).find("a").attr("href"); //Find the title attribute value to identify the active tab + content
				$(activeTab).fadeIn(); //Fade in the active ID content
				return false;
			});
 $('input:checkbox:not([safari])').checkbox(); */

});
jQuery('.list1 li').hover(function(){
  	jQuery(this).stop().css({backgroundPosition: "-16px 8px"});
    jQuery(this).stop().animate({ backgroundPosition: "-13px 8px" }, 300);
}, function(){
    jQuery(this).stop().animate({ backgroundPosition: "-13px 8px" }, 200);
 	jQuery(this).stop().css({backgroundPosition: "-16px 8px"});
});
jQuery('.list2 li').hover(function(){
  	jQuery(this).stop().css({backgroundPosition: "-16px 8px"});
    jQuery(this).stop().animate({ backgroundPosition: "20px -32px" }, 300);
}, function(){
    jQuery(this).stop().animate({ backgroundPosition: "20px -32px" }, 200);
 	jQuery(this).stop().css({backgroundPosition: "-16px 8px"});
});
jQuery('.list3 li').hover(function(){
  	jQuery(this).stop().css({backgroundPosition: "-16px 8px"});
    jQuery(this).stop().animate({ backgroundPosition: "20px -32px" }, 300);
}, function(){
    jQuery(this).stop().animate({ backgroundPosition: "20px -32px" }, 200);
 	jQuery(this).stop().css({backgroundPosition: "-16px 8px"});
});
$(function() {
		$(".sf-menu  li  a").append('<strong class="shover"> </strong>');
		// set opacity to nill on page load
		$(".sf-menu  li  a strong").css("opacity","0");
		// on mouse over
		$(".sf-menu  li  a ").hover(function () {
			// animate opacity to full
			
			$(this).find(".shover").stop().animate({
				opacity: 1
			}, 'slow');
		},
		// on mouse out
		function () {
			// animate opacity to nill
			$(this).find(".shover").stop().animate({
				opacity: 0
			}, 'slow');
		});
	});

function initMenu() {
  $('.sidebar_menu ul').hide();
  $('.sidebar_menu  li.parrent > a').click(
    function() {
		$('.sidebar_menu').find('.parrent').toggleClass('sidebar_menu_act');
        $(this).next().slideToggle('normal');	
      }
    );
  }
$(document).ready(function() {initMenu();});






