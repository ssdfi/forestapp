class Unificado < ActiveRecord::Base
  require 'geo_util'

  has_many :plantaciones

  def geom
    geoutil = GeoUtil.instance
    geoutil.cast(read_attribute(:geom), Zona.find_by_descripcion(zona).srid, false)
  end
end
