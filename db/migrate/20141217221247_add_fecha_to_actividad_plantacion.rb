class AddFechaToActividadPlantacion < ActiveRecord::Migration
  def change
    add_column :actividades_plantaciones, :fecha, :date
  end
end
