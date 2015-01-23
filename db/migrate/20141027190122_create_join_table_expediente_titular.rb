class CreateJoinTableExpedienteTitular < ActiveRecord::Migration
  create_join_table :expedientes, :titulares do |t|
    end
end
