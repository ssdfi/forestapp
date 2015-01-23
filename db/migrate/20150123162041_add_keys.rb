class AddKeys < ActiveRecord::Migration
  def change
    add_foreign_key "actividades", "movimientos", name: "actividades_movimiento_id_fk", dependent: :delete
    add_foreign_key "actividades_plantaciones", "actividades", name: "actividades_plantaciones_actividad_id_fk", dependent: :delete
    add_foreign_key "actividades_plantaciones", "estados_aprobacion", name: "actividades_plantaciones_estado_aprobacion_id_fk", dependent: :nullify
    add_foreign_key "actividades_plantaciones", "plantaciones", name: "actividades_plantaciones_plantacion_id_fk", dependent: :delete
    add_foreign_key "actividades", "tipos_actividad", name: "actividades_tipo_actividad_id_fk", dependent: :nullify
    add_foreign_key "departamentos", "zonas", name: "departamentos_zona_id_fk", dependent: :delete
    add_foreign_key "especies", "generos", name: "especies_genero_id_fk", dependent: :delete
    add_foreign_key "especies_plantaciones", "especies", name: "especies_plantaciones_especie_id_fk", dependent: :delete
    add_foreign_key "especies_plantaciones", "plantaciones", name: "especies_plantaciones_plantacion_id_fk", dependent: :delete
    add_foreign_key "expedientes", "departamentos", name: "expedientes_departamento_id_fk", dependent: :nullify
    add_foreign_key "expedientes", "tecnicos", name: "expedientes_tecnico_id_fk", dependent: :nullify
    add_foreign_key "expedientes_titulares", "expedientes", name: "expedientes_titulares_expediente_id_fk", dependent: :delete
    add_foreign_key "expedientes_titulares", "titulares", name: "expedientes_titulares_titular_id_fk", dependent: :delete
    add_foreign_key "expedientes", "zonas", name: "expedientes_zona_id_fk", dependent: :nullify
    add_foreign_key "movimientos", "destinos", name: "movimientos_destino_id_fk", dependent: :nullify
    add_foreign_key "movimientos", "expedientes", name: "movimientos_expediente_id_fk", dependent: :delete
    add_foreign_key "movimientos", "inspectores", name: "movimientos_inspector_id_fk", dependent: :nullify
    add_foreign_key "movimientos", "inspectores", name: "movimientos_reinspector_id_fk", dependent: :nullify, column: "reinspector_id"
    add_foreign_key "movimientos", "responsables", name: "movimientos_responsable_id_fk", dependent: :nullify, column: "responsable_id"
    add_foreign_key "plantaciones", "departamentos", name: "plantaciones_departamento_id_fk", dependent: :nullify
    add_foreign_key "plantaciones", "errores", name: "plantaciones_error_id_fk", dependent: :nullify
    add_foreign_key "plantaciones", "estados_plantacion", name: "plantaciones_estado_plantacion_id_fk", dependent: :nullify
    add_foreign_key "plantaciones", "estratos_desarrollo", name: "plantaciones_estrato_desarrollo_id_fk", dependent: :nullify
    add_foreign_key "plantaciones", "fuentes_imagen", name: "plantaciones_fuente_imagen_id_fk", dependent: :nullify
    add_foreign_key "plantaciones", "fuentes_informacion", name: "plantaciones_fuente_informacion_id_fk", dependent: :nullify
    add_foreign_key "plantaciones_historico", "plantaciones", name: "plantaciones_historico_plantacion_anterior_id_fk", dependent: :delete, column: "plantacion_anterior_id"
    add_foreign_key "plantaciones_historico", "plantaciones", name: "plantaciones_historico_plantacion_nueva_id_fk", dependent: :delete, column: "plantacion_nueva_id"
    add_foreign_key "plantaciones", "objetivos_plantacion", name: "plantaciones_objetivo_plantacion_id_fk", dependent: :nullify
    add_foreign_key "plantaciones", "tipos_plantacion", name: "plantaciones_tipo_plantacion_id_fk", dependent: :nullify
    add_foreign_key "plantaciones", "titulares", name: "plantaciones_titular_id_fk", dependent: :nullify
    add_foreign_key "plantaciones", "usos_anteriores", name: "plantaciones_uso_anterior_id_fk", dependent: :nullify, column: "uso_anterior_id"
    add_foreign_key "plantaciones", "usos_forestales", name: "plantaciones_uso_forestal_id_fk", dependent: :nullify, column: "uso_forestal_id"
    add_foreign_key "plantaciones", "zonas", name: "plantaciones_zona_id_fk", dependent: :nullify
  end
end
