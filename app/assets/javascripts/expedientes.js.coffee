$(document).ready ->
  $('#new_expediente').children('input[data-url]').on 'click', ->
    $(this).parent().prop('action', this.dataset.url)

  $('#exportar').on 'click', ->
    