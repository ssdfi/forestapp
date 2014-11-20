require 'plantaciones_importer'

namespace :db do
  namespace :import do
    desc "Importar Plantaciones desde archivos Shape"
    task plantaciones: :environment do
      puts "\n######################################################################################"
      puts "IMPORTANDO PLANTACIONES..."
      puts "######################################################################################"
      total = 0
      dir = Rails.application.config.path_plantaciones + '/*.shp'
      Dir[dir].each do |file|
        importer = PlantacionesImporter.new file
        if importer.import
          total += importer.data[:registros] 
          puts "Plantaciones importadas de #{File.basename(file)}: #{importer.data[:registros]}"
        end
      end
      puts "######################################################################################"
      puts "TOTAL DE PLANTACIONES IMPORTADAS: #{total}"
      puts "######################################################################################"
    end
  end
end