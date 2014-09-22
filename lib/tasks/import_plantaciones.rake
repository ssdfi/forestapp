require 'importer_plantaciones'

namespace :db do
  namespace :import do
    desc "Importar Plantaciones desde archivos Shape"
    task plantaciones: :environment do
      total = 0
      dir = Rails.application.config.path_plantaciones
      Dir[dir + '/*.shp'].each do |file|
        # next unless File.basename(file) == 'mpf_cata.shp'
        importer = ImporterPlantaciones.new file
        if importer.import
          total += importer.data[:registros] 
          puts "Registros importados de #{File.basename(file)}: #{importer.data[:registros]}"
        end
      end
      puts "######################################################################################"
      puts "TOTAL DE REGISTROS IMPORTADOS: #{total}"
      puts "######################################################################################"
    end
  end
end