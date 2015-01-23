class Plantacion < ActiveRecord::Base
  require 'geo_util'

  belongs_to :tipo_plantacion
  belongs_to :estado_plantacion
  belongs_to :fuente_informacion
  belongs_to :fuente_imagen
  belongs_to :zona
  belongs_to :departamento
  belongs_to :estrato_desarrollo
  belongs_to :uso_forestal
  belongs_to :uso_anterior
  belongs_to :objetivo_plantacion
  belongs_to :error
  belongs_to :titular
  has_and_belongs_to_many :especies
  has_many :actividades_plantaciones, class_name: 'ActividadPlantacion'
  has_many :actividades, through: :actividades_plantaciones
  has_many :movimientos, through: :actividades
  has_many :expedientes, through: :movimientos
  has_and_belongs_to_many :plantaciones_nuevas, class_name: 'Plantacion', join_table: 'plantaciones_historico',
    foreign_key: 'plantacion_anterior_id', association_foreign_key: 'plantacion_nueva_id'
  has_and_belongs_to_many :plantaciones_anteriores, class_name: 'Plantacion', join_table: 'plantaciones_historico',
    foreign_key: 'plantacion_nueva_id', association_foreign_key: 'plantacion_anterior_id'

  ##
  # Devuelve el atributo geom proyectado con el SRID correspondiente
  def geom
    geoutil = GeoUtil.instance
    puts srid
    geoutil.cast(read_attribute(:geom), srid, false)
  end

  ##
  # Obtiene el SRID de la plantación
  #
  # Como el sistema de referencia no está definido a nivel de tabla, es necesario obtener el SRID individual de cada registro a través
  # de la función ST_SRID
  def srid
    @srid ||= Plantacion.where(:id => id).pluck("ST_SRID(geom)").first
  end

  ##
  # Calcula las hectáreas de superfice de la plantación si es del tipo macizo
  def hectareas
    (geom.area / 10000).round 1 if tipo_plantacion_id == 1
  end

  ##
  # Devuelve la plantación en formato GeoJSON
  def to_geojson
    geoutil = GeoUtil.instance
    geoutil.encode_json(to_feature)
  end

  ##
  # Convierte la plantación en un objeto compatible con GeoJSON
  def to_feature
    geoutil = GeoUtil.instance
    geoutil.feature_to_geojson(
      geoutil.cast(geom, '4326', true),
      id,
      {
        "ID" => id,
        "Titular" => titular ? titular.nombre : '',
        "Especie" => especies.first ? especies.first.nombre_comun : '',
        "Superficie" => hectareas || ''
      }
    )
  end

  ##
  # Devuelve un GeoJSON con todas las plantaciones enviadas como parámetro
  def self.plantaciones_to_geojson(plantaciones)
    geoutil = GeoUtil.instance
    features = []
    plantaciones.each do |plantacion|
      features << plantacion.to_feature
    end
    geoutil.encode_json(features)
  end

end