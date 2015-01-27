class TmpUnificado < ActiveRecord::Base
  require 'geo_util'
  self.table_name = "tmp_unificados"

  ##
  # Devuelve el atributo geom con el SRID correspondiente
  def geom
    geoutil = GeoUtil.instance
    geoutil.cast(read_attribute(:geom), srid, false)
  end

  ##
  # Obtiene el SRID del Unificado
  #
  # Como el sistema de referencia no está definido a nivel de tabla, es necesario obtener el SRID individual de cada registro a través
  # de la función ST_SRID
  def srid
    @srid ||= TmpUnificado.where(:id => id).pluck("ST_SRID(geom)").first
  end
end
