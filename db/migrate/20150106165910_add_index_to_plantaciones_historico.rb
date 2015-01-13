class AddIndexToPlantacionesHistorico < ActiveRecord::Migration
  def change
    add_index(:plantaciones_historico, [:plantacion_nueva_id, :plantacion_anterior_id], unique: true, name: "index_plantaciones_historico_on_plantaciones_ids")
  end
end
