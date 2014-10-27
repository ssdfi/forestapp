class ObjetivoPlantacion < ActiveRecord::Base
  self.table_name = "objetivos_plantacion"
  has_many :plantaciones, :foreign_key => "objetivo_plantacion_id"
end
