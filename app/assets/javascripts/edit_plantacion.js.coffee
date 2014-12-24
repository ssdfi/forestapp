$(document).ready ->
  $("#plantacion_activo").bootstrapSwitch({labelText: "Activo"});

  $("#titulares-modal form").on("ajax:success", (e, data, status, xhr) ->
    $("#titulares").empty()
    for titular in $(data)
      $("#titulares").append(
        $('<li></li>').append(
          $("<input type='radio' name=titulares-radios' value='" + titular.id + "'>")
        ).append($('<span> ' + titular.nombre + '</span>'))
      )
  )

  $("#select-titular").click ->
    for titular in $("#titulares li input:checked")
      $("#plantacion_titular_id").val(titular.value)
      $("#plantacion_titular").val($(titular).siblings('span').text())
    $("#titulares-modal").modal('hide')

  $("#remove-especie").click ->
    for especie in $("#plantacion_especie_ids option:selected")
      especie.remove()

  $("#especies-modal form").on("ajax:success", (e, data, status, xhr) ->
    $("#especies").empty()
    for especie in $(data)
      $("#especies").append(
        $('<li></li>').append(
          $("<input type='checkbox' value='" + especie.id + "'>")
        ).append($('<span> ' + especie.nombre_cientifico + '</span>'))
      )
  )

  $("#add-especie").click ->
    for especie in $("#especies li input:checked")
      $("#plantacion_especie_ids").append(
        $("<option value='" + especie.value + "'>" + $(especie).siblings('span').text() + "</option>")
      )
    $("#especies-modal").modal('hide')

  $("#plantacion_zona_id").change ->
    $("#plantacion_departamento_id").prop('disabled', true);
    $("#plantacion_departamento_id").empty()
    if $("#plantacion_zona_id").val()
      $.ajax(url: "/zonas/" + $("#plantacion_zona_id").val() + "/departamentos.json").done (data) ->
        $("#plantacion_departamento_id").append($("<option />"))
        for departamento in $(data)
          $("#plantacion_departamento_id").append($("<option />").val(departamento.id).text(departamento.descripcion))
        $("#plantacion_departamento_id").prop('disabled', false);

this.selectAllEspecies = ->
  $("#plantacion_especie_ids option").prop('selected', true)
