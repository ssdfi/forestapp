class Actividad < ActiveRecord::Base
  belongs_to :movimiento
  belongs_to :tipo_actividad
  has_many :plantaciones
  has_many :actividades_plantaciones, class_name: 'ActividadPlantacion'
  has_many :plantaciones, :through => :actividades_plantaciones

  accepts_nested_attributes_for :actividades_plantaciones, reject_if: :all_blank, allow_destroy: true

  ##
  # Si el atributo no tiene valor, calcula la superfice registrada a partir de la sumatoria de las superficies de las
  # plantaciones asociadas a la actividad
  def superficie_registrada
    read_attribute(:superficie_registrada) || actividades_plantaciones.sum(:superficie_registrada)
  end
end
