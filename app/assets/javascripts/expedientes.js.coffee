$(document).ready ->

  ### Define el destino del formulario dependiendo del botón apretado: Buscar o Exportar ###
  $('#new_expediente').children('input[data-url]').on 'click', ->
    $(this).parent().prop('action', this.dataset.url)

  ### Muestra un cartel de confirmación si se van a exportar más de 1000 registros ###
  $('#exportar').on 'click', ->
    if this.dataset.count >= 1000
      unless confirm "Se van a exportar " + this.dataset.count + " registros. ¿Desea continuar?"
        false