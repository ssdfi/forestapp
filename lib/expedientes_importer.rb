class ExpedientesImporter
  def initialize
    @data = {
      expedientes: 0,
      movimientos: 0,
      actividades: 0
    }
  end

  def import
    # MsExpediente.limit(10).each do |expediente|
    MsExpediente.all.each do |expediente|
      # next unless expediente.numero_interno == '04-024-037/05'
      ActiveRecord::Base.transaction do
        begin
          import_expediente(expediente)
        rescue => e
          puts "\nSe ha encontrado un error en el expediente: #{expediente.inspect}"
          puts e.message
          puts "Se ha salteado el registro."
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
      expediente = Expediente.create!(
        numero_interno: msexpediente.numero_interno,
        numero_expediente: msexpediente.NumExpediente,
        titular: msexpediente.Titular,
        tecnico: msexpediente.Tecnico,
        plurianual: msexpediente.Plurianual,
        agrupado: msexpediente.Agrupado,
        activo: !msexpediente.Borrado
      )
      msexpediente.movimientos.each do |movimiento|
        import_movimiento(expediente, movimiento)
      end
      @data[:expedientes] += 1
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
        etapa: msmovimiento.Etapa,
        observacion: msmovimiento.observacion,
        observacion_interna: msmovimiento.ObsInt,
        auditar: msmovimiento.Para_Auditar,
        validado: false,
        estabilidad_fiscal: !msmovimiento.observacion_interna.match(/^EF/).nil?
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
