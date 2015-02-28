namespace :db do
  namespace :import do
    desc "Importar todo: Plantaciones, Expedientes y Unificados"
    task all: :environment do
      start_time = Time.now
      puts start_time
      # Rake::Task["db:import:migrate_titulares"].invoke
      Rake::Task["db:import:expedientes"].invoke
      Rake::Task["db:import:unificados"].invoke
      Rake::Task["db:import:migrate_unificados"].invoke
      Rake::Task["db:import:migrate_observaciones"].invoke
      Rake::Task["db:import:plantaciones"].invoke
      puts ChronicDuration.output(Time.now - start_time)
    end
  end
end