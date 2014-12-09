require 'unificados_importer'

namespace :db do
  namespace :import do
    desc "Importar Unificados desde archivos Shape"
    task unificados: :environment do
      puts "\n######################################################################################"
      puts "IMPORTANDO UNIFICADOS..."
      puts "######################################################################################"

      dirs = Rails.application.config.path_unificados + '/**'

      subtotal = 0
      total = 0

      Dir[dirs].each do |dir|
        Dir[dir + '/*.shp'].each do |file|
          next if File.basename(file)[4..5] == 'pr'
          importer = UnificadosImporter.new(file)
          if importer.import
            subtotal += importer.data[:registros]
          end
        end
        puts "Unificados importados de #{File.basename(dir)}: #{subtotal}"
        total += subtotal
        subtotal = 0
        break
      end

      puts "######################################################################################"
      puts "TOTAL DE UNIFICADOS IMPORTADOS: #{total}"
      puts "######################################################################################"
    end
  end
end