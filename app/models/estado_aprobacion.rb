class EstadoAprobacion < ActiveRecord::Base
  self.table_name = 'estados_aprobacion'

  has_many :actividades_plantaciones, class_name: 'ActividadPlantacion'
end