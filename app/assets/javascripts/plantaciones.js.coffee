$(document).ready ->

  ###*
   * Ejecuta la llamada AJAX para hacer la búsqueda de titulares y lista los resultados
   * con un radio button (La plantación sólo puede tener un titular)
   ###
  $("#titulares-modal form").on("ajax:success", (e, data, status, xhr) ->
    $("#titulares-list tbody").empty()
    for titular in $(data)
      $("#titulares-list tbody").append(
        $('<tr></tr>').append(
          $("<td><input type='radio' name=titulares-radios' value='" + titular.id + "' id='titular-" + titular.id + "'></td>")
        ).append($('<td>' + titular.nombre + '</td>')
        ).append($('<td>' + (titular.dni ? '') + '</td>')
        ).append($('<td>' + (titular.cuit ? '') + '</td>'))
      )
  )

  ###*
   * Al hacer click en el botón de seleccionar titular en la ventanda modal, se define como
   * titular de la plantación el seleccionado mediante el radio button
   ###
  $("#titulares-modal-select").click ->
    for titular in $("#titulares-list input:checked")
      $("#plantacion_titular_id").val(titular.value)
      $("#plantacion_titular").val($($(titular).parent().siblings()[0]).text())
    $("#titulares-modal").modal('hide')

  ### Elimina el titular seleccionado ###
  $("#remove-titular").click ->
    $("#plantacion_titular_id").val('')
    $("#plantacion_titular").val('')

  ### Elimina las especies seleccionadas ###
  $("#remove-especie").click ->
    for especie in $("#plantacion_especie_ids option:selected")
      especie.remove()

  ###*
   * Ejecuta la llamada AJAX para hacer la búsqueda de especies y lista los resultados
   * con un checkbox
   ###
  $("#especies-modal form").on("ajax:success", (e, data, status, xhr) ->
    $("#especies-list tbody").empty()
    for especie in $(data)
      $("#especies-list tbody").append(
        $('<tr></tr>').append(
          $("<td><input type='checkbox' value='" + especie.id + "' id='especie-" + especie.id + "'></td>")
        ).append($('<td>' + especie.codigo_sp + '</td>')
        ).append($('<td>' + especie.nombre_cientifico + '</td>')
        ).append($('<td>' + especie.nombre_comun + '</td>'))
      )
  )

  ###*
   * Al hacer click en el botón de agregar especies en la ventanda modal, se agregan al listado
   * todos las especies que han sido seleccionados mediante el checkbox
   ###
  $("#especies-modal-add").click ->
    for especie in $("#especies-list input:checked")
      $("#plantacion_especie_ids").append(
        $("<option value='" + especie.value + "'>" + $($(especie).parent().siblings()[1]).text() + "</option>")
      )
    $("#especies-modal").modal('hide')

  ### Busca y carga los departamentos pertenecientes a la zona seleccionada ###
  $("#plantacion_zona_id").change ->
    $("#plantacion_departamento_id").prop('disabled', true);
    $("#plantacion_departamento_id").empty()
    if $("#plantacion_zona_id").val()
      $.ajax(url: "/zonas/" + $("#plantacion_zona_id").val() + "/departamentos.json").done (data) ->
        $("#plantacion_departamento_id").append($("<option />"))
        for departamento in $(data)
          $("#plantacion_departamento_id").append($("<option />").val(departamento.id).text(departamento.descripcion))
        $("#plantacion_departamento_id").prop('disabled', false);

  ### Selecciona todos las especies del listado antes ejectuar el submit del formulario ###
  $("form").submit ->
    $("#plantacion_especie_ids option").prop('selected', true)
