class Movimiento < ActiveRecord::Base
  belongs_to :expediente
  belongs_to :inspector
  belongs_to :reinspector, class_name: 'Inspector', foreign_key: 'reinspector_id'
  belongs_to :responsable
  belongs_to :destino
  belongs_to :validador, class_name: 'Responsable', foreign_key: 'validador_id'

  has_many :actividades


  def validado
    !validador.nil?
  end
end