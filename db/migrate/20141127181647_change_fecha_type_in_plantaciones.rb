class ChangeFechaTypeInPlantaciones < ActiveRecord::Migration
  def up
    Plantacion.where("fecha_informacion !~ E'^\\d{4}$' OR fecha_imagen !~ E'^\\d{4}$'").find_each do |plantacion|
      plantacion.fecha_informacion = nil unless /^\d{4}$/.match(plantacion.fecha_informacion)
      plantacion.fecha_imagen = nil unless /^\d{4}$/.match(plantacion.fecha_imagen)
      plantacion.save
    end
    change_column :plantaciones, :fecha_informacion, "integer USING (fecha_informacion::integer)"
    change_column :plantaciones, :fecha_imagen, "integer USING (fecha_imagen::integer)"
  end

  def down
    change_column :plantaciones, :fecha_informacion, :string
    change_column :plantaciones, :fecha_imagen, :string
  end
end
