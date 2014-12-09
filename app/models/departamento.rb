class Departamento < ActiveRecord::Base
  belongs_to :zona
  has_many :plantaciones
  has_many :expedientes
end
