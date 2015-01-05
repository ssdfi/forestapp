class RemoveSuperficiesFromActividadesPlantaciones < ActiveRecord::Migration
  def change
    remove_column :actividades_plantaciones, :superficie_presentada, :decimal
    remove_column :actividades_plantaciones, :superficie_certificada, :decimal
    remove_column :actividades_plantaciones, :superficie_inspeccionada, :decimal
  end
end
