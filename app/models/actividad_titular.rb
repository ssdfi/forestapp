class ActividadTitular < ActiveRecord::Base
  self.table_name = "actividades_titulares"

  belongs_to :actividad
  belongs_to :titular
  belongs_to :especie
  belongs_to :tipo_plantacion
end
