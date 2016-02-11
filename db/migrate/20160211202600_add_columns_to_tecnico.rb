class AddColumnsToTecnico < ActiveRecord::Migration
  def change
    add_column :tecnicos, :dni, :string
    add_column :tecnicos, :cuit, :string

    add_index :tecnicos, :dni
    add_index :tecnicos, :cuit
  end
end
