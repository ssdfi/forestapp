class EstadoPlantacion < ActiveRecord::Base
  self.table_name = "estados_plantacion"
  has_many :plantaciones, :foreign_key => "estado_plantacion_id"
end
