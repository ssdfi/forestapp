json.array!(@plantaciones) do |plantacion|
  json.extract! plantacion, :id
  json.url plantacion_url(plantacion, format: :json)
end
