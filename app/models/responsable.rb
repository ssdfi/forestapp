class Responsable < ActiveRecord::Base
  has_many :movimientos
  has_many :validaciones, class_name: 'Movimiento', foreign_key: 'validador_id'
end
