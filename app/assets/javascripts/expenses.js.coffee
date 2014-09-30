$(document).on "page:change", ->
  viewModel = {}
  
  $.get $("#movimientos tbody tr").first().attr("url") + "/actividades.json", (data) ->
    $("#movimientos tbody tr").first().addClass "info"
    viewModel = ko.mapping.fromJS(actividades: data)
    ko.applyBindings viewModel

  $("#movimientos tbody").on "click", "tr", ->
    $(this).siblings().removeClass "info"
    $(this).addClass "info"
    $.get $(this).attr('url') + "/actividades.json", (data) ->
      ko.mapping.fromJS(actividades: data, viewModel)
