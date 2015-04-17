class ChangePlantacionesFechaType < ActiveRecord::Migration
  def change
    change_column :plantaciones, :fecha_informacion, "date USING to_date(fecha_informacion::varchar, 'yyyy')"
    change_column :plantaciones, :fecha_imagen, "date USING to_date(fecha_imagen::varchar, 'yyyy')"
  end
end
