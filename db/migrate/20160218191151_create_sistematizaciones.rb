class CreateSistematizaciones < ActiveRecord::Migration
  def change
    create_table :sistematizaciones do |t|
      t.string :descripcion

      t.timestamps
    end

    Sistematizacion.create(
      [
        { descripcion: 'Abierto' },
        { descripcion: 'Semicerrado' },
        { descripcion: 'Cerrado' }
      ]
    )
  end
end
