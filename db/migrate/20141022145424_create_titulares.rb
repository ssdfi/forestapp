class CreateTitulares < ActiveRecord::Migration
  def change
    create_table :titulares do |t|
      t.string :nombre
      t.string :dni
      t.string :cuit

      t.timestamps
    end
  end
end
