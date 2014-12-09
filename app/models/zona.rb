class Zona < ActiveRecord::Base
  has_many :departamentos
  has_many :plantaciones
  has_many :expedientes
end
