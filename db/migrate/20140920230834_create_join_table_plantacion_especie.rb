class CreateJoinTablePlantacionEspecie < ActiveRecord::Migration
  def change
    create_join_table :plantaciones, :especies do |t|
      # t.index [:plantacion_id, :especie_id]
      # t.index [:especie_id, :plantacion_id]
    end
  end
end
