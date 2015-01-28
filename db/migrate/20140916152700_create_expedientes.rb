class CreateExpedientes < ActiveRecord::Migration
  def change
    create_table :expedientes do |t|
      t.string :numero_interno
      t.string :numero_expediente
      t.references :tecnico, index: true
      t.references :zona, index: true
      t.references :departamento, index: true
      t.boolean :agrupado
      t.boolean :plurianual
      t.boolean :activo
      t.integer :anio

      t.timestamps

      t.index :numero_interno
      t.index :numero_expediente
    end
  end
end
