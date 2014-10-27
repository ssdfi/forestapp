class Titular < ActiveRecord::Base
  has_many :plantaciones
  has_and_belongs_to_many :expedientes
end
