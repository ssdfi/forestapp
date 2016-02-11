class Tecnico < ActiveRecord::Base
  has_many :expedientes

  validates :nombre, presence: true
  validates :cuit, :dni, uniqueness: true, numericality: { only_integer: true }, allow_blank: true
  validates :cuit, length: { is: 11 }, allow_blank: true
  validates :dni, length: { is: 8 }, allow_blank: true

  ##
  # Busca los técnicos que coincidan con los atributos definidos en el objeto Tecnico pasado como parámetro
  def self.search(tecnico)
    tecnicos = all
    if tecnico
      tecnicos = where("nombre ILIKE ?", "%#{tecnico.nombre}%") unless tecnico.nombre.blank?
      tecnicos = tecnicos.where(activo: tecnico.activo) unless tecnico.activo.nil?
      tecnicos = tecnicos.distinct
    end
    tecnicos.order(:nombre)
  end
end
