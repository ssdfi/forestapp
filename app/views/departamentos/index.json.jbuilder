json.array!(@departamentos) do |departamento|
  json.extract! departamento, :id, :zona_id, :codigo, :descripcion, :codigo_indec
end
