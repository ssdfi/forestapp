class CreatePlantaciones < ActiveRecord::Migration
  def change
    create_table :plantaciones do |t|
      t.references :titular, index: true
      t.string :anio_plantacion
      t.references :tipo_plantacion, index: true
      t.string :nomenclatura_catastral
      t.references :estado_plantacion, index: true
      t.decimal :distancia_plantas
      t.integer :cantidad_filas
      t.decimal :distancia_filas
      t.string :densidad
      t.references :fuente_informacion, index: true
      t.integer :fecha_informacion
      t.references :fuente_imagen, index: true
      t.integer :fecha_imagen
      t.references :zona, index: true
      t.references :departamento, index: true
      t.references :estrato_desarrollo, index: true
      t.references :uso_forestal, index: true
      t.references :uso_anterior, index: true
      t.references :objetivo_plantacion, index: true
      t.boolean :activo
      t.geometry :geom
      t.references :error, index: true
      t.text :comentarios
      t.integer :mpf_id
      t.integer :unificado_id

      t.timestamps
    end
    add_index :plantaciones, :geom, using: :gist
  end
end
