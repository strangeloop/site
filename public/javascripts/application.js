$(document).ready(function() {
  $('.trackball').toggle(function() {
    var track=$(this).parent().attr("data-track");
    if ($(this).parent().hasClass("shaded")) {
      removeShade(similarTracks(track));
    } else {
      addShade(differentTracks(track));
    }
  },
  function() {
    var track=$(this).parent().attr("data-track");
    if ($(this).parent().hasClass("shaded")) {
      addShade(similarTracks(track));
    } else {
      removeShade(differentTracks(track));
    }
  });
  function similarTracks(track) {
    return $('.column2:[data-track="' + track + '"]');
  };
  function differentTracks(track) {
    return $('.column2:not([data-track="' + track + '"])');
  };
  function removeShade(tracks) {
    tracks.removeClass("shaded");
  };
  function addShade(tracks) {
    tracks.addClass("shaded");
  };
});

