$(document).ready(function() {
  function sessionId(self) {
    return parseInt($(self).attr('id'));
  }

  function attending(self) {
    $(self).toggleClass('miss', $.inArray(sessionId(self), sessionIdList) === -1);
    $(self).attr('title', ($(self).hasClass('miss') ? "Click to" : "Will") + ' Attend');
  }

  for (var index = 0, len = sessionIdList.length; index < len; ++index) {
    attending($('#' + sessionIdList[index]));
  }

  $('li.column2').click(function() {
    var self = this,
    sessionid = sessionId(this);

    $.post('/toggle_session',
           {sessionid: sessionid,
            _method:'PUT'},
           function(data) {
             if (data.willAttend === true) {
               sessionIdList.push(sessionid);
             } else if (data.willAttend === false) {
               sessionIdList.splice($.inArray(sessionid, sessionIdList), 1);
             }
             attending(self);
           }, 'json');
  });
});

