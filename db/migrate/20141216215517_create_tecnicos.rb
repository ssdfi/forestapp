class CreateTecnicos < ActiveRecord::Migration
  def change
    create_table :tecnicos do |t|
      t.string :nombre
      t.boolean :activo, default: true

      t.timestamps
      t.index :nombre
    end
  end
end
