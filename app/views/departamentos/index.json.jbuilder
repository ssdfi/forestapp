json.array!(@departamentos) do |departamento|
  json.extract! departamento, :id, :provincia_id, :nombre
end
