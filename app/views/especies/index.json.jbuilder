json.array!(@especies) do |especie|
  json.extract! especie, :id, :genero_id, :codigo_sp, :codigo, :nombre_cientifico, :nombre_comun, :inscripcion_inase
end
