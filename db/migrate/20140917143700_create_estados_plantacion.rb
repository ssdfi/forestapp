class CreateEstadosPlantacion < ActiveRecord::Migration
  def change
    create_table :estados_plantacion do |t|
      t.string :codigo, index: true
      t.string :descripcion

      t.timestamps
    end
  end
end
