# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150123162041) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "postgis"

  create_table "actividades", force: true do |t|
    t.integer  "movimiento_id"
    t.integer  "tipo_actividad_id"
    t.decimal  "superficie_presentada"
    t.decimal  "superficie_certificada"
    t.decimal  "superficie_inspeccionada"
    t.decimal  "superficie_registrada"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "actividades", ["movimiento_id"], :name => "index_actividades_on_movimiento_id"
  add_index "actividades", ["tipo_actividad_id"], :name => "index_actividades_on_tipo_actividad_id"

  create_table "actividades_expedientes", id: false, force: true do |t|
    t.integer "actividad_id",  null: false
    t.integer "expediente_id", null: false
  end

  create_table "actividades_plantaciones", force: true do |t|
    t.integer  "actividad_id"
    t.integer  "plantacion_id"
    t.decimal  "superficie_registrada"
    t.integer  "estado_aprobacion_id"
    t.text     "comentarios"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "fecha"
    t.integer  "numero_plantas"
  end

  add_index "actividades_plantaciones", ["actividad_id"], :name => "index_actividades_plantaciones_on_actividad_id"
  add_index "actividades_plantaciones", ["estado_aprobacion_id"], :name => "index_actividades_plantaciones_on_estado_aprobacion_id"
  add_index "actividades_plantaciones", ["plantacion_id"], :name => "index_actividades_plantaciones_on_plantacion_id"

  create_table "departamentos", force: true do |t|
    t.integer  "zona_id"
    t.string   "codigo"
    t.string   "descripcion"
    t.string   "codigo_indec"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "departamentos", ["codigo"], :name => "index_departamentos_on_codigo"
  add_index "departamentos", ["zona_id"], :name => "index_departamentos_on_zona_id"

  create_table "destinos", force: true do |t|
    t.string   "codigo"
    t.string   "descripcion"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "destinos", ["codigo"], :name => "index_destinos_on_codigo"

  create_table "errores", force: true do |t|
    t.string   "descripcion"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "especies", force: true do |t|
    t.integer  "genero_id"
    t.string   "codigo_sp"
    t.string   "codigo"
    t.string   "nombre_cientifico"
    t.string   "nombre_comun"
    t.string   "inscripcion_inase"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "especies", ["codigo"], :name => "index_especies_on_codigo"
  add_index "especies", ["codigo_sp"], :name => "index_especies_on_codigo_sp"
  add_index "especies", ["genero_id"], :name => "index_especies_on_genero_id"

  create_table "especies_plantaciones", id: false, force: true do |t|
    t.integer "plantacion_id", null: false
    t.integer "especie_id",    null: false
  end

  create_table "estados_aprobacion", force: true do |t|
    t.string   "codigo"
    t.string   "descripcion"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "estados_aprobacion", ["codigo"], :name => "index_estados_aprobacion_on_codigo"

  create_table "estados_plantacion", force: true do |t|
    t.string   "codigo"
    t.string   "descripcion"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "estratos_desarrollo", force: true do |t|
    t.string   "codigo"
    t.string   "descripcion"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "estratos_desarrollo", ["codigo"], :name => "index_estratos_desarrollo_on_codigo"

  create_table "expedientes", force: true do |t|
    t.string   "numero_interno"
    t.string   "numero_expediente"
    t.string   "titular"
    t.boolean  "agrupado"
    t.boolean  "plurianual"
    t.boolean  "activo"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "zona_id"
    t.integer  "departamento_id"
    t.integer  "tecnico_id"
    t.integer  "anio"
  end

  add_index "expedientes", ["departamento_id"], :name => "index_expedientes_on_departamento_id"
  add_index "expedientes", ["numero_expediente"], :name => "index_expedientes_on_numero_expediente"
  add_index "expedientes", ["numero_interno"], :name => "index_expedientes_on_numero_interno"
  add_index "expedientes", ["tecnico_id"], :name => "index_expedientes_on_tecnico_id"
  add_index "expedientes", ["zona_id"], :name => "index_expedientes_on_zona_id"

  create_table "expedientes_titulares", id: false, force: true do |t|
    t.integer "expediente_id", null: false
    t.integer "titular_id",    null: false
  end

  create_table "fuentes_imagen", force: true do |t|
    t.string   "codigo"
    t.string   "descripcion"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "fuentes_imagen", ["codigo"], :name => "index_fuentes_imagen_on_codigo"

  create_table "fuentes_informacion", force: true do |t|
    t.string   "codigo"
    t.string   "descripcion"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "fuentes_informacion", ["codigo"], :name => "index_fuentes_informacion_on_codigo"

  create_table "generos", force: true do |t|
    t.string   "codigo"
    t.string   "descripcion"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "generos", ["codigo"], :name => "index_generos_on_codigo"

  create_table "inspectores", force: true do |t|
    t.string   "codigo"
    t.string   "descripcion"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "inspectores", ["codigo"], :name => "index_inspectores_on_codigo"

  create_table "movimientos", force: true do |t|
    t.integer  "expediente_id"
    t.integer  "numero_ficha"
    t.integer  "inspector_id"
    t.integer  "reinspector_id"
    t.integer  "responsable_id"
    t.string   "anio_inspeccion"
    t.integer  "destino_id"
    t.date     "fecha_entrada"
    t.date     "fecha_salida"
    t.integer  "etapa"
    t.boolean  "estabilidad_fiscal"
    t.text     "observacion"
    t.text     "observacion_interna"
    t.boolean  "auditar"
    t.boolean  "validado"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "movimientos", ["destino_id"], :name => "index_movimientos_on_destino_id"
  add_index "movimientos", ["expediente_id"], :name => "index_movimientos_on_expediente_id"
  add_index "movimientos", ["inspector_id"], :name => "index_movimientos_on_inspector_id"
  add_index "movimientos", ["reinspector_id"], :name => "index_movimientos_on_reinspector_id"
  add_index "movimientos", ["responsable_id"], :name => "index_movimientos_on_responsable_id"

  create_table "objetivos_plantacion", force: true do |t|
    t.string   "codigo"
    t.string   "descripcion"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "objetivos_plantacion", ["codigo"], :name => "index_objetivos_plantacion_on_codigo"

  create_table "plantaciones", force: true do |t|
    t.integer  "titular_id"
    t.string   "anio_plantacion"
    t.integer  "tipo_plantacion_id"
    t.string   "nomenclatura_catastral"
    t.integer  "estado_plantacion_id"
    t.decimal  "distancia_plantas"
    t.integer  "cantidad_filas"
    t.decimal  "distancia_filas"
    t.string   "densidad"
    t.integer  "fuente_informacion_id"
    t.integer  "fecha_informacion"
    t.integer  "fuente_imagen_id"
    t.integer  "fecha_imagen"
    t.integer  "zona_id"
    t.integer  "departamento_id"
    t.integer  "estrato_desarrollo_id"
    t.integer  "uso_forestal_id"
    t.integer  "uso_anterior_id"
    t.integer  "objetivo_plantacion_id"
    t.boolean  "activo"
    t.integer  "error_id"
    t.text     "comentarios"
    t.integer  "mpf_id"
    t.integer  "unificado_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.spatial  "geom",                   limit: {:srid=>0, :type=>"geometry"}
  end

  add_index "plantaciones", ["departamento_id"], :name => "index_plantaciones_on_departamento_id"
  add_index "plantaciones", ["error_id"], :name => "index_plantaciones_on_error_id"
  add_index "plantaciones", ["estado_plantacion_id"], :name => "index_plantaciones_on_estado_plantacion_id"
  add_index "plantaciones", ["estrato_desarrollo_id"], :name => "index_plantaciones_on_estrato_desarrollo_id"
  add_index "plantaciones", ["fuente_imagen_id"], :name => "index_plantaciones_on_fuente_imagen_id"
  add_index "plantaciones", ["fuente_informacion_id"], :name => "index_plantaciones_on_fuente_informacion_id"
  add_index "plantaciones", ["objetivo_plantacion_id"], :name => "index_plantaciones_on_objetivo_plantacion_id"
  add_index "plantaciones", ["tipo_plantacion_id"], :name => "index_plantaciones_on_tipo_plantacion_id"
  add_index "plantaciones", ["titular_id"], :name => "index_plantaciones_on_titular_id"
  add_index "plantaciones", ["uso_anterior_id"], :name => "index_plantaciones_on_uso_anterior_id"
  add_index "plantaciones", ["uso_forestal_id"], :name => "index_plantaciones_on_uso_forestal_id"
  add_index "plantaciones", ["zona_id"], :name => "index_plantaciones_on_zona_id"

  create_table "plantaciones_historico", id: false, force: true do |t|
    t.integer "plantacion_nueva_id"
    t.integer "plantacion_anterior_id"
  end

  add_index "plantaciones_historico", ["plantacion_anterior_id"], :name => "index_plantaciones_historico_on_plantacion_anterior_id"
  add_index "plantaciones_historico", ["plantacion_nueva_id"], :name => "index_plantaciones_historico_on_plantacion_nueva_id"

  create_table "responsables", force: true do |t|
    t.string   "codigo"
    t.string   "iniciales"
    t.string   "nombre"
    t.boolean  "activo"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tecnicos", force: true do |t|
    t.string   "nombre"
    t.boolean  "activo",     default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tecnicos", ["nombre"], :name => "index_tecnicos_on_nombre"

  create_table "tipos_actividad", force: true do |t|
    t.string   "codigo"
    t.string   "descripcion"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tipos_actividad", ["codigo"], :name => "index_tipos_actividad_on_codigo"

  create_table "tipos_plantacion", force: true do |t|
    t.string   "codigo"
    t.string   "descripcion"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tipos_plantacion", ["codigo"], :name => "index_tipos_plantacion_on_codigo"

  create_table "titulares", force: true do |t|
    t.string   "nombre"
    t.string   "dni"
    t.string   "cuit"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tmp_observaciones", force: true do |t|
    t.string "numero_interno"
    t.string "numero_productor"
    t.string "productor"
    t.string "presentado"
    t.string "certificado"
    t.string "inspeccionado"
    t.string "registrado"
    t.string "especie"
    t.string "actividad"
    t.string "tipo"
    t.text   "observaciones"
    t.string "nomenclatura_catastral"
    t.string "lote"
    t.string "otro"
  end

  add_index "tmp_observaciones", ["numero_interno"], :name => "index_tmp_observaciones_on_numero_interno"
  add_index "tmp_observaciones", ["numero_productor"], :name => "index_tmp_observaciones_on_numero_productor"
  add_index "tmp_observaciones", ["productor"], :name => "index_tmp_observaciones_on_productor"

  create_table "tmp_titulares", force: true do |t|
    t.string "numero_interno"
    t.string "numero_productor"
    t.string "titular"
    t.string "dni"
    t.string "cuit"
    t.string "fuente"
    t.string "titular_mayusculas"
  end

  add_index "tmp_titulares", ["cuit"], :name => "index_tmp_titulares_on_cuit"
  add_index "tmp_titulares", ["dni"], :name => "index_tmp_titulares_on_dni"
  add_index "tmp_titulares", ["numero_interno"], :name => "index_tmp_titulares_on_numero_interno"
  add_index "tmp_titulares", ["titular"], :name => "index_tmp_titulares_on_titular"
  add_index "tmp_titulares", ["titular_mayusculas"], :name => "index_tmp_titulares_on_titular_mayusculas"

  create_table "tmp_unificados", force: true do |t|
    t.string   "zona"
    t.string   "anio"
    t.string   "actividad"
    t.string   "estado"
    t.string   "numero_interno"
    t.string   "anio_plantacion"
    t.string   "tipo_plantacion"
    t.string   "codigo_titular"
    t.string   "numero_productor"
    t.string   "titular"
    t.string   "especie"
    t.integer  "numero_plantas"
    t.decimal  "superficie"
    t.string   "inspector"
    t.string   "responsable"
    t.text     "observaciones"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.spatial  "geom",             limit: {:srid=>0, :type=>"geometry"}
  end

  add_index "tmp_unificados", ["geom"], :name => "index_tmp_unificados_on_geom", :spatial => true

  create_table "usos_anteriores", force: true do |t|
    t.string   "codigo"
    t.string   "descripcion"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "usos_anteriores", ["codigo"], :name => "index_usos_anteriores_on_codigo"

  create_table "usos_forestales", force: true do |t|
    t.string   "codigo"
    t.string   "descripcion"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "usos_forestales", ["codigo"], :name => "index_usos_forestales_on_codigo"

  create_table "versions", force: true do |t|
    t.string   "item_type",  null: false
    t.integer  "item_id",    null: false
    t.string   "event",      null: false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], :name => "index_versions_on_item_type_and_item_id"

  create_table "zonas", force: true do |t|
    t.string   "codigo"
    t.string   "descripcion"
    t.integer  "srid"
    t.string   "provincia"
    t.string   "codigo_indec"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "zonas", ["codigo"], :name => "index_zonas_on_codigo"

  add_foreign_key "actividades", "movimientos", name: "actividades_movimiento_id_fk", dependent: :delete
  add_foreign_key "actividades", "tipos_actividad", name: "actividades_tipo_actividad_id_fk", dependent: :nullify

  add_foreign_key "actividades_plantaciones", "actividades", name: "actividades_plantaciones_actividad_id_fk", dependent: :delete
  add_foreign_key "actividades_plantaciones", "estados_aprobacion", name: "actividades_plantaciones_estado_aprobacion_id_fk", dependent: :nullify
  add_foreign_key "actividades_plantaciones", "plantaciones", name: "actividades_plantaciones_plantacion_id_fk", dependent: :delete

  add_foreign_key "departamentos", "zonas", name: "departamentos_zona_id_fk", dependent: :delete

  add_foreign_key "especies", "generos", name: "especies_genero_id_fk", dependent: :delete

  add_foreign_key "especies_plantaciones", "especies", name: "especies_plantaciones_especie_id_fk", dependent: :delete
  add_foreign_key "especies_plantaciones", "plantaciones", name: "especies_plantaciones_plantacion_id_fk", dependent: :delete

  add_foreign_key "expedientes", "departamentos", name: "expedientes_departamento_id_fk", dependent: :nullify
  add_foreign_key "expedientes", "tecnicos", name: "expedientes_tecnico_id_fk", dependent: :nullify
  add_foreign_key "expedientes", "zonas", name: "expedientes_zona_id_fk", dependent: :nullify

  add_foreign_key "expedientes_titulares", "expedientes", name: "expedientes_titulares_expediente_id_fk", dependent: :delete
  add_foreign_key "expedientes_titulares", "titulares", name: "expedientes_titulares_titular_id_fk", dependent: :delete

  add_foreign_key "movimientos", "destinos", name: "movimientos_destino_id_fk", dependent: :nullify
  add_foreign_key "movimientos", "expedientes", name: "movimientos_expediente_id_fk", dependent: :delete
  add_foreign_key "movimientos", "inspectores", name: "movimientos_inspector_id_fk", dependent: :nullify
  add_foreign_key "movimientos", "inspectores", name: "movimientos_reinspector_id_fk", column: "reinspector_id", dependent: :nullify
  add_foreign_key "movimientos", "responsables", name: "movimientos_responsable_id_fk", column: "responsable_id", dependent: :nullify

  add_foreign_key "plantaciones", "departamentos", name: "plantaciones_departamento_id_fk", dependent: :nullify
  add_foreign_key "plantaciones", "errores", name: "plantaciones_error_id_fk", dependent: :nullify
  add_foreign_key "plantaciones", "estados_plantacion", name: "plantaciones_estado_plantacion_id_fk", dependent: :nullify
  add_foreign_key "plantaciones", "estratos_desarrollo", name: "plantaciones_estrato_desarrollo_id_fk", dependent: :nullify
  add_foreign_key "plantaciones", "fuentes_imagen", name: "plantaciones_fuente_imagen_id_fk", dependent: :nullify
  add_foreign_key "plantaciones", "fuentes_informacion", name: "plantaciones_fuente_informacion_id_fk", dependent: :nullify
  add_foreign_key "plantaciones", "objetivos_plantacion", name: "plantaciones_objetivo_plantacion_id_fk", dependent: :nullify
  add_foreign_key "plantaciones", "tipos_plantacion", name: "plantaciones_tipo_plantacion_id_fk", dependent: :nullify
  add_foreign_key "plantaciones", "titulares", name: "plantaciones_titular_id_fk", dependent: :nullify
  add_foreign_key "plantaciones", "usos_anteriores", name: "plantaciones_uso_anterior_id_fk", column: "uso_anterior_id", dependent: :nullify
  add_foreign_key "plantaciones", "usos_forestales", name: "plantaciones_uso_forestal_id_fk", column: "uso_forestal_id", dependent: :nullify
  add_foreign_key "plantaciones", "zonas", name: "plantaciones_zona_id_fk", dependent: :nullify

  add_foreign_key "plantaciones_historico", "plantaciones", name: "plantaciones_historico_plantacion_anterior_id_fk", column: "plantacion_anterior_id", dependent: :delete
  add_foreign_key "plantaciones_historico", "plantaciones", name: "plantaciones_historico_plantacion_nueva_id_fk", column: "plantacion_nueva_id", dependent: :delete

end
