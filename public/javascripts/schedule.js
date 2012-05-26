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

  $('#elc').click(function(e) {
    e.preventDefault();
    $('#elc').addClass('selected');
    $('#workshops').removeClass('selected');
    $('#main-conf').removeClass('selected');
    $('#preconf-elc').removeClass('hidden');
    $('#preconf-workshops').addClass('hidden');
    $('#main-conf-sessions').addClass('hidden');
  });

  $('#workshops').click(function(e) {
    e.preventDefault();
    $('#elc').removeClass('selected');
    $('#workshops').addClass('selected');
    $('#main-conf').removeClass('selected');
    $('#preconf-workshops').removeClass('hidden');
    $('#preconf-elc').addClass('hidden');
    $('#main-conf-sessions').addClass('hidden');
  });

  $('#main-conf').click(function(e) {
    e.preventDefault();
    $('#elc').removeClass('selected');
    $('#workshops').removeClass('selected');
    $('#main-conf').addClass('selected');
    $('#main-conf-sessions').removeClass('hidden');
    $('#preconf-elc').addClass('hidden');
    $('#preconf-workshops').addClass('hidden');
  });

  $('li.column2').click(function() {
    var self = this,
    sessionid = sessionId(this);

    $(this).addClass('shaded');
    $(this).find('img').removeClass('hidden');

    $.post('/toggle_session',
           {sessionid: sessionid,
            _method:'PUT'},
           function(data) {
             if (data.willAttend === true) {
               sessionIdList.push(sessionid);
             } else if (data.willAttend === false) {
               sessionIdList.splice($.inArray(sessionid, sessionIdList), 1);
             }
             $(self).find('img').addClass('hidden');
             $(self).removeClass('shaded');
             attending(self);
           }, 'json');
  });
});

