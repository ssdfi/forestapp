class CreateActividadesPlantaciones < ActiveRecord::Migration
  def change
    create_table :actividades_plantaciones do |t|
      t.references :actividad, index: true
      t.references :plantacion, index: true
      t.references :estado_aprobacion, index: true
      t.decimal :superficie_registrada
      t.integer :numero_plantas
      t.date :fecha
      t.text :observaciones

      t.timestamps
    end
  end
end
