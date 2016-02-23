class Movimiento < ActiveRecord::Base
  belongs_to :expediente
  belongs_to :inspector
  belongs_to :reinspector, class_name: 'Inspector', foreign_key: 'reinspector_id'
  belongs_to :responsable
  belongs_to :destino
  belongs_to :validador, class_name: 'Responsable', foreign_key: 'validador_id'

  has_many :actividades
  has_many :actividades_plantaciones, class_name: 'ActividadPlantacion', through: :actividades

  validates :fecha_entrada, presence: true
  validates :fecha_entrada, date: {
    after_or_equal_to: Date.new(1990, 1, 1),
    message: "no puede ser anterior a 01/01/1990"
  }
  validates :fecha_entrada, :fecha_salida, date: {
    before_or_equal_to: Date.today,
    message: "no puede ser posterior al día actual",
    allow_blank: true }
  validates :fecha_salida, date: {
    after_or_equal_to: :fecha_entrada,
    message: "no puede ser anterior a la fecha de entrada",
    allow_blank: true }

  def validado
    !validador.nil?
  end

  def informe
    file = File.join(Rails.application.config.path_informes_rf, id.to_s + '.pdf')
    return File.exist?(file) ? file : nil
  end
end
