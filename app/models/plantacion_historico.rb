class PlantacionHistorico < ActiveRecord::Base
  belongs_to :plantacion_nueva, class_name: 'Plantacion', foreign_key: 'plantacion_nueva_id'
  belongs_to :plantacion_anterior, class_name: 'Plantacion', foreign_key: 'plantacion_anterior_id'
end
