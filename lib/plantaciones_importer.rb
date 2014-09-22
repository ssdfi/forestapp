class PlantacionesImporter
  def initialize(file)
    @file = file
    shape = RGeo::Shapefile::Reader.open(@file)
    record = shape.next
    @zona = Zona.find_by_codigo_indec(record[:PROVINCIA])

    if record.geometry.geometry_type === ::RGeo::Feature::MultiLineString
      tipo = 'CT'
    else
      tipo = 'MZ'
    end
    @tipo = TipoPlantacion.find_by_codigo(tipo)

    srs_database = RGeo::CoordSys::SRSDatabase::ActiveRecordTable.new
    factory = RGeo::Geos.factory(:srs_database => srs_database, :srid => @zona.srid)
    @shape = RGeo::Shapefile::Reader.open(@file, factory: factory)

    @data = {
      zona: @zona.descripcion,
      tipo: @tipo.descripcion,
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
            especies = [
              Especie.find_by_codigo_sp(record[:SP_1]),
              Especie.find_by_codigo_sp(record[:SP_2]),
              Especie.find_by_codigo_sp(record[:SP_3])
            ]
            plantacion = Plantacion.create!(
              anio_plantacion: record[:ANO_PLANT],
              tipo_plantacion: @tipo,
              nomenclatura_catastral: nil,
              estado_plantacion: EstadoPlantacion.find_by_codigo(record[:ESTADO]),
              distancia_plantas: nil,
              cantidad_filas: nil,
              distancia_filas: nil,
              densidad: nil,
              fuente_informacion: FuenteInformacion.find_by_codigo(record[:FTE_INFO]),
              fecha_informacion: record[:FECHA_INFO],
              fuente_imagen: FuenteImagen.find_by_codigo(record[:IMAGEN_DIG]),
              fecha_imagen: record[:FECHA_IMG],
              zona: @zona,
              departamento: nil,
              estrato_desarrollo: EstratoDesarrollo.find_by_codigo(record[:EST_DESARR]),
              uso_forestal: UsoForestal.find_by_codigo(record[:USO_FOR]),
              uso_anterior: UsoAnterior.find_by_codigo(record[:USO_ANT]),
              objetivo_plantacion: ObjetivoPlantacion.find_by_codigo(record[:OBJ_PLANT]),
              activo: true,
              error_id: nil,
              comentarios: record[:OBSERV],
              mpf_id: record[:ID_MPF],
              geom: geom,
              especies: especies.compact
            )
          end
        end
        return true
      rescue => e
        puts "\nSe ha encontrado un error en el archivo: #{@file}"
        puts e.message
        puts "Se ha salteado el archivo."
        raise ActiveRecord::Rollback
      ensure
        @shape.close
      end
    end
  end
end
