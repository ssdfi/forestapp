$(document).ready ->
  $("#expediente_plurianual").bootstrapSwitch({labelText: "Plurianual"});
  $("#expediente_agrupado").bootstrapSwitch({labelText: "Agrupado"});
  $("#expediente_activo").bootstrapSwitch({labelText: "Activo"});

  $("#remove-titular").click ->
    for titular in $("#expediente_titular_ids option:selected")
      titular.remove()

  $("#titulares-modal form").on("ajax:success", (e, data, status, xhr) ->
    $("#titulares").empty()
    for titular in $(data)
      $("#titulares").append(
        $('<li></li>').append(
          $("<input type='checkbox' value='" + titular.id + "'>")
        ).append($('<span> ' + titular.nombre + '</span>'))
      )
  )

  $("#add-titular").click ->
    for titular in $("#titulares li input:checked")
      $("#expediente_titular_ids").append(
        $("<option value='" + titular.value + "'>" + $(titular).siblings('span').text() + "</option>")
      )
    $("#titulares-modal").modal('hide')

this.selectAllTitulares = ->
  $("#expediente_titular_ids option").prop('selected', true)