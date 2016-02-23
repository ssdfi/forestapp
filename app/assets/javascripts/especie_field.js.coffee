$(document).ready ->

  especieGroup = null

  ### Busca el grupo al que pertenece el control y abre el modal ###
  $(".select-especie").click ->
    especieGroup = $(this).closest('.form-group')
    $("#especies-modal").modal('show')

  ### Establece la especie seleccionada en el control ###
  $("#especies-modal-select").click ->
    for especie in $("#especies-list input:checked")
      especieGroup.find('input[type=text]').val($($(especie).parent().siblings()[1]).text())
      especieGroup.find('input[type=hidden]').val(especie.value)
    $("#especies-modal").modal('hide')

  ### Elimina la especie del control ###
  $(".remove-especie").click ->
    $(this).closest('.form-group').find('input[type=text]').val('')
    $(this).closest('.form-group').find('input[type=hidden]').val('')

  ###*
   * Ejecuta la llamada AJAX para hacer la búsqueda de especies y lista los resultados
   * con radio buttons
   ###
  $("#especies-modal form").on("ajax:success", (e, data, status, xhr) ->
    $("#especies-list tbody").empty()
    for especie in $(data)
      $("#especies-list tbody").append(
        $('<tr></tr>').append(
          $("<td><input type='radio' name='especies-radios' value='" + especie.id + "' id='especie-" + especie.id + "'></td>")
        ).append($('<td>' + especie.codigo_sp + '</td>')
        ).append($('<td>' + especie.nombre_cientifico + '</td>')
        ).append($('<td>' + especie.nombre_comun + '</td>'))
      )
  )
