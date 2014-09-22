class UnificadosImporter
  def initialize(file)
    @file = file
    @zona = Zona.find_by_codigo(File.basename(@file)[0..1])
    @anio = Date.strptime(File.basename(@file)[2..3], "%y").year
    @estado = EstadoAprobacion.find_by_codigo(File.basename(@file)[6..7].upcase)
    @actividad = TipoActividad.find_by_codigo(File.basename(@file)[4..5].upcase)
    
    srs_database = RGeo::CoordSys::SRSDatabase::ActiveRecordTable.new
    factory = RGeo::Geos.factory(:srs_database => srs_database, :srid => @zona.srid)
    @shape = RGeo::Shapefile::Reader.open(file, factory: factory)

    @data = {
      zona: @zona.descripcion,
      anio: @anio,
      actividad: @actividad.descripcion,
      estado: @estado.descripcion,
      registros: @shape.num_records || 0
    }
  end

  def data
    @data
  end

  def import
    ActiveRecord::Base.transaction do
      begin
        @shape.each do |record|
          next if record.geometry.nil?
          record.geometry.each do |geom|
            Unificado.create!(
              zona: @zona.descripcion,
              anio: @anio,
              actividad: @actividad.descripcion,
              estado: @estado.descripcion,
              numero_interno: record[:N_INTERNO],
              anio_plantacion: record[:ANO_PLANT] || @anio,
              tipo_plantacion: record[:TIPO] || 'Mz',
              codigo_titular: record[:COD_TIT],
              numero_productor: record[:N_PROD],
              titular: record[:TITULAR],
              especie: record[:SP],
              numero_plantas: record[:N_PLANTAS],
              superficie: record[:SUP_HA],
              inspector: record[:INSPECTOR],
              responsable: record[:RESP_SIG],
              observaciones: record[:OBSERV],
              geom: geom
            )
          end
        end
        return true
      rescue => e
        puts "\nSe ha encontrado un error en el archivo: #{@file}"
        puts e.message
        puts "Se ha salteado el archivo.\n"
        raise ActiveRecord::Rollback
      ensure
        @shape.close
      end
    end
  end
end
