json.array!(@actividades) do |actividad|
  json.partial! 'common/actividad', actividad: actividad
end
