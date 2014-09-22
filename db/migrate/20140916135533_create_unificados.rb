class CreateUnificados < ActiveRecord::Migration
  def change
    create_table :unificados do |t|
      t.string :zona
      t.string :anio
      t.string :actividad
      t.string :estado
      t.string :numero_interno
      t.string :anio_plantacion
      t.string :tipo_plantacion
      t.string :codigo_titular
      t.string :numero_productor
      t.string :titular
      t.string :especie
      t.integer :numero_plantas
      t.decimal :superficie
      t.string :inspector
      t.string :responsable
      t.text :observaciones
      t.geometry :geom

      t.timestamps
    end

    change_table :unificados do |t|
      t.index :geom, :spatial => true
    end
  end
end
