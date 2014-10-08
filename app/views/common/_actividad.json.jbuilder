json.extract! actividad, :id, :movimiento_id, :tipo_actividad, :superficie_presentada, :superficie_certificada, :superficie_inspeccionada, :superficie_registrada, :created_at, :updated_at
json.map_url expediente_movimiento_actividad_map_url(@expediente, actividad.movimiento, actividad)
