class Actividad < ActiveRecord::Base
  belongs_to :movimiento
  belongs_to :tipo_actividad
  has_many :plantaciones
  has_many :actividades_plantaciones, class_name: 'ActividadPlantacion'
  has_many :plantaciones, :through => :actividades_plantaciones
end
