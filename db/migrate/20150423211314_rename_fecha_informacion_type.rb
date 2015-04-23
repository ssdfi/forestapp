class RenameFechaInformacionType < ActiveRecord::Migration
  def change
    rename_column :plantaciones, :fecha_informacion, :anio_informacion
  end
end
