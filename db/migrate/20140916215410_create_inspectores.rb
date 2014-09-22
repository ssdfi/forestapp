class CreateInspectores < ActiveRecord::Migration
  def change
    create_table :inspectores do |t|
      t.string :codigo
      t.string :descripcion

      t.timestamps

      t.index :codigo
    end
  end
end
