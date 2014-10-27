class FuenteImagen < ActiveRecord::Base
  self.table_name = "fuentes_imagen"
  has_many :plantaciones, :foreign_key => "fuente_imagen_id"
end
