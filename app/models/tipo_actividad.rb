class TipoActividad < ActiveRecord::Base
  self.table_name = "tipos_actividad"

  has_many :actividades
end
