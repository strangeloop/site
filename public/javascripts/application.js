$(document).ready(function() {
  if (typeof attendee_login_enabled != 'undefined') {
    if(username === '') {
      SL.appendNav('Login', login_path);
    } else {
      SL.prependNav(username, attendee_path);
      SL.appendNav('Log Out', logout_path);
    }

    $('#flash_notice').delay(5000).fadeOut('fast');
  }
});

var SL = function() {
  function listLink(text, path) {
    return $('<li/>', {
      html : $('<a/>', {
        html : $('<span/>', { html: text })
      }).attr('href', path)});
  };

  return {
    prependNav : function(text, path) {
      listLink(text, path).prependTo($('#menu > ul'));
    },
    appendNav : function(text, path) {
      listLink(text, path).appendTo($('#menu > ul'));
    }
  };
}();

