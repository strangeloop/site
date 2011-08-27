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

  if(username === '') {
    SL.appendNav('Login', login_path);
  } else {
    SL.prependNav(username, attendee_path);
    SL.appendNav('Log Out', logout_path);
  }
});

var SL = function() {
  function listLink(text, path) {
    return $('<li/>', {
      html : $('<a/>', {
        html : $('<span/>', { html: text })
      }).attr('href', path)});
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

