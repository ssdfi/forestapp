namespace :db do
  namespace :import do
    desc "Migrar Observaciones a ActividadesTitulares"
    task migrate_observaciones: :environment do

      start_time = Time.now
      puts "\n######################################################################################"
      puts "MIGRANDO OBSERVACIONES... (#{start_time})"
      puts "######################################################################################"

      count = 0
      TmpObservacion.find_each do |observacion|

        tipo_actividad = TipoActividad.find_by_codigo(observacion.actividad)
        especie = Especie.find_by_codigo_sp(observacion.especie)
        tipo_plantacion = TipoPlantacion.find_by_codigo(observacion.tipo)

        next unless tipo_actividad and especie and tipo_plantacion

        # Buscar expediente

        expediente = Expediente.find_by_numero_interno(observacion.numero_interno)
        unless expediente
          puts "#{observacion.numero_interno}: Expediente no encontrado"
          next
        end

        # Buscar movimiento

        movimiento = expediente.movimientos.order(fecha_salida: :desc, fecha_entrada: :desc).first
        unless movimiento
          puts "#{observacion.numero_interno}: Movimiento no encontrado"
          next
        end

        # Buscar actividad

        actividad = movimiento.actividades.where({tipo_actividad: tipo_actividad}).last
        unless actividad
          puts "#{observacion.numero_interno}: Actividad no encontrada (#{tipo_actividad.descripcion})"
          next
        end

        # Buscar titular

        tmp_titular = TmpTitular.where(numero_interno: observacion.numero_interno, numero_productor: observacion.numero_productor).first

        titular = Titular.find_or_create(tmp_titular.titular, tmp_titular.dni, tmp_titular.cuit) if tmp_titular
        titular = Titular.find_or_create(observacion.productor, observacion.dni, observacion.cuit) unless titular

        # Crear actividad_titular

        actividad.actividades_titulares.create!(
          titular: titular,
          especie: especie,
          tipo_plantacion: tipo_plantacion,
          superficie_presentada: (observacion.presentado.gsub(',','.') if observacion.presentado),
          superficie_certificada: (observacion.certificado.gsub(',','.') if observacion.certificado),
          superficie_inspeccionada: (observacion.inspeccionado.gsub(',','.') if observacion.inspeccionado),
          observaciones: observacion.observaciones
        )

        count += 1
        puts "#{count} observaciones migradas hasta el momento. (#{ChronicDuration.output(Time.now - start_time)})" if count % 1000 == 0
      end

      puts "#############################################################################################"
      puts "TOTAL DE OBSERVACIONES MIGRADAS: #{count} (#{ChronicDuration.output(Time.now - start_time)})"
      puts "#############################################################################################"
    end
  end
end