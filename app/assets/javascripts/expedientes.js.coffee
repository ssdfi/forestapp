$(document).ready ->
  $('#new_expediente').children('input[data-url]').on 'click', ->
    $(this).parent().prop('action', this.dataset.url)

  $('#exportar').on 'click', ->
    if this.dataset.count >= 1000
      unless confirm "Se van a exportar " + this.dataset.count + " registros. Esto podría tomar varios minutos. ¿Desea continuar?"
        false