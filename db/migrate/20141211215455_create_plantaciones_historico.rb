class CreatePlantacionesHistorico < ActiveRecord::Migration
  def change
    create_table :plantaciones_historico do |t|
      t.references :plantacion_nueva, references: :plantaciones, index: true
      t.references :plantacion_anterior, references: :plantaciones, index: true

      t.timestamps
    end
    add_index :plantaciones_historico, [:plantacion_nueva_id, :plantacion_anterior_id], unique: true, name: "index_plantaciones_historico_on_plantaciones_ids"
  end
end
