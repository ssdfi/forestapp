class CreateMovimientos < ActiveRecord::Migration
  def change
    create_table :movimientos do |t|
      t.references :expediente, index: true
      t.integer :numero_ficha
      t.references :inspector, index: true
      t.references :reinspector, references: :inspectores, index: true
      t.references :responsable, index: true
      t.string :anio_inspeccion
      t.references :destino, index: true
      t.date :fecha_entrada
      t.date :fecha_salida
      t.string :etapa
      t.boolean :estabilidad_fiscal
      t.text :observacion
      t.text :observacion_interna
      t.boolean :auditar
      t.boolean :validado

      t.timestamps
    end
  end
end
