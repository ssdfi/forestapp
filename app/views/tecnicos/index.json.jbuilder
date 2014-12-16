json.array!(@tecnicos) do |tecnico|
  json.extract! tecnico, :id, :nombre, :activo
  json.url tecnico_url(tecnico, format: :json)
end
