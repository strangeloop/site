$(document).ready(function() {
  $('.track').toggle(function() {
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

  $.getJSON('/attendees/current.json', function(data) {
    if(data.username === null) {
      SL.appendNav('Login', data.login_path);
    } else {
      SL.prependNav(data.username, data.attendee_path);
      SL.appendNav('Log Out', data.logout_path);
    }
  })
});

var SL = function() {
  function listLink(text, path) {
    return $('<li/>', {
      html : $('<a/>', {
        html : text }).attr('href', path)});
  }

  return {
    prependNav : function(text, path) {
      listLink(text, path).prependTo($('#menu > ul'));
    },
    appendNav : function(text, path) {
      listLink(text, path).appendTo($('#menu > ul'));
    }
  };
}();

