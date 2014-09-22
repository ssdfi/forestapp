class CreateDepartamentos < ActiveRecord::Migration
  def change
    create_table :departamentos do |t|
      t.references :zona, index: true
      t.string :codigo
      t.string :descripcion
      t.string :codigo_indec

      t.timestamps

      t.index :codigo
    end
  end
end
