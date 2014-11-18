class CreateActividades < ActiveRecord::Migration
  def change
    create_table :actividades do |t|
      t.references :movimiento, index: true
      t.references :tipo_actividad, index: true
      t.decimal :superficie_presentada
      t.decimal :superficie_certificada
      t.decimal :superficie_inspeccionada
      t.decimal :superficie_registrada

      t.timestamps
    end
  end
end
