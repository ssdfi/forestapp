class CreateJoinTableActividadPlantacion < ActiveRecord::Migration
  def change
    create_join_table :actividades, :expedientes do |t|
      # t.index [:plantacion_id, :especie_id]
      # t.index [:especie_id, :plantacion_id]
    end
  end
end
