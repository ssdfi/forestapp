class CreateZonas < ActiveRecord::Migration
  def change
    create_table :zonas do |t|
      t.string :codigo
      t.string :descripcion
      t.integer :srid
      t.string :provincia
      t.string :codigo_indec

      t.timestamps

      t.index :codigo
    end
  end
end
