class Actividad < ActiveRecord::Base
  belongs_to :movimiento
  belongs_to :tipo_actividad
end
