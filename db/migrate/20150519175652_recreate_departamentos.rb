class RecreateDepartamentos < ActiveRecord::Migration
  def change
    create_table :departamentos do |t|
      t.references :provincia, index: true
      t.string :nombre
      t.string :codigo
      t.multi_polygon :geom
    end
    add_index :departamentos, :geom, using: :gist
    add_index :departamentos, :nombre
    add_foreign_key :departamentos, :provincias

    change_table :plantaciones do |t|
      t.remove_references :zona, index: true, foreign_key: true
      t.remove_references :departamento, index: true, foreign_key: true
      t.references :provincia, index: true
      t.references :departamento, index: true
    end
    add_foreign_key :plantaciones, :provincias
    add_foreign_key :plantaciones, :departamentos
  end
end
