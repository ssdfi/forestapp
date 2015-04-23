class CreateBasesGeometricas < ActiveRecord::Migration
  def up
    create_table :bases_geometricas do |t|
      t.string :codigo
      t.string :descripcion
    end

    BaseGeometrica.create!([
      {codigo: "FA", descripcion: "Fotos aéreas"},
      {codigo: "SI", descripcion: "Servidor de imagen"}
    ])
  end

  def down
    drop_table :bases_geometricas
  end
end
