class TipoPlantacion < ActiveRecord::Base
  self.table_name = "tipos_plantacion"
  has_many :plantaciones, :foreign_key => "tipo_plantacion_id"
end
