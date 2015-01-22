class AddAnioToExpediente < ActiveRecord::Migration
  def up
    add_column :expedientes, :anio, :integer
  end

  def down
    remove_column :expedientes, :anio
  end
end
