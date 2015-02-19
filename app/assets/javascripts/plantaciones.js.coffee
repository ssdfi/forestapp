$(document).ready ->

  ###*
   * Ejecuta la llamada AJAX para hacer la búsqueda de titulares y lista los resultados
   * con un radio button (La plantación sólo puede tener un titular)
   ###
  $("#titulares-modal form").on("ajax:success", (e, data, status, xhr) ->
    $("#titulares-list").empty()
    for titular in $(data)
      $("#titulares-list").append(
        $('<li></li>').append(
          $("<input type='radio' name=titulares-radios' value='" + titular.id + "' id='titular-" + titular.id + "'>")
        ).append($('<span> ' + titular.nombre + '</span>'))
      )
  )

  ###*
   * Al hacer click en el botón de seleccionar titular en la ventanda modal, se define como
   * titular de la plantación el seleccionado mediante el radio button
   ###
  $("#titulares-modal-select").click ->
    for titular in $("#titulares-list li input:checked")
      $("#plantacion_titular_id").val(titular.value)
      $("#plantacion_titular").val($(titular).siblings('span').text())
    $("#titulares-modal").modal('hide')

  ### Elimina las especies seleccionadas ###
  $("#remove-especie").click ->
    for especie in $("#plantacion_especie_ids option:selected")
      especie.remove()

  ###*
   * Ejecuta la llamada AJAX para hacer la búsqueda de especies y lista los resultados
   * con un checkbox
   ###
  $("#especies-modal form").on("ajax:success", (e, data, status, xhr) ->
    $("#especies").empty()
    for especie in $(data)
      $("#especies").append(
        $('<li></li>').append(
          $("<input type='checkbox' value='" + especie.id + "' id='especie-" + especie.id + "'>")
        ).append($('<span> ' + especie.codigo_sp + ' (' + especie.nombre_cientifico + ')</span>'))
      )
  )

  ###*
   * Al hacer click en el botón de agregar especies en la ventanda modal, se agregan al listado
   * todos las especies que han sido seleccionados mediante el checkbox
   ###
  $("#especies-modal-add").click ->
    for especie in $("#especies li input:checked")
      $("#plantacion_especie_ids").append(
        $("<option value='" + especie.value + "'>" + $(especie).siblings('span').text() + "</option>")
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
