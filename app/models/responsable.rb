class Responsable < ActiveRecord::Base
  has_many :movimientos
  has_many :validaciones_movimientos, class_name: 'Movimiento', foreign_key: 'validador_id'
  has_many :validaciones_plantaciones, class_name: 'Validacion', foreign_key: 'responsable_id'

  def self.grouped
    return {
      'Activos' => Responsable.where(activo: true).order(:nombre).map { |r| [r.nombre, r.id] },
      'Inactivos' => Responsable.where(activo: false).order(:nombre).map { |r| [r.nombre, r.id] }
    }
  end
end
