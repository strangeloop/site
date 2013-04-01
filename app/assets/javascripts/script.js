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
						speed:  3000,
						timeout: 6000,
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

if ($(".checked_block").length) {
$('input:checkbox:not([safari])').checkbox();
}



	jQuery.validator.addMethod("defaultInvalid", function(value, element) {
                return value != element.defaultValue;
        }, "");


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






