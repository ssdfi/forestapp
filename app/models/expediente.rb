class Expediente < ActiveRecord::Base
  belongs_to :zona
  belongs_to :departamento
  belongs_to :tecnico
  has_many :movimientos
  has_and_belongs_to_many :titulares

  attr_reader :incompleto, :fecha_desde, :fecha_hasta, :pendiente, :estabilidad_fiscal, :etapa, :responsable_id, :validado

  before_save :set_values

  def set_values
    if self.numero_interno_changed?
      self.zona = Zona.find_by_codigo(self.numero_interno[0..1])
      self.departamento = self.zona.departamentos.find_by_codigo(self.numero_interno[3..5])
      self.anio = self.numero_interno[11..12].to_i
    end
  end

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

  def etapa=(value)
    @etapa = value unless value.blank?
  end

  def responsable_id=(value)
    @responsable_id = value unless value.blank?
  end

  def validado=(value)
    @validado = value == "true" unless value.blank?
  end

  def fecha_desde=(value)
    @fecha_desde = value unless value.blank?
  end

  def fecha_hasta=(value)
    @fecha_hasta = value unless value.blank?
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
      expedientes = expedientes.where(zona_id: expediente.zona_id) unless expediente.zona_id.nil?
      expedientes = expedientes.where(tecnico_id: expediente.tecnico_id) unless expediente.tecnico_id.nil?
      expedientes = expedientes.where("numero_expediente ILIKE ?", "%#{expediente.numero_expediente}%") unless expediente.numero_expediente.blank?
      expedientes = expedientes.where("numero_expediente IS #{'NOT' unless expediente.incompleto} NULL") unless expediente.incompleto.nil?
      expedientes = expedientes.joins(:movimientos).where("movimientos.responsable_id = ?", expediente.responsable_id) unless expediente.responsable_id.nil?
      expedientes = expedientes.joins(:movimientos).where("expedientes.anio = ? OR movimientos.etapa = ?", expediente.etapa.to_i, expediente.etapa.to_i) unless expediente.etapa.nil?
      expedientes = expedientes.joins(:movimientos).where("movimientos.fecha_entrada >= ?", expediente.fecha_desde) unless expediente.fecha_desde.nil?
      expedientes = expedientes.joins(:movimientos).where("movimientos.fecha_salida <= ?", expediente.fecha_hasta) unless expediente.fecha_hasta.nil?
      expedientes = expedientes.joins(:movimientos).where("movimientos.estabilidad_fiscal = ?", expediente.estabilidad_fiscal) unless expediente.estabilidad_fiscal.nil?
      expedientes = expedientes.joins(:movimientos).where("movimientos.validado = ?", expediente.validado) unless expediente.validado.nil?
      expedientes = expedientes.where(plurianual: expediente.plurianual) unless expediente.plurianual.nil?
      expedientes = expedientes.where(agrupado: expediente.agrupado) unless expediente.agrupado.nil?
      expedientes = expedientes.where(activo: expediente.activo) unless expediente.activo.nil?
      expedientes = expedientes.joins(:movimientos).where("movimientos.fecha_salida IS #{'NOT' unless expediente.pendiente} NULL") unless expediente.pendiente.nil?
      expedientes = expedientes.distinct
    end
    expedientes
  end
end
