class CreateActividadesTitulares < ActiveRecord::Migration
  def change
    create_table :actividades_titulares do |t|
      t.references :actividad, index: true
      t.references :titular, index: true
      t.references :especie, index: true
      t.references :tipo_plantacion, index: true
      t.decimal :superficie_presentada
      t.decimal :superficie_certificada
      t.decimal :superficie_inspeccionada
      t.text :observaciones
    end
    add_foreign_key "actividades_titulares", "actividades", name: "actividades_titulares_actividad_id_fk", dependent: :delete
    add_foreign_key "actividades_titulares", "titulares", name: "actividades_titulares_titular_id_fk", dependent: :delete
    add_foreign_key "actividades_titulares", "tipos_plantacion", name: "actividades_titulares_tipo_plantacion_id_fk", dependent: :nullify
    add_foreign_key "actividades_titulares", "especies", name: "actividades_titulares_especie_id_fk", dependent: :nullify
  end
end
