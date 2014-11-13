class CreateTmpTitulares < ActiveRecord::Migration
  def change
    create_table :tmp_titulares do |t|
      t.string :numero_interno
      t.string :numero_productor
      t.string :titular
      t.string :dni
      t.string :cuit
      t.string :fuente
      t.string :titular_mayusculas
      t.index :numero_interno
      t.index :dni
      t.index :cuit
      t.index :titular
      t.index :titular_mayusculas
    end
  end
end
