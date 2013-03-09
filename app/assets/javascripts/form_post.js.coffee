jQuery ->
  $('.topic-actions textarea').keyup (event)->
    if @value != '' and $('#topic').height() > $(window).height() - $('header').height()
      $('.messages').addClass('placeholder')
      $('.topic-actions-container').addClass('fixed')


  $('.topic-actions button[name=cancel]').click (event)->
    event.preventDefault();
    $('.topic-actions textarea').val('')
    $('.messages').removeClass('placeholder')
    $('.topic-actions-container').removeClass('fixed')