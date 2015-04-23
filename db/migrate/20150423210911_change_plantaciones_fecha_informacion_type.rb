class ChangePlantacionesFechaInformacionType < ActiveRecord::Migration
  def change
    change_column :plantaciones, :fecha_informacion, "integer USING extract(year from fecha_informacion)::integer"
  end
end
