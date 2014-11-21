class Expediente < ActiveRecord::Base
  has_many :movimientos
  has_and_belongs_to_many :titulares

  attr_reader :incompleto, :fecha_desde, :fecha_hasta, :zona, :departamento, :pendiente

  def incompleto=(value)
    if !!value == value
      @incompleto = value
    elsif not value.blank?
      @incompleto = (value == "true")
    end
  end

  def pendiente=(value)
    if !!value == value
      @pendiente = value
    elsif not value.blank?
      @pendiente = (value == "true")
    end
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

  def ultima_entrada
    movimientos.order(:fecha_entrada).last.fecha_entrada
  end

  def ultima_salida
    movimientos.order(:fecha_salida).last.fecha_salida
  end

end
