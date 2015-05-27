class Zona < ActiveRecord::Base
  has_many :zona_departamentos, class_name: 'ZonaDepartamento'
  has_many :expedientes
end
