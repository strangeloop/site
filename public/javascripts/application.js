$(document).ready(function() {
  $('.track').toggle(function() {
    if (SL.isShaded(this)) {
      SL.removeShade(SL.similarTracks(this));
    } else {
      SL.addShade(SL.differentTracks(this));
    }
  },
  function() {
    if (SL.isShaded(this)) {
      SL.addShade(SL.similarTracks(this));
    } else {
      SL.removeShade(SL.differentTracks(this));
    }
  });

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
  };

  function track(self) {
    return $(self).parent().attr("data-track");
  };

  return {
    prependNav : function(text, path) {
      listLink(text, path).prependTo($('#menu > ul'));
    },
    appendNav : function(text, path) {
      listLink(text, path).appendTo($('#menu > ul'));
    },
    isShaded : function(self) {
      return $(self).parent().hasClass("shaded");
    },
    similarTracks : function(self) {
      return $('.column3:[data-track="' + track(self) + '"]');
    },
    differentTracks : function(self) {
      return $('.column3:not([data-track="' + track(self) + '"])');
    },
    removeShade : function(tracks) {
      tracks.removeClass("shaded");
    },
    addShade : function(tracks) {
      tracks.addClass("shaded");
    }
  };
}();

