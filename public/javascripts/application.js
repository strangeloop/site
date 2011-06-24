$(document).ready(function() {
  $('.trackball').toggle(function() {
    var track=$(this).parent().attr("data-track");
    $('.column2:not([data-track="' + track + '"])').addClass("shaded");
  },
  function() {
    var track=$(this).parent().attr("data-track");
    $('.column2:not([data-track="' + track + '"])').removeClass("shaded");
  });
});

