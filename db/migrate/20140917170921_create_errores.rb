class CreateErrores < ActiveRecord::Migration
  def change
    create_table :errores do |t|
      t.string :descripcion

      t.timestamps
    end
  end
end
