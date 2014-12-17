class AddNumeroPlantasToActividadPlantacion < ActiveRecord::Migration
  def change
    add_column :actividades_plantaciones, :numero_plantas, :integer
  end
end
