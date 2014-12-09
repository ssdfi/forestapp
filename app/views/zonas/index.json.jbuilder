json.array!(@zonas) do |zona|
  json.extract! zona, :id, :codigo, :descripcion, :srid, :provincia, :codigo_indec
  json.url zona_url(zona, format: :json)
end
