class AddAnioToExpediente < ActiveRecord::Migration
  def up
    add_column :expedientes, :anio, :integer
    Expediente.find_each do |expediente|
      anio = expediente.numero_interno[11..12].to_i
      if anio < 80
        expediente.anio = anio + 2000
      else
        expediente.anio = anio + 1900
      end
      expediente.save
    end
  end

  def down
    remove_column :expedientes, :anio
  end
end
