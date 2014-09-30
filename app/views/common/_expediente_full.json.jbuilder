json.partial! 'common/expediente.json.jbuilder', expediente: @expediente
json.movimientos do
  json.array!(@movimientos) do |movimiento|
    json.partial! 'common/movimiento.json.jbuilder', movimiento: movimiento
    json.actividades movimiento.actividades, partial: 'common/actividad.json.jbuilder', as: :actividad
  end
end
