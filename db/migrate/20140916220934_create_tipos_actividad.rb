class CreateTiposActividad < ActiveRecord::Migration
  def change
    create_table :tipos_actividad do |t|
      t.string :codigo
      t.string :descripcion

      t.timestamps

      t.index :codigo
    end
  end
end
