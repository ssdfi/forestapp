$(document).ready ->

  ### Convierte los checkbox en switch ###
  $("#movimiento_estabilidad_fiscal").bootstrapSwitch({labelText: "Estabilidad Fiscal"});
  $("#movimiento_auditar").bootstrapSwitch({labelText: "Auditar"});
  $("#movimiento_validado").bootstrapSwitch({labelText: "Validado"});