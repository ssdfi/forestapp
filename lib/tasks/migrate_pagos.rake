namespace :db do
  namespace :import do
    desc "Migrar Pagos"
    task migrate_pagos: :environment do

      start_time = Time.now
      puts "\n######################################################################################"
      puts "MIGRANDO PAGOS... (#{start_time})"
      puts "######################################################################################"

      record_count = 0
      pagos_count = 0
      anticipos_count = 0

      csv = CSV.open("/tmp/migrate_pagos_log.csv", "wb")
      csv << ['tmp_pago', 'expediente', 'movimiento', 'actividad']

      TmpPago.find_each do |tmp_pago|

        # Buscar/Crear Expediente
        expediente = Expediente.find_by_numero_interno(tmp_pago.numero_interno)
        unless expediente
          expediente = Expediente.new(
            numero_interno: tmp_pago.numero_interno,
            numero_expediente: tmp_pago.numero_expediente,
            zona: get_zona(tmp_pago),
            activo: true
          )
          expediente.titulares << get_titular(tmp_pago)
          expediente.save!(validate: false)
          csv << [tmp_pago.id, expediente.id]
        end

        if tmp_pago.anticipo === 'f'

          # Buscar/Crear Movimiento
          movimiento = expediente.movimientos.last
          unless movimiento
            movimiento = expediente.movimientos.new(
              etapa: tmp_pago.anio_plan
            )
            movimiento.save!(validate: false)
            csv << [tmp_pago.id, expediente.id, movimiento.id]
          end

          actividades = []

          # Buscar/Crear Actividad
          if tmp_pago.forestacion.to_f != 0
            actividades << { actividad: get_actividad(csv, tmp_pago, expediente, movimiento, 1), monto: tmp_pago.forestacion.to_f, superficie: tmp_pago.superficie_forestacion.to_f }
          elsif  tmp_pago.poda.to_f != 0
            actividades << { actividad: get_actividad(csv, tmp_pago, expediente, movimiento, 2), monto: tmp_pago.poda.to_f, superficie: tmp_pago.superficie_poda.to_f }
          elsif  tmp_pago.raleo.to_f != 0
            actividades << { actividad: get_actividad(csv, tmp_pago, expediente, movimiento, 3), monto: tmp_pago.raleo.to_f, superficie: tmp_pago.superficie_raleo.to_f }
          elsif  tmp_pago.manejo.to_f != 0
            actividades << { actividad: get_actividad(csv, tmp_pago, expediente, movimiento, 4), monto: tmp_pago.manejo.to_f, superficie: tmp_pago.superficie_manejo.to_f }
          elsif  tmp_pago.enriquecimiento.to_f != 0
            actividades << { actividad: get_actividad(csv, tmp_pago, expediente, movimiento, 5), monto: tmp_pago.enriquecimiento.to_f, superficie: tmp_pago.superficie_enriquecimiento.to_f }
          end

          if actividades.length == 0 and tmp_pago.monto_aprobado.to_f != 0
            actividades << { actividad: movimiento.actividades.first, monto: tmp_pago.monto_aprobado.to_f, superficie: nil }
          end

          actividades.each do |actividad|
            next if actividad[:actividad].nil?

            pago = Pago.create!(
              resolucion: tmp_pago.resolucion,
              fecha: parse_date(tmp_pago.fecha_resolucion),
              listado: tmp_pago.listado,
              actividad: actividad[:actividad],
              monto: actividad[:monto],
              superficie: actividad[:superficie]
            )

            if tmp_pago.tipo == 'Agrupado'
              pago.titulares.create!(
                actividad_titular: get_actividad_titular(tmp_pago, actividad[:actividad])
              )
            end

            pagos_count += 1
          end

        else

          Anticipo.create!(
            resolucion: tmp_pago.resolucion,
            fecha: parse_date(tmp_pago.fecha_resolucion),
            listado: tmp_pago.listado,
            expediente: expediente,
            monto: tmp_pago.monto_aprobado
          )
          anticipos_count += 1

        end

        record_count += 1
        puts "#{record_count} registros procesados hasta el momento: #{pagos_count} pagos, #{anticipos_count} anticipos. (#{ChronicDuration.output(Time.now - start_time)})" if record_count % 1000 == 0
      end

      csv.close

      puts "#############################################################################################"
      puts "TOTAL DE PAGOS MIGRADOS: #{pagos_count + anticipos_count} (#{ChronicDuration.output(Time.now - start_time)})"
      puts "#############################################################################################"
    end

    def get_actividad(csv, tmp_pago, expediente, movimiento, tipo_actividad_id)
      actividad = movimiento.actividades.find_by_tipo_actividad_id(tipo_actividad_id)
      unless actividad
        actividad = movimiento.actividades.create!(tipo_actividad_id: tipo_actividad_id)
        csv << [tmp_pago.id, expediente.id, movimiento.id, actividad.id]
      end
      return actividad
    end

    def get_titular(tmp_pago)
      titular = Titular.find_by_cuit(tmp_pago.cuit_1) unless tmp_pago.cuit_1 == '0'
      titular = Titular.find_by_dni(tmp_pago.dni_1) unless tmp_pago.dni_1 == '0'
      titular = Titular.where("nombre ILIKE ?", tmp_pago.titular_corregido_1.delete(',')).first unless titular
      unless titular
        titular = Titular.create!(
          nombre: tmp_pago.titular_corregido_1.delete(','),
          cuit: tmp_pago.cuit_1.length == 11 ? tmp_pago.cuit_1 : nil,
          dni: tmp_pago.dni_1.length == 8 ? tmp_pago.dni_1 : nil
        )
      end
      return titular
    end

    def get_actividad_titular(tmp_pago, actividad)
      return ActividadTitular.where(titular: get_titular(tmp_pago), actividad: actividad).first
    end

    def get_zona(tmp_pago)
      return tmp_pago.zona.nil? ? Zona.find_by_descripcion(tmp_pago.provincia) : Zona.find_by_descripcion(tmp_pago.zona)
    end

    def parse_date(value) # String: 17-dic-06
      return nil unless value
      month = case value[3..5]
        when 'ene' then '01'
        when 'feb' then '02'
        when 'mar' then '03'
        when 'abr' then '04'
        when 'may' then '05'
        when 'jun' then '06'
        when 'jul' then '07'
        when 'ago' then '08'
        when 'sep' then '09'
        when 'oct' then '10'
        when 'nov' then '11'
        when 'dic' then '12'
      end
      return Date.parse("#{value[7..8]}-#{month}-#{value[0..1]}")
    end
  end
end