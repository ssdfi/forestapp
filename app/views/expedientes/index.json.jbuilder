json.array!(@expedientes) do |expediente|
  json.extract! expediente, :id, :numero_interno, :numero_expediente, :plurianual, :agrupado, :activo
  json.titulares do
    json.array!(expediente.titulares) do |titular|
      json.extract! titular, :id, :nombre, :dni, :cuit
    end
  end
end
