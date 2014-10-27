class Zona < ActiveRecord::Base
  has_many :departamentos
  has_many :plantaciones
end
