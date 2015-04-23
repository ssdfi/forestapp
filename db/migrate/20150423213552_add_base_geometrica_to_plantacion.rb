class AddBaseGeometricaToPlantacion < ActiveRecord::Migration
  def change
    add_reference :plantaciones, :base_geometrica, index: true
  end
end
