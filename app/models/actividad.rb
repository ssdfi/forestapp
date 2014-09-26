class Actividad < ActiveRecord::Base
  belongs_to :movimiento
  belongs_to :tipo_actividad

  has_many :actividades_plantaciones, class_name: 'ActividadPlantacion', foreign_key: 'actividad_id'
  has_many :plantaciones, through: :actividades_plantaciones, source: :plantacion
end
