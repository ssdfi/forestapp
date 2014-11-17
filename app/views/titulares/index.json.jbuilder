json.array!(@titulares) do |titular|
  json.extract! titular, :id
  json.url titular_url(titular, format: :json)
end
