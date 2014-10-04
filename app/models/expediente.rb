class Expediente < ActiveRecord::Base
  has_many :movimientos
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
end
