class CreateAnticipos < ActiveRecord::Migration
  def change
    create_table :anticipos do |t|
      t.string :resolucion
      t.date :fecha
      t.string :listado
      t.references :expediente
      t.decimal :monto

      t.timestamps
    end
  end
end
