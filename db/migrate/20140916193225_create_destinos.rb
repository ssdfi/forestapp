class CreateDestinos < ActiveRecord::Migration
  def change
    create_table :destinos do |t|
      t.string :codigo
      t.string :descripcion

      t.timestamps

      t.index :codigo
    end
  end
end
