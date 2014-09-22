class CreateUsosForestales < ActiveRecord::Migration
  def change
    create_table :usos_forestales do |t|
      t.string :codigo
      t.string :descripcion

      t.timestamps

      t.index :codigo
    end
  end
end
