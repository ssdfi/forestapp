json.array!(@provincias) do |provincia|
  json.extract! provincia, :id, :nombre, :codigo
  json.url provincia_url(provincia, format: :json)
end
