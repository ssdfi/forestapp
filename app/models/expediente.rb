class Expediente < ActiveRecord::Base
  has_many :movimientos
  has_and_belongs_to_many :titulares

  attr_reader :incompleto, :zona, :departamento

  def incompleto=(value)
    @incompleto = (value == "true") unless value.blank?
  end

  def zona
    @zona = Zona.find_by_codigo(numero_interno[0..1]) unless @zona
    @zona
  end

  def departamento
    @departamento = @zona.departamentos.find_by_codigo(numero_interno[3..5]) unless @departamento
    @departamento
  end
end
