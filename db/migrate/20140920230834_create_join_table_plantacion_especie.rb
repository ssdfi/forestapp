class CreateJoinTablePlantacionEspecie < ActiveRecord::Migration
  def change
    create_join_table :plantaciones, :especies do |t|
    end
  end
end
