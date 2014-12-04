class Expediente < ActiveRecord::Base
  has_many :movimientos
  has_and_belongs_to_many :titulares

  attr_reader :incompleto, :fecha_desde, :fecha_hasta, :zona, :departamento, :pendiente, :estabilidad_fiscal

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

  def estabilidad_fiscal=(value)
    if !!value == value
      @estabilidad_fiscal = value
    elsif not value.blank?
      @estabilidad_fiscal = (value == "true")
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
    @departamento = @zona.departamentos.find_by_codigo(numero_interno[3..5]) unless @departamento or @zona.nil?
    @departamento
  end

  def ultima_entrada
    movimientos.order(:fecha_entrada).last.fecha_entrada if movimientos.count > 0
  end

  def ultima_salida
    movimientos.order(:fecha_salida).last.fecha_salida if movimientos.count > 0
  end

  def self.search(expediente)
    expedientes = all
    if expediente
      expedientes = expedientes.where("numero_interno ILIKE ?", "%#{expediente.numero_interno}%") unless expediente.numero_interno.blank?
      expedientes = expedientes.where("numero_expediente ILIKE ?", "%#{expediente.numero_expediente}%") unless expediente.numero_expediente.blank?
      expedientes = expedientes.where("numero_expediente IS #{'NOT' unless expediente.incompleto} NULL") unless expediente.incompleto.nil?
      expedientes = expedientes.joins(:movimientos).where("movimientos.fecha_entrada >= ?", expediente.fecha_desde) unless expediente.fecha_desde.nil?
      expedientes = expedientes.joins(:movimientos).where("movimientos.fecha_salida <= ?", expediente.fecha_hasta) unless expediente.fecha_hasta.nil?
      expedientes = expedientes.joins(:movimientos).where("movimientos.estabilidad_fiscal = ?", expediente.estabilidad_fiscal) unless expediente.estabilidad_fiscal.nil?
      expedientes = expedientes.where(plurianual: expediente.plurianual) unless expediente.plurianual.nil?
      expedientes = expedientes.where(agrupado: expediente.agrupado) unless expediente.agrupado.nil?
      expedientes = expedientes.where(activo: expediente.activo) unless expediente.activo.nil?
      expedientes = expedientes.joins(:movimientos).where("movimientos.fecha_salida IS #{'NOT' unless expediente.pendiente} NULL") unless expediente.pendiente.nil?
    end
    expedientes
  end
end
