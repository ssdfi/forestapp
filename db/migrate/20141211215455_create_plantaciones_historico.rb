class CreatePlantacionesHistorico < ActiveRecord::Migration
  def change
    create_table :plantaciones_historico do |t|
      t.references :plantacion_nueva, references: :plantaciones, index: true
      t.references :plantacion_anterior, references: :plantaciones, index: true

      t.timestamps
    end
  end
end
