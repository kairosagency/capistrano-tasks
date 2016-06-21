module Capistrano
  class FileNotFound < StandardError
  end
end

namespace :phpmigration do
  desc "php migration commands (List/Status/Migrate/Rollback/Up/Down)"

  set :migration_current_path, -> { "#{current_path}" }

  task :list do
    on roles(:web) do
      execute "#{fetch(:migration_current_path)}vendor/bin/phpmig list"
    end
  end

  task :status do
    on roles(:app) do
      execute "#{fetch(:current_path)}vendor/bin/phpmig status -b #{fetch(:current_path)}phpmig-#{fetch(:app_environment)}.php"
    end
  end

  task :migrate do
    on roles(:web) do
      execute "#{fetch(:current_path)}vendor/bin/phpmig migrate -b #{fetch(:current_path)}phpmig-#{fetch(:app_environment)}.php"
    end
  end

  task :rollback do
    on roles(:web) do
      execute "#{fetch(:current_path)}vendor/bin/phpmig roolback -b #{fetch(:current_path)}phpmig-#{fetch(:app_environment)}.php"
    end
  end

  task :up do
    set :version, ask("What version do you need to up?", nil)
    on roles(:web) do
      execute "#{fetch(:current_path)}vendor/bin/phpmig up -b #{fetch(:current_path)}phpmig-#{fetch(:app_environment)}.php #{fetch(:version)}"
    end
  end

  task :down do
    set :version, ask("What version do you need to down?", nil)
    on roles(:web) do
      execute "#{fetch(:current_path)}vendor/bin/phpmig down -b #{fetch(:current_path)}phpmig-#{fetch(:app_environment)}.php #{fetch(:version)}"
    end
  end
end
