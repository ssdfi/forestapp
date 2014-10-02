class ExpedienteCtrl
  constructor: ->
    @expediente = exp
    @movimientos = @expediente.movimientos
    this.selectMovimiento(0)

  selectMovimiento: (index) ->
    @movimiento.selected = false if @movimiento?
    @movimiento = @movimientos[index]
    @movimiento.selected = true
    @actividades = @movimiento.actividades    

forestapp
  .controller 'ExpedienteCtrl', ExpedienteCtrl
