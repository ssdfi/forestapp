class AddValidadorToMovimiento < ActiveRecord::Migration
  def change
    add_reference :movimientos, :validador, references: :responsables, index: true
    remove_column :movimientos, :validado, :boolean
    add_foreign_key "movimientos", "responsables", name: "movimientos_validador_id_fk", dependent: :nullify, column: "validador_id"
  end
end
