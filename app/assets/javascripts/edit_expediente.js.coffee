$(document).ready ->

  ### Convierte los checkbox en switch ###
  $("#expediente_plurianual").bootstrapSwitch({labelText: "Plurianual"});
  $("#expediente_agrupado").bootstrapSwitch({labelText: "Agrupado"});
  $("#expediente_activo").bootstrapSwitch({labelText: "Activo"});

  ### Elimina los titulares seleccionados ###
  $("#remove_titular").click ->
    for titular in $("#expediente_titular_ids option:selected")
      titular.remove()

  ###*
   * Ejecuta la llamada AJAX para hacer la búsqueda de titulares y lista los resultados
   * con un checkbox
   ###
  $("#modal_titulares form").on("ajax:success", (e, data, status, xhr) ->
    $("#titulares").empty()
    for titular in $(data)
      $("#titulares_list").append(
        $('<li></li>').append(
          $("<input type='checkbox' value='" + titular.id + "' id='titular_" + titular.id + "'>")
        ).append($('<span> ' + titular.nombre + '</span>'))
      )
  )

  ###*
   * Al hacer click en el botón de agregar titulares en la ventanda modal, se agregan al listado
   * todos los titulares que han sido seleccionados mediante el checkbox
   ###
  $("#modal_titulares_add").click ->
    for titular in $("#titulares_list li input:checked")
      $("#expediente_titular_ids").append(
        $("<option value='" + titular.value + "'>" + $(titular).siblings('span').text() + "</option>")
      )
    $("#modal_titulares").modal('hide')

  ### Selecciona todos los titulares del listado antes ejectuar el submit del formulario ###
  $("form").submit ->
    $("#expediente_titular_ids option").prop('selected', true)