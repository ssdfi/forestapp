json.array!(@zona_departamentos) do |zona_departamento|
  json.extract! zona_departamento, :id, :zona_id, :codigo, :descripcion, :codigo_indec
end
