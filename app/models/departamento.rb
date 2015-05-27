class Departamento < ActiveRecord::Base
  belongs_to :provincia
  has_many :plantaciones
end
