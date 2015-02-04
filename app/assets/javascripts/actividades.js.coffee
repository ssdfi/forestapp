$(document).ready ->

  ###*
   * Al hacer click en el botón de agregar plantaciones en la ventanda modal, se detectan las líneas
   * que contienen números y se genera una nuevo bloque de plantación para cada uno
   ###
  $("#add-plantaciones").click ->
    for plantacion_id in $('#plantaciones-ids').val().split('\n')
      if $.isNumeric($.trim(plantacion_id))
        $("#add-plantacion").click()
        $("[id$=plantacion_id]").last().val($.trim(plantacion_id))
    $('#plantaciones-ids').val('')
    $("#plantaciones-modal").modal('hide')