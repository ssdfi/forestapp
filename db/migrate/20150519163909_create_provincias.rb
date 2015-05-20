class CreateProvincias < ActiveRecord::Migration
  def change
    create_table :provincias do |t|
      t.string :nombre
      t.multi_polygon :geom, srid: 4326
    end
    add_index :provincias, :geom, using: :gist
    add_index :provincias, :nombre
  end
end
