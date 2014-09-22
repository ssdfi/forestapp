class Especie < ActiveRecord::Base
  belongs_to :genero
  has_and_belongs_to_many :plantaciones
end
