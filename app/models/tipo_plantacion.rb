class TipoPlantacion < ActiveRecord::Base
  self.table_name = "tipos_plantacion"
  has_many :plantaciones, :foreign_key => "tipo_plantacion_id"
  has_many :actividades_titulares, :foreign_key => "tipo_plantacion_id", class_name: 'ActividadTitular'
end
