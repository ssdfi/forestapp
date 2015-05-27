class CreateProvincias < ActiveRecord::Migration
  def change
    create_table :provincias do |t|
      t.string :nombre
      t.string :codigo
      t.multi_polygon :geom, srid: 4326
    end
    add_index :provincias, :geom, using: :gist
    add_index :provincias, :nombre
    add_index :provincias, :codigo
  end
end
