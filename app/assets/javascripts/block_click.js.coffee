jQuery ->
  $('section.block').on 'click', (event)->
      if $(event.currentTarget).data('url')
        window.location = $(event.currentTarget).data('url')