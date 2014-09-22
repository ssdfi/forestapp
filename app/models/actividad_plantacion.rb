class ActividadPlantacion < ActiveRecord::Base
  self.table_name = "actividades_plantaciones"

  belongs_to :actividad
  belongs_to :plantacion
  belongs_to :estado_aprobacion
end
