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

  def geom
    geoutil = GeoUtil.instance
    geoutil.cast(read_attribute(:geom), zona.srid, false)
  end

  def hectareas
    (geom.area / 10000).round 1 if tipo_plantacion_id == 1
  end

  def to_geojson
    geoutil = GeoUtil.instance
    geoutil.encode_json(to_feature)
  end

  def to_feature
    geoutil = GeoUtil.instance
    geoutil.feature_to_geojson(
      geoutil.cast(geom, '4326', true),
      id,
      {
        "ID" => id,
        "Titular" => titular ? titular.nombre : '',
        "Especie" => especies.first.nombre_comun,
        "Superficie Polígono" => hectareas
      }
    )
  end

  def self.plantaciones_to_geojson(plantaciones)
    geoutil = GeoUtil.instance
    features = []
    plantaciones.each do |plantacion|
      features << plantacion.to_feature
    end
    geoutil.encode_json(features)
  end

end