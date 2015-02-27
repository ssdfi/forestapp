namespace :db do
  namespace :import do
    desc "Migrar Titulares"
    task migrate_titulares: :environment do

      start_time = Time.now
      puts "\n######################################################################################"
      puts "MIGRANDO TITULARES... (#{start_time})"
      puts "######################################################################################"

      count = 0
      TmpTitular.select(:titular, :dni, :cuit).distinct.each do |tmp_titular|

        Titular.find_or_create(tmp_titular.titular, tmp_titular.dni, tmp_titular.cuit)

        count += 1
        puts "#{count} titulares migrados hasta el momento. (#{ChronicDuration.output(Time.now - start_time)})" if count % 5000 == 0
      end

      puts "#############################################################################################"
      puts "TOTAL DE TITULARES MIGRADOS: #{count} (#{ChronicDuration.output(Time.now - start_time)})"
      puts "#############################################################################################"
    end
  end
end