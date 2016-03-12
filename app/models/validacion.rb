class Validacion < ActiveRecord::Base
  belongs_to :plantacion
  belongs_to :responsable
  belongs_to :especie_1, class_name: 'Especie', foreign_key: 'especie_1_id'
  belongs_to :especie_2, class_name: 'Especie', foreign_key: 'especie_2_id'
  belongs_to :especie_3, class_name: 'Especie', foreign_key: 'especie_3_id'
  belongs_to :sistematizacion

  validates :plantacion_id, :responsable_id, presence: true
end
