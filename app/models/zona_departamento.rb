class ZonaDepartamento < ActiveRecord::Base
  self.table_name = 'zona_departamentos'
  belongs_to :zona
  has_many :expedientes
end
