class ExpedientesImporter
  def initialize
    @data = {
      expedientes: 0,
      movimientos: 0,
      actividades: 0
    }
    @start_time = Time.now
  end

  def import
    MsExpediente.find_each do |msexpediente|
      next if msexpediente.Borrado
      ActiveRecord::Base.transaction do
        begin
          import_expediente(msexpediente)
        rescue => e
          puts "\nSe ha encontrado un error en el expediente: #{msexpediente.inspect}"
          puts e.message
          puts "El registro no será importado."
          raise ActiveRecord::Rollback
          next
        end
      end
    end
  end

  def data
    @data
  end

  private

    def import_expediente(msexpediente)
      tecnico = Tecnico.find_by_nombre(msexpediente.Tecnico)
      if tecnico.nil? and !msexpediente.Tecnico.blank?
        tecnico = Tecnico.create(nombre: msexpediente.Tecnico)
      end

      expediente = Expediente.create!(
        numero_interno: msexpediente.numero_interno,
        numero_expediente: msexpediente.NumExpediente,
        tecnico: tecnico,
        plurianual: msexpediente.Plurianual,
        agrupado: msexpediente.Agrupado,
        activo: !msexpediente.Borrado
      )

      create_titulares(expediente, msexpediente)

      msexpediente.movimientos.each do |movimiento|
        next if movimiento.Eliminado
        import_movimiento(expediente, movimiento)
      end

      @data[:expedientes] += 1
      puts "#{@data[:expedientes]} expedientes importados hasta el momento. (#{ChronicDuration.output(Time.now - @start_time)})" if @data[:expedientes] % 1000 == 0
    end

    def create_titulares(expediente, msexpediente)
      tmp_titulares = TmpTitular.where(numero_interno: expediente.numero_interno)
      if tmp_titulares.count > 0
        tmp_titulares.each do |tmp_titular|
          expediente.titulares << Titular.find_or_create(tmp_titular.titular, tmp_titular.dni, tmp_titular.cuit)
        end
      else
        expediente.titulares << Titular.find_or_create(msexpediente.Titular, nil, nil)
      end
      expediente.save!
    end

    def import_movimiento(expediente, msmovimiento)
      movimiento = expediente.movimientos.create!(
        numero_ficha: msmovimiento.NumFicha,
        inspector: Inspector.find_by_codigo(msmovimiento.Id_Inspeccion.to_i.to_s),
        reinspector: Inspector.find_by_codigo(msmovimiento.Id_Reinspeccion.to_i.to_s),
        responsable: Responsable.find_by_codigo(msmovimiento.Id_Responsable.to_i.to_s),
        anio_inspeccion: msmovimiento.Ano_Inspeccion,
        destino: Destino.find_by_codigo(msmovimiento.Id_Destino.to_i.to_s),
        fecha_entrada: msmovimiento.Entrada,
        fecha_salida: msmovimiento.Salida,
        etapa: /^\d{4}$/.match(msmovimiento.Etapa) ? msmovimiento.Etapa.to_i : nil,
        observacion: msmovimiento.observacion,
        observacion_interna: msmovimiento.ObsInt,
        auditar: msmovimiento.Para_Auditar,
        estabilidad_fiscal: !msmovimiento.ObsInt.match(/^EF/).nil?
      )

      import_actividad(TipoActividad.find_by_codigo('PL'), movimiento, msmovimiento, 'Plan')
      import_actividad(TipoActividad.find_by_codigo('PO'), movimiento, msmovimiento, 'Poda')
      import_actividad(TipoActividad.find_by_codigo('RA'), movimiento, msmovimiento, 'Rale')
      import_actividad(TipoActividad.find_by_codigo('RE'), movimiento, msmovimiento, 'Rebr')
      import_actividad(TipoActividad.find_by_codigo('EB'), movimiento, msmovimiento, 'Ebna')
      @data[:movimientos] += 1
    end

    def import_actividad(tipo_actividad, movimiento, msmovimiento, sufijo)
      if msmovimiento["Pres_#{sufijo}"] > 0 or msmovimiento["Cert_#{sufijo}"] > 0 or msmovimiento["Insp_#{sufijo}"] > 0 or msmovimiento["Regi_#{sufijo}"] > 0
        actividad = movimiento.actividades.create!(
          tipo_actividad: tipo_actividad,
          superficie_presentada: msmovimiento["Pres_#{sufijo}"],
          superficie_certificada: msmovimiento["Cert_#{sufijo}"],
          superficie_inspeccionada: msmovimiento["Insp_#{sufijo}"],
          superficie_registrada: msmovimiento["Regi_#{sufijo}"]
        )
        @data[:actividades] += 1
      end
    end
end
