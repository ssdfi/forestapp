class Expediente < ActiveRecord::Base
  has_many :movimientos
  has_and_belongs_to_many :titulares
  
  attr_reader :incompleto

  def incompleto=(value)
    @incompleto = (value == "true") unless value.blank?
  end

  def zona
    Zona.find_by_codigo(numero_interno[0..1])
  end

  def departamento
    Departamento.find_by_codigo(numero_interno[3..5])
  end

  def productores
    if productor
      [productor]
    else
      entidades_productores.productores
    end
  end

end
