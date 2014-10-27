class FuenteInformacion < ActiveRecord::Base
  self.table_name = "fuentes_informacion"
  has_many :plantaciones, :foreign_key => "fuente_informacion_id"
end
