class CreatePagos < ActiveRecord::Migration
  def change
    create_table :pagos do |t|
      t.string :resolucion, index: true
      t.date :fecha, index: true
      t.string :listado
      t.references :actividad, index: true
      t.decimal :monto, index: true
      t.decimal :superficie, index: true

      t.timestamps
    end
  end
end
