json.array!(@titulares) do |titular|
  json.extract! titular, :id, :nombre, :dni, :cuit
end
