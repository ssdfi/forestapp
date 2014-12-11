json.array!(@especies) do |especie|
  json.extract! especie, :id, :genero_id, :codigo_sp, :codigo, :nombre_cientifico, :nombre_comun, :inscripcion_inase
  json.url especie_url(especie, format: :json)
end
