class UnificadosImporter
  def initialize(file)
    @file = file
    @zona = Zona.find_by_codigo(File.basename(@file)[0..1])
    @anio = Date.strptime(File.basename(@file)[2..3], "%y").year.to_s
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
            u = Unificado.create!(
              zona: @zona.descripcion,
              anio: @anio,
              actividad: @actividad.descripcion,
              estado: @estado.descripcion,
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
            migrate(u)
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

  def migrate(unificado)
    especies = [
      Especie.find_by_codigo_sp(unificado.especie)
    ]
    plantacion = Plantacion.create!(
      anio_plantacion: unificado.anio_plantacion,
      tipo_plantacion: TipoPlantacion.find_by_codigo(unificado.tipo_plantacion),
      densidad: unificado.numero_plantas,
      zona: Zona.find_by_descripcion(unificado.zona),
      activo: true,
      comentarios: unificado.observaciones,
      unificado: unificado,
      geom: unificado.geom,
      especies: especies.compact
    )

    if unificado.numero_interno.index('/')
      numero_interno = unificado.numero_interno
      etapa = unificado.anio
    else
      numero_interno = "#{unificado.numero_interno}/#{unificado.anio.slice(-2,2)}"
    end

    expediente = Expediente.find_by_numero_interno(numero_interno)

    unless expediente
      expediente = Expediente.create!(
        numero_interno: numero_interno,
        plurianual: !etapa.nil?,
        activo: true
      )
    end

    if etapa
      movimiento = expediente.movimientos.where({etapa: etapa}).order(fecha_salida: :desc, fecha_entrada: :desc).first
    else
      movimiento = expediente.movimientos.order(fecha_salida: :desc, fecha_entrada: :desc).first
    end

    unless movimiento
      movimiento = expediente.movimientos.create!(
        etapa: etapa
      )
    end

    actividad = movimiento.actividades.where({tipo_actividad: @actividad}).last

    unless actividad
      actividad = movimiento.actividades.create!(
        tipo_actividad: @actividad
      )
    end

    unless actividad.nil?
      plantacion.actividades_plantaciones.create!(
        actividad: actividad,
        superficie: unificado.superficie,
        estado_aprobacion: @estado,
        comentarios: unificado.observaciones
      )
    end
  end
end
