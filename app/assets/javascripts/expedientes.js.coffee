$(document).ready ->

  ### Define el destino del formulario dependiendo del botón apretado: Buscar o Exportar ###
  $('#new_expediente').children('input[data-url]').on 'click', ->
    $(this).parent().prop('action', this.dataset.url)

  ### Muestra un cartel de confirmación si se van a exportar más de 1000 registros ###
  $('#exportar').on 'click', ->
    if this.dataset.count >= 1000
      unless confirm "Se van a exportar " + this.dataset.count + " registros. ¿Desea continuar?"
        false

  ### Elimina los titulares seleccionados ###
  $("#remove-titular").click ->
    for titular in $("#expediente_titular_ids option:selected")
      titular.remove()

  ###*
   * Ejecuta la llamada AJAX para hacer la búsqueda de titulares y lista los resultados
   * con un checkbox
   ###
  $("#titulares-modal form").on("ajax:success", (e, data, status, xhr) ->
    $("#titulares-list tbody").empty()
    for titular in $(data)
      $("#titulares-list tbody").append(
        $('<tr></tr>').append(
          $("<td><input type='checkbox' value='" + titular.id + "' id='titular-" + titular.id + "'></td>")
        ).append($('<td>' + titular.nombre + '</td>')
        ).append($('<td>' + (titular.dni ? '') + '</td>')
        ).append($('<td>' + (titular.cuit ? '') + '</td>'))
      )
  )

  ###*
   * Al hacer click en el botón de agregar titulares en la ventanda modal, se agregan al listado
   * todos los titulares que han sido seleccionados mediante el checkbox
   ###
  $("#titulares-modal-add").click ->
    for titular in $("#titulares-list input:checked")
      $("#expediente_titular_ids").append(
        debugger
        $("<option value='" + titular.value + "'>" + $($(titular).parent().siblings()[0]).text() + "</option>")
      )
    $("#titulares-modal").modal('hide')

  ### Selecciona todos los titulares del listado antes ejectuar el submit del formulario ###
  $("form").submit ->
    $("#expediente_titular_ids option").prop('selected', true)