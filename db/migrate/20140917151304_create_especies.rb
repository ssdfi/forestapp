class CreateEspecies < ActiveRecord::Migration
  def change
    create_table :especies do |t|
      t.references :genero, index: true
      t.string :codigo_sp
      t.string :codigo
      t.string :nombre_cientifico
      t.string :nombre_comun
      t.string :inscripcion_inase

      t.timestamps

      t.index :codigo
      t.index :codigo_sp
    end
  end
end
