json.array!(@provincias) do |provincia|
  json.extract! provincia, :id, :nombre
  json.url provincia_url(provincia, format: :json)
end
