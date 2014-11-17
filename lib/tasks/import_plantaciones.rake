require 'plantaciones_importer'

namespace :db do
  namespace :import do
    desc "Importar Plantaciones desde archivos Shape"
    task plantaciones: :environment do
      total = 0
      dir = Rails.application.config.path_plantaciones + '/*.shp'
      Dir[dir].each do |file|
        # next unless File.basename(file) == 'mpf_cata.shp'
        importer = PlantacionesImporter.new file
        if importer.import
          total += importer.data[:registros] 
          puts "Registros importados de #{File.basename(file)}: #{importer.data[:registros]}"
        end
      end
      puts "\n######################################################################################"
      puts "TOTAL DE PLANTACIONES IMPORTADAS: #{total}"
      puts "######################################################################################"
    end
  end
end