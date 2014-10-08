class ExpedienteCtrl
  constructor: ->
    @expediente = exp
    @movimientos = @expediente.movimientos
    this.selectMovimiento(@movimientos[0])

  selectMovimiento: (movimiento) ->
    @movimiento.selected = false if @movimiento?
    @movimiento = movimiento
    @movimiento.selected = true
    @actividades = @movimiento.actividades

  openMap: (actividad) ->
    window.location = actividad.map_url

forestapp
  .controller 'ExpedienteCtrl', ExpedienteCtrl
