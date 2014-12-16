$(document).ready ->
  $("#expediente_plurianual").bootstrapSwitch({labelText: "Plurianual"});
  $("#expediente_agrupado").bootstrapSwitch({labelText: "Agrupado"});
  $("#expediente_activo").bootstrapSwitch({labelText: "Activo"});

  $("#remove-titular").click ->
    for titular in $("#expediente_titular_ids option:selected")
      titular.remove()

  $("#titularesModal form").on("ajax:success", (e, data, status, xhr) ->
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
    $("#titularesModal").modal('hide')

  $("#expediente_zona_id").change ->
    $("#expediente_departamento_id").prop('disabled', true);
    $("#expediente_departamento_id").empty()
    if $("#expediente_zona_id").val()
      $.ajax(url: "/zonas/" + $("#expediente_zona_id").val() + "/departamentos.json").done (data) ->
        $("#expediente_departamento_id").append($("<option />"))
        for departamento in $(data)
          $("#expediente_departamento_id").append($("<option />").val(departamento.id).text(departamento.descripcion))
        $("#expediente_departamento_id").prop('disabled', false);

this.selectAllTitulares = ->
  $("#expediente_titular_ids option").prop('selected', true)