class CreateActividadesPlantaciones < ActiveRecord::Migration
  def change
    create_table :actividades_plantaciones do |t|
      t.references :actividad, index: true
      t.references :plantacion, index: true
      t.decimal :superficie
      t.references :estado_aprobacion, index: true
      t.text :comentarios

      t.timestamps
    end
  end
end
