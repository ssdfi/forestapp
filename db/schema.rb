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

ActiveRecord::Schema.define(version: 20140920230834) do

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

  create_table "actividades_plantaciones", force: true do |t|
    t.integer  "actividad_id"
    t.integer  "plantacion_id"
    t.decimal  "superficie"
    t.integer  "estado_aprobacion_id"
    t.text     "comentarios"
    t.datetime "created_at"
    t.datetime "updated_at"
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
    t.string   "tecnico"
    t.boolean  "plurianual"
    t.boolean  "agregado"
    t.boolean  "activo"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "expedientes", ["numero_expediente"], :name => "index_expedientes_on_numero_expediente"
  add_index "expedientes", ["numero_interno"], :name => "index_expedientes_on_numero_interno"

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
    t.string   "etapa"
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
    t.string   "anio_plantacion"
    t.integer  "tipo_plantacion_id"
    t.string   "nomenclatura_catastral"
    t.integer  "estado_plantacion_id"
    t.decimal  "distancia_plantas"
    t.integer  "cantidad_filas"
    t.decimal  "distancia_filas"
    t.string   "densidad"
    t.integer  "fuente_informacion_id"
    t.date     "fecha_informacion"
    t.integer  "fuente_imagen_id"
    t.date     "fecha_imagen"
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
  add_index "plantaciones", ["uso_anterior_id"], :name => "index_plantaciones_on_uso_anterior_id"
  add_index "plantaciones", ["uso_forestal_id"], :name => "index_plantaciones_on_uso_forestal_id"
  add_index "plantaciones", ["zona_id"], :name => "index_plantaciones_on_zona_id"

  create_table "responsables", force: true do |t|
    t.string   "codigo"
    t.string   "iniciales"
    t.string   "nombre"
    t.boolean  "activo"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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

  create_table "unificados", force: true do |t|
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

  add_index "unificados", ["geom"], :name => "index_unificados_on_geom", :spatial => true

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

end
