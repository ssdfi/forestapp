class CreateFuentesImagen < ActiveRecord::Migration
  def change
    create_table :fuentes_imagen do |t|
      t.string :codigo
      t.string :descripcion

      t.timestamps

      t.index :codigo
    end
  end
end
