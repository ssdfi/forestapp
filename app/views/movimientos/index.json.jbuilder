json.array!(@movimientos) do |movimiento|
  json.extract! movimiento, :id, :expediente_id, :numero_ficha, :inspector_id, :reinspector, :responsable_id, :anio_inspeccion, :destino_id, :fecha_entrada, :fecha_salida, :etapa, :observacion, :observacion_interna, :auditar, :validado
  json.url movimiento_url(movimiento, format: :json)
end
