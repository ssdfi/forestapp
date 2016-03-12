json.array!(@validaciones) do |validacion|
  json.extract! validacion, :id, :plantacion_id, :responsable_id, :especie_1_id, :especie_2_id, :especie_3_id, :edad_estimada, :densidad_estimada, :dap_promedio, :altura_media_dominante, :numero_poda, :numero_raleo, :cantidad_poda, :cantidad_raleo, :sistematizacion_id, :distancia_filas, :distancia_plantas
  json.url validacion_url(validacion, format: :json)
end
