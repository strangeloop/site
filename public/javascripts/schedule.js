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

  function track(self) {
    return $(self).parent().attr("data-track");
  }

  function isShaded(self) {
    return $(self).parent().hasClass("shaded");
  }

  function similarTracks(self) {
    return $('.shadeable:[data-track="' + track(self) + '"]');
  }

  function differentTracks(self) {
    return $('.shadeable:not([data-track="' + track(self) + '"])');
  }

  function removeShade(tracks) {
    tracks.removeClass("shaded");
  }

  function addShade(tracks) {
    tracks.addClass("shaded");
  }

  $('.track').toggle(function() {
    if (isShaded(this)) {
      removeShade(similarTracks(this));
    } else {
      addShade(differentTracks(this));
    }
  },
  function() {
    if (isShaded(this)) {
      addShade(similarTracks(this));
    } else {
      removeShade(differentTracks(this));
    }
  });

  $('#fpw').click(function(e) {
    e.preventDefault();
    $('#fpw').addClass('selected');
    $('#workshops').removeClass('selected');
    $('#main-conf').removeClass('selected');
    $('#unsessions-conf').removeClass('selected');
    $('#preconf-fpw').removeClass('hidden');
    $('#preconf-workshops').addClass('hidden');
    $('#main-conf-sessions').addClass('hidden');
    $('#unsessions').addClass('hidden');
  });

  $('#workshops').click(function(e) {
    e.preventDefault();
    $('#fpw').removeClass('selected');
    $('#workshops').addClass('selected');
    $('#main-conf').removeClass('selected');
    $('#unsessions-conf').removeClass('selected');
    $('#preconf-workshops').removeClass('hidden');
    $('#preconf-fpw').addClass('hidden');
    $('#main-conf-sessions').addClass('hidden');
    $('#unsessions').addClass('hidden');
  });

  $('#main-conf').click(function(e) {
    e.preventDefault();
    $('#fpw').removeClass('selected');
    $('#workshops').removeClass('selected');
    $('#main-conf').addClass('selected');
    $('#unsessions-conf').removeClass('selected');
    $('#main-conf-sessions').removeClass('hidden');
    $('#preconf-fpw').addClass('hidden');
    $('#preconf-workshops').addClass('hidden');
    $('#unsessions').addClass('hidden');
  });

  $('#unsessions-conf').click(function(e) {
    e.preventDefault();
    $('#fpw').removeClass('selected');
    $('#workshops').removeClass('selected');
    $('#main-conf').removeClass('selected');
    $('#unsessions-conf').addClass('selected');
    $('#main-conf-sessions').addClass('hidden');
    $('#unsessions').removeClass('hidden');
    $('#preconf-fpw').addClass('hidden');
    $('#preconf-workshops').addClass('hidden');
  });

  $('.table-selector, .list-selector').click(function() {
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

