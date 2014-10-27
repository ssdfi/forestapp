class CreateJoinTableExpedienteTitular < ActiveRecord::Migration
  create_join_table :expedientes, :titulares do |t|
      # t.index [:plantacion_id, :especie_id]
      # t.index [:especie_id, :plantacion_id]
    end
end
