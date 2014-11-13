namespace :db do
  namespace :import do
    desc "Importar Titulares de Expedientes usando los Titulares Temporales"
    task titulares: :environment do
      Expediente.all.each do |expediente|
        tmp_titulares = TmpTitular.where(numero_interno: expediente.numero_interno)
        tmp_titulares = tmp_titulares.where(fuente: ['Entidad', 'Individual'])

        tmp_titulares.each do |tmp_titular|
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
          expediente.titulares << titular
        end
        expediente.save!
      end
    end
  end
end