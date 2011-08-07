$(document).ready(function() {
  function sessionId(self) {
    return $(self).attr('data-sessionid')
  }

  function attending(self) {
    $(self).toggleClass('miss', $.inArray(sessionId(self), sessionIdList) === -1);
  }

  attending(this);

  $('li.column2').click(function() {
    var self = this,
    sessionid = sessionId(this);

    $.post('attendees/toggle_session', 
           {sessionid: sessionid}, 
           function(data) {
             if (data.willAttend == true) {
               sessionIdList.push(sessionid);
             } else {
               sessionIdList.splice($.inArray(sessionid, sessionIdList), 1);
             }
             attending(self);
           }, 'json');
  });
});

