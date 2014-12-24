$(document).ready ->

  $("#add-plantaciones").click ->
    for plantacion_id in $('#plantaciones-ids').val().split('\n')
      if $.isNumeric($.trim(plantacion_id))
        $("#add-plantacion").click()
        $("[id$=plantacion_id]").last().val($.trim(plantacion_id))
    $('#plantaciones-ids').val('')
    $("#plantaciones-modal").modal('hide')