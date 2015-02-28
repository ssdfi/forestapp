namespace :db do
  namespace :import do
    desc "Migrar Unificados a Plantaciones y Actividades"
    task migrate_unificados: :environment do
      start_time = Time.now
      puts "\n######################################################################################"
      puts "MIGRANDO UNIFICADOS... (#{start_time})"
      puts "######################################################################################"

      count = 0
      TmpUnificado.find_each do |unificado|

        tipo_actividad = TipoActividad.find_by_descripcion(unificado.actividad)
        estado_aprobacion = EstadoAprobacion.find_by_descripcion(unificado.estado)
        zona = Zona.find_by_descripcion(unificado.zona)

        # Crear plantación

        especies = [
          Especie.find_by_codigo_sp(unificado.especie)
        ]

        plantacion = Plantacion.create!(
          anio_plantacion: unificado.anio_plantacion,
          tipo_plantacion: TipoPlantacion.find_by_codigo(unificado.tipo_plantacion),
          densidad: unificado.numero_plantas,
          zona: zona,
          departamento: zona.departamentos.find_by_codigo(unificado.numero_interno[7..9]),
          activo: true,
          comentarios: unificado.observaciones,
          unificado_id: unificado.id,
          geom: unificado.geom,
          especies: especies.compact
        )

        # Buscar/Crear expediente

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
            zona: zona,
            plurianual: !etapa.nil?,
            activo: true
          )
        end

        # Buscar/Crear movimiento

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

        # Buscar/Crear actividad

        actividad = movimiento.actividades.where({tipo_actividad: tipo_actividad}).last

        unless actividad
          actividad = movimiento.actividades.create!(
            tipo_actividad: tipo_actividad
          )
        end

        actividad_plantacion = plantacion.actividades_plantaciones.create!(
          actividad: actividad,
          superficie_registrada: unificado.superficie,
          estado_aprobacion: estado_aprobacion,
          observaciones: unificado.observaciones
        )

        # Buscar/Crear titular

        tmp_titular = TmpTitular.where(numero_interno: expediente.numero_interno)
        if expediente.agrupado
          tmp_titular - tmp_titular.where(fuente: 'agrupados')
          tmp_titular = tmp_titular.where(numero_productor: unificado.numero_productor) if unificado.numero_productor != '0'
        end
        tmp_titular = tmp_titular.first

        titular = Titular.find_or_create(tmp_titular.titular, tmp_titular.dni, tmp_titular.cuit) if tmp_titular
        titular = Titular.find_or_create(unificado.titular, nil, nil) unless titular

        plantacion.titular = titular
        plantacion.save!

        count += 1
        puts "#{count} unificados migrados hasta el momento. (#{ChronicDuration.output(Time.now - start_time)})" if count % 10000 == 0
      end

      ActiveRecord::Base.connection.execute(
        "UPDATE plantaciones
        SET geom = ST_SetSRID(geom, (
          SELECT ST_SRID(geom)
          FROM tmp_unificados
          WHERE id = plantaciones.unificado_id)
        ) WHERE unificado_id IS NOT NULL;"
      )

      puts "################################################################################################"
      puts "TOTAL DE UNIFICADOS MIGRADOS: #{count} (#{ChronicDuration.output(Time.now - start_time)})"
      puts "################################################################################################"
    end
  end
end