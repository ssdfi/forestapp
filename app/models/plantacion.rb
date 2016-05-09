class Plantacion < ActiveRecord::Base
  require 'geo_util'

  belongs_to :tipo_plantacion
  belongs_to :estado_plantacion
  belongs_to :fuente_informacion
  belongs_to :fuente_imagen
  belongs_to :base_geometrica
  belongs_to :provincia
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
    foreign_key: 'plantacion_anterior_id', association_foreign_key: 'plantacion_nueva_id', autosave: true
  has_and_belongs_to_many :plantaciones_anteriores, class_name: 'Plantacion', join_table: 'plantaciones_historico',
    foreign_key: 'plantacion_nueva_id', association_foreign_key: 'plantacion_anterior_id'
  has_many :validaciones

  validate :plantaciones_nuevas_cannot_contain_itself

  before_save :process_nuevas_plantaciones

  attr_reader :ids, :copiar_datos, :activar_nuevas

  ##
  # Busca las plantaciones que coincidan con los atributos definidos en el objeto Plantacion pasado como parámetro
  def self.search(plantacion)
    plantaciones = all
    if plantacion
      plantaciones = where(id: plantacion.ids.split("\r\n")) if plantacion.ids
      plantaciones = plantaciones.distinct
    end
    plantaciones.order(:id)
  end

  def ids=(value)
    @ids = value unless value.blank?
  end

  def copiar_datos=(value)
    @copiar_datos = value === "1" ? true : false
  end

  def activar_nuevas=(value)
    @activar_nuevas = value === "1" ? true : false
  end

  ##
  # Actualiza masivamente las plantaciones del parámetro ids
  def self.mass_update(params)
    params.delete_if {|k,v| v.blank?}
    params.delete "especie_ids" if params["especie_ids"].count == 1 and params["especie_ids"][0].empty?
    Plantacion.where(id: params[:ids].split("\r\n")).each do |plantacion|
      plantacion.update(params)
    end
  end

  ##
  # Devuelve el atributo geom con el SRID correspondiente
  def geom
    geoutil = GeoUtil.instance
    geoutil.cast(read_attribute(:geom), srid, false)
  end

  ##
  # Obtiene el SRID de la plantación
  #
  # Como el sistema de referencia no está definido a nivel de tabla, es necesario obtener el SRID individual de cada registro a través
  # de la función ST_SRID
  def srid
    @srid ||= Plantacion.where(id: id).pluck("ST_SRID(geom)").first
  end

  ##
  # Calcula las hectáreas de superfice de la plantación si es del tipo macizo
  def hectareas
    (geom.area / 10000).round 1 if read_attribute(:geom) and tipo_plantacion_id == 1
  end

  ##
  # Devuelve la plantación con algunos datos en formato GeoJSON
  def to_geojson
    geoutil = GeoUtil.instance
    geoutil.encode_json(to_feature)
  end

  ##
  # Convierte la plantación en un objeto compatible con GeoJSON
  def to_feature
    geoutil = GeoUtil.instance
    geoutil.feature_to_geojson(
      to_wgs84,
      id,
      {
        "ID" => id,
        "Titular" => titular ? titular.nombre : '',
        "Especie" => especies.first ? especies.first.nombre_cientifico : '',
        "Superficie" => hectareas || ''
      }
    )
  end

  ##
  # Devuelve la plantación transformada en WGS84 Lat/Lng
  def to_wgs84
    geoutil = GeoUtil.instance
    sql = "SELECT ST_AsText(ST_Transform(geom, 4326)) geom FROM plantaciones where id = #{self.id};"
    cursor = Plantacion.connection.execute(sql)
    geoutil.factory(4326).parse_wkt(cursor.first["geom"])
  end

  ##
  # Devuelve la geometría de la plantación en formato GeoJSON usando PostGIS directamente
  def as_geojson
    sql = "SELECT ST_AsGeoJson(ST_Transform(geom, 4326)) geojson FROM plantaciones where id = #{self.id};"
    cursor = Plantacion.connection.execute(sql)
    cursor.first["geojson"]
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

  private

    ### Validar que la plantación no sea reemplazada por sí misma
    def plantaciones_nuevas_cannot_contain_itself
      if plantaciones_nuevas.include? self
        errors.add(:plantacion_nuevas_ids, 'La plantación no puede se reemplazada por sí misma')
      end
    end

    ##
    # Copiar datos a las nuevas plantaciones en caso que corresponda
    # Desactivar la plantación si fue reemplazada
    # Activar nuevas plantaciones según corresponda
    def process_nuevas_plantaciones
      self.activo = false if plantaciones_nuevas.count > 0
      plantaciones_nuevas.each do |nueva_plantacion|
        nueva_plantacion.activo = activar_nuevas
        if copiar_datos
          nueva_plantacion.titular = titular
          nueva_plantacion.especies = especies
          nueva_plantacion.anio_plantacion = anio_plantacion
          nueva_plantacion.tipo_plantacion = tipo_plantacion
          nueva_plantacion.nomenclatura_catastral = nomenclatura_catastral
          nueva_plantacion.provincia = provincia
          nueva_plantacion.departamento = departamento
          nueva_plantacion.estrato_desarrollo = estrato_desarrollo
          nueva_plantacion.uso_forestal = uso_forestal
          nueva_plantacion.uso_anterior = uso_anterior
          nueva_plantacion.objetivo_plantacion = objetivo_plantacion
        end
      end
    end
end
