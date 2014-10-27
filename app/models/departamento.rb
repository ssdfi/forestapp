class Departamento < ActiveRecord::Base
  belongs_to :zona
  has_many :plantaciones
end
