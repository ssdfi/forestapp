$(document).ready ->

  ### Define el destino del formulario dependiendo del botón apretado: Buscar o Editar ###
  $('#new_plantacion').children('input[data-url]').on 'click', ->
    $(this).parent().prop('action', this.dataset.url)

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

  ### Busca y carga los departamentos pertenecientes a la provincia seleccionada ###
  $("#plantacion_provincia_id").change ->
    $("#plantacion_departamento_id").prop('disabled', true);
    $("#plantacion_departamento_id").empty()
    $("#plantacion_departamento_id").append($("<option />"))
    if $("#plantacion_provincia_id").val()
      $.ajax(url: "/provincias/" + $("#plantacion_provincia_id").val() + "/departamentos.json").done (data) ->
        for departamento in $(data)
          $("#plantacion_departamento_id").append($("<option />").val(departamento.id).text(departamento.nombre))
        $("#plantacion_departamento_id").prop('disabled', false)
    else
      $("#plantacion_departamento_id").prop('disabled', false)

  ### Selecciona todos las especies del listado antes ejectuar el submit del formulario ###
  $("form").submit ->
    $("#plantacion_especie_ids option").prop('selected', true)

  ### Activa/Descativa el campo asociado al label ###
  $('.form-group[data-disabler] label').css('cursor', 'pointer')
  $('.form-group[data-disabler] label').css('text-decoration', 'underline')
  $('.form-group[data-disabler] label').click (event) ->
    $("##{$(this).prop('for')}").bootstrapSwitch('toggleDisabled')
    $("##{$(this).prop('for')}").prop('disabled', (i, value) ->
      !value
    )
    event.stopPropagation()
