json.array!(@generos) do |genero|
  json.extract! genero, :id, :codigo, :descripcion
  json.url genero_url(genero, format: :json)
end
