class CreateUsosAnteriores < ActiveRecord::Migration
  def change
    create_table :usos_anteriores do |t|
      t.string :codigo
      t.string :descripcion

      t.timestamps

      t.index :codigo
    end
  end
end
