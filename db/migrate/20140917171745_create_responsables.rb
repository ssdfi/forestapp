class CreateResponsables < ActiveRecord::Migration
  def change
    create_table :responsables do |t|
      t.string :codigo
      t.string :iniciales
      t.string :nombre
      t.boolean :activo

      t.timestamps
    end
  end
end
