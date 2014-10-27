class Inspector < ActiveRecord::Base
  has_many :movimientos
  has_many :reinspecciones, class_name: 'Movimiento', foreign_key: 'reinspector_id'
end
