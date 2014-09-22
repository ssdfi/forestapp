class CreateExpedientes < ActiveRecord::Migration
  def change
    create_table :expedientes do |t|
      t.string :numero_interno
      t.string :numero_expediente
      t.string :titular
      t.string :tecnico
      t.boolean :plurianual
      t.boolean :agregado
      t.boolean :activo

      t.timestamps

      t.index :numero_interno
      t.index :numero_expediente
    end
  end
end
