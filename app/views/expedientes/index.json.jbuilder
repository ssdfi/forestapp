json.array!(@expedientes) do |expediente|
  json.extract! expediente, :id, :numero_interno, :numero_expediente, :titular, :tecnico, :plurianual, :agregado, :activo
  json.url expediente_url(expediente, format: :json)
end
