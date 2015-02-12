class AddIndexToPlantaciones < ActiveRecord::Migration
  def change
    add_index :plantaciones, :geom, using: :gist
  end
end
