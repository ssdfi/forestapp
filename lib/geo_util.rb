class GeoUtil
  include Singleton

  def initialize
    @factories = {}
    @srs_database = RGeo::CoordSys::SRSDatabase::ActiveRecordTable.new
  end

  def srs_database
    @srs_database
  end

  def factory(srid)
    @factories[srid] = RGeo::Geos.factory(:srs_database => @srs_database, :srid => srid) unless @factories[srid]
    @factories[srid]
  end

  def geojson_factory
    RGeo::GeoJSON::EntityFactory.instance
  end

  def cast(geometry, srid, project)
    RGeo::Feature.cast(geometry, :factory => factory(srid), :project => project)
  end

  def feature_to_geojson(feature, id, data)
    geojson_factory.feature(feature, id, data)
  end

  def encode_json(features)
    features = geojson_factory.feature_collection(features) if features.is_a?(Array)
    RGeo::GeoJSON.encode(features).to_json
  end

end