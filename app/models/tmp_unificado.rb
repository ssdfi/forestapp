class TmpUnificado < ActiveRecord::Base
  require 'geo_util'
  self.table_name = "tmp_unificados"

  def geom
    geoutil = GeoUtil.instance
    geoutil.cast(read_attribute(:geom), Zona.find_by_descripcion(zona).srid, false)
  end
end
