class CreateEstratosDesarrollo < ActiveRecord::Migration
  def change
    create_table :estratos_desarrollo do |t|
      t.string :codigo
      t.string :descripcion

      t.timestamps

      t.index :codigo
    end
  end
end
