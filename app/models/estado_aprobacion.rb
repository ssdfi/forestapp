class EstadoAprobacion < ActiveRecord::Base
  self.table_name = "estados_aprobacion"

  has_many :actividades_plantaciones
  has_many :actividades, through: :actividades_plantaciones
  has_many :plantaciones, through: :actividades_plantaciones
end
