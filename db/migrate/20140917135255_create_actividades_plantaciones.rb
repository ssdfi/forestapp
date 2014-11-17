class CreateActividadesPlantaciones < ActiveRecord::Migration
  def change
    create_table :actividades_plantaciones do |t|
      t.references :actividad, index: true
      t.references :plantacion, index: true
      t.decimal :superficie_presentada
      t.decimal :superficie_certificada
      t.decimal :superficie_inspeccionada
      t.decimal :superficie_registrada
      t.references :estado_aprobacion, index: true
      t.text :comentarios

      t.timestamps
    end
  end
end
