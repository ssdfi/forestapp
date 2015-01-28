# config valid only for Capistrano 3.1
lock '3.2.1'

set :application, 'forestapp'
set :repo_url, 'git@github.com:maurimiranda/forestapp.git'

set :rvm_type, :user
set :rvm_ruby_version, '2.1.2'

# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call
# ask :branch, proc { `git tag`.split("\n").last }

# Default deploy_to directory is /var/www/my_app
set :deploy_to, '/var/www/forestapp'

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
set :linked_files, %w{config/database.yml config/secrets.yml}

# Default value for linked_dirs is []
# set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

set :rails_env, "production"

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :publishing, :restart

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

  desc 'Initial DB Setup (Recreate DB and import data)'
  task :db_reset do
    on roles(:app), in: :sequence, wait: 5 do
      # execute :bunlde, :exec, :rake, 'db:reset'
      # execute :bunlde, :exec, :rake, 'db:import:all'
      execute :rake, 'db:version'
    end
  end

  desc 'Show deployed revision'
  task :revision do
    on roles(:app) do
      execute :cat, release_path.join('REVISION')
    end
  end

  desc 'Seed database'
  task :seed do
    on roles(:app) do
      execute :rake, 'db:seed'
    end
  end

end
