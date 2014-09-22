class CreateObjetivosPlantacion < ActiveRecord::Migration
  def change
    create_table :objetivos_plantacion do |t|
      t.string :codigo
      t.string :descripcion

      t.timestamps

      t.index :codigo
    end
  end
end
