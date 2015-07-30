$(document).ready ->

  ###*
   * Al hacer click en el botón de agregar plantaciones en la ventanda modal, se detectan las líneas
   * que contienen números y se genera una nuevo bloque de plantación para cada uno
   ###
  $('#plantaciones-modal-add').click ->
    for plantacion_id in $('#plantaciones-ids').val().split('\n')
      if $.isNumeric($.trim(plantacion_id))
        $("#add-plantacion").click()
        $("[id$=plantacion_id]").last().val($.trim(plantacion_id))
    $('#plantaciones-ids').val('')
    $("#plantaciones-modal").modal('hide')

  ###*
   * Busca la superficie del polígono de la plantación y usa el valor como superficie registrada
  ###
  $('#plantaciones').on 'click', 'button.hectareas', ->
    button = $(this)
    tr = button.closest('tr')
    input = tr.find('[id$=superficie_registrada]')
    plantacion_id = tr.find('[id$=plantacion_id]').val()
    if plantacion_id
      input.prop('disabled', true)
      button.prop('disabled', true)
      $.ajax(url: "/plantaciones/#{plantacion_id}.json")
        .done (data) ->
          if data.hectareas
            tr.find('[id$=superficie_registrada]').val(data.hectareas)
        .always () ->
          input.prop('disabled', false)
          button.prop('disabled', false)
