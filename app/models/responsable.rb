class Responsable < ActiveRecord::Base
  has_many :movimientos
  has_many :validaciones, class_name: 'Movimiento', foreign_key: 'validador_id'

  def self.grouped
    return {
      'Activos' => Responsable.where(activo: true).order(:nombre).map { |r| [r.nombre, r.id] },
      'Inactivos' => Responsable.where(activo: false).order(:nombre).map { |r| [r.nombre, r.id] }
    }
  end
end
