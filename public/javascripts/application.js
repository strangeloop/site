$(document).ready(function() {
  if (typeof attendee_login_enabled != 'undefined') {
    if(username === '') {
      SL.appendNav(SL.listLink('Login', login_path));
    } else {
      SL.appendNav( SL.listLink(username, attendee_path).append($('<ul/>' , { html : SL.listLink('Log Out', logout_path)})));
    }

    $('#flash_notice').delay(5000).fadeOut('fast');
  }
});

var SL = function() {
  return {
    listLink : function(text, path) {
      return $('<li/>', {
          html : $('<a/>', {
              html : $('<span/>', { html: text })
          }).attr('href', path)});
    },
    appendNav : function(item) {
      item.appendTo($('#menu > ul'));
    }
  };
}();

