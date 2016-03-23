namespace :db do
  namespace :import do
    desc "Migrar Pagos"
    task migrate_pagos: :environment do

      start_time = Time.now
      puts "\n######################################################################################"
      puts "MIGRANDO PAGOS... (#{start_time})"
      puts "######################################################################################"

      count = 0
      TmpPago.find_each do |tmp_pago|

        # Buscar/Crear Expediente
        expediente = Expediente.find_by_numero_interno(tmp_pago.numero_interno)
        unless expediente
          zona = tmp_pago.zona.empty? ? Zona.find_by_descripcion(tmp_pago.provincia) : Zona.find_by_descripcion(tmp_pago.zona)
          expediente = Expediente.create!(
            numero_interno: tmp_pago.numero_interno,
            numero_expediente: tmp_pago.numero_expediente,
            zona: zona,
            activo: true
          )
        end

        # Buscar/Crear Movimiento
        if expediente.movimientos.count > 1
          movimiento = expediente.movimientos.find_by_etapa(tmp_pago.anio_plan)
        else
          movimiento = expediente.movimientos.first
        end
        movimiento = expediente.movimientos.create!(etapa: tmp_pago.anio_plan) unless movimiento

        # Buscar/Crear Actividad
        if tmp_pago.forestacion.to_f != 0
          tipo_actividad = TipoActividad.find(1)
        elsif  tmp_pago.poda.to_f != 0
          tipo_actividad = TipoActividad.find(2)
        elsif  tmp_pago.raleo.to_f != 0
          tipo_actividad = TipoActividad.find(3)
        elsif  tmp_pago.manejo.to_f != 0
          tipo_actividad = TipoActividad.find(4)
        elsif  tmp_pago.enriquecimiento.to_f != 0
          tipo_actividad = TipoActividad.find(5)
        end
        next unless tipo_actividad

        actividad = movimiento.actividades.find_by_tipo_actividad_id(tipo_actividad.id)
        next unless actividad

        # Buscar/Crear Titular
        if tmp_pago.anticipo === 't'
        if actividad.actividades_titulares.count > 0
          titular = Titular.find_by_nombre(tmp_pago.titular_corregido_1)
          next unless titular
          actividad_titular = actividad.actividades_titulares.find_by_titular_id(titular.id)
          next unless actividad_titular
        end

        count += 1
        puts "#{count} pagos migrados hasta el momento. (#{ChronicDuration.output(Time.now - start_time)})" if count % 1000 == 0
      end

      puts "#############################################################################################"
      puts "TOTAL DE PAGOS MIGRADOS: #{count} (#{ChronicDuration.output(Time.now - start_time)})"
      puts "#############################################################################################"
    end
  end
end
