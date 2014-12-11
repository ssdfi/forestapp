class Especie < ActiveRecord::Base
  belongs_to :genero
  has_and_belongs_to_many :plantaciones

  def self.search(especie)
    especies = all
    if especie
      especies = where("nombre_comun ILIKE ?", "%#{especie.nombre_comun}%") unless especie.nombre_comun.blank?
      especies = where("nombre_cientifico ILIKE ?", "%#{especie.nombre_cientifico}%") unless especie.nombre_cientifico.blank?
      especies = where("codigo_sp ILIKE ?", "%#{especie.codigo_sp}%") unless especie.codigo_sp.blank?
      especies = where(genero_id: especie.genero_id) unless especie.genero_id.nil?
    end
    especies
  end
end
