class CreateEstadosAprobacion < ActiveRecord::Migration
  def change
    create_table :estados_aprobacion do |t|
      t.string :codigo
      t.string :descripcion

      t.timestamps

      t.index :codigo
    end
  end
end
