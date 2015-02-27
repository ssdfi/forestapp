class CreateTitulares < ActiveRecord::Migration
  def change
    create_table :titulares do |t|
      t.string :nombre
      t.string :dni
      t.string :cuit

      t.timestamps

      t.index :nombre
      t.index :dni
      t.index :cuit
    end
  end
end
