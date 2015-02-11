namespace :db do
  namespace :import do
    desc "Migrar Unificados a Plantaciones y Actividades"
    task migrate_unificados: :environment do

      puts "\n######################################################################################"
      puts "MIGRANDO UNIFICADOS..."
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

        unless actividad.nil?
          actividad_plantacion = plantacion.actividades_plantaciones.create!(
            actividad: actividad,
            superficie_registrada: unificado.superficie,
            estado_aprobacion: estado_aprobacion,
            comentarios: unificado.observaciones
          )
        end

        # Si es un expediente agrupado, buscar valores para cada productor

        if actividad_plantacion and unificado.numero_productor != '0'
          observacion = TmpObservacion.where("numero_interno = ? and numero_productor = ? and actividad = ?", numero_interno, unificado.numero_productor, tipo_actividad.codigo).first
          unless observacion.nil?
            actividad_plantacion.superficie_presentada = observacion.presentado
            actividad_plantacion.superficie_certificada = observacion.certificado
            actividad_plantacion.superficie_inspeccionada = observacion.inspeccionado
            actividad_plantacion.superficie_registrada = observacion.registrado
            actividad_plantacion.comentarios = observacion.observaciones
            actividad_plantacion.save!
          end
        end

        # Buscar/Crear titular

        tmp_titular = TmpTitular.where(numero_interno: expediente.numero_interno)
        tmp_titular = tmp_titular.where(numero_productor: unificado.numero_productor) if unificado.numero_productor != '0'
        tmp_titular = tmp_titular.first

        unless tmp_titular.nil?
          titular = Titular.find_by_dni(tmp_titular.dni) if tmp_titular.dni != '0'
          titular = Titular.find_by_cuit(tmp_titular.cuit) if titular.nil? and tmp_titular.cuit != '0'
          titular = Titular.find_by_nombre(tmp_titular.titular) if titular.nil?
          if titular.nil?
            titular = Titular.create!(
              nombre: tmp_titular.titular,
              dni: tmp_titular.dni != '0' ? tmp_titular.dni : nil,
              cuit: tmp_titular.cuit != '0' ? tmp_titular.cuit : nil
            )
          end
          plantacion.titular = titular
          plantacion.save!
        end

        count += 1
        puts "#{count} unificados migrados hasta el momento." if count % 10000 == 0
      end

      ActiveRecord::Base.execute(
        "UPDATE plantaciones
        SET geom = ST_SetSRID(geom, (
          SELECT ST_SRID(geom)
          FROM tmp_unificados
          WHERE id = plantaciones.unificado_id)
        ) WHERE unificado_id IS NOT NULL;"
      )

      puts "######################################################################################"
      puts "TOTAL DE UNIFICADOS MIGRADOS: #{count}"
      puts "######################################################################################"
    end
  end
end