class UnificadosImporter
  def initialize(file)
    @file = file
    @zona = Zona.find_by_codigo(File.basename(@file)[0..1])
    @anio = Date.strptime(File.basename(@file)[2..3], "%y").year.to_s
    @estado_aprobacion = EstadoAprobacion.find_by_codigo(File.basename(@file)[6..7].upcase)
    @tipo_actividad = TipoActividad.find_by_codigo(File.basename(@file)[4..5].upcase)

    srs_database = RGeo::CoordSys::SRSDatabase::ActiveRecordTable.new
    factory = RGeo::Geos.factory(:srs_database => srs_database, :srid => @zona.srid)
    @shape = RGeo::Shapefile::Reader.open(file, {factory: factory, assume_inner_follows_outer: true})

    @data = {
      zona: @zona.descripcion,
      anio: @anio,
      actividad: @tipo_actividad.descripcion,
      estado: @estado_aprobacion.descripcion,
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
            u = Unificado.create!(
              zona: @zona.descripcion,
              anio: @anio,
              actividad: @tipo_actividad.descripcion,
              estado: @estado_aprobacion.descripcion,
              numero_interno: record[:N_INTERNO],
              anio_plantacion: record[:ANO_PLANT] || @anio,
              tipo_plantacion: tipo_plantacion(record[:TIPO]),
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
        puts "El archivo no será importado.\n"
        raise ActiveRecord::Rollback
      ensure
        @shape.close
      end
    end
  end

  def tipo_plantacion(t)
    tipo = TipoPlantacion.find_by_codigo(t.to_s.upcase) if t
    tipo ? tipo.codigo : 'MZ'
  end
end
