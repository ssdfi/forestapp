class CreateValidaciones < ActiveRecord::Migration
  def change
    create_table :validaciones do |t|
      t.references :plantacion, index: true
      t.references :responsable, index: true
      t.references :especie_1, index: true
      t.references :especie_2, index: true
      t.references :especie_3, index: true
      t.integer :edad_estimada
      t.decimal :densidad_estimada
      t.integer :dap_promedio
      t.integer :altura_media_dominante
      t.integer :numero_poda
      t.integer :numero_raleo
      t.integer :cantidad_poda
      t.integer :cantidad_raleo
      t.references :sistematizacion, index: true
      t.decimal :distancia_filas
      t.decimal :distancia_plantas

      t.timestamps
    end
  end
end
