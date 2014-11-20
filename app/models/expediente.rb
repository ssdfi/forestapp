class Expediente < ActiveRecord::Base
  has_many :movimientos
  has_and_belongs_to_many :titulares

  attr_reader :incompleto, :fecha_desde, :fecha_hasta, :zona, :departamento

  def incompleto=(value)
    @incompleto = (value == "true") unless value.blank?
  end

  def fecha_desde=(value)
    @fecha_desde = value unless value.blank?
  end

  def fecha_hasta=(value)
    @fecha_hasta = value unless value.blank?
  end

  def zona
    @zona = Zona.find_by_codigo(numero_interno[0..1]) unless @zona
    @zona
  end

  def departamento
    @departamento = @zona.departamentos.find_by_codigo(numero_interno[3..5]) unless @departamento
    @departamento
  end

  def fecha_entrada
    movimientos.order(:fecha_entrada).first.fecha_entrada
  end

  def fecha_salida
    movimientos.order(:fecha_salida).last.fecha_salida
  end

end
