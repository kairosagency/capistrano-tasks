module Capistrano
  class FileNotFound < StandardError
  end
end

namespace :phpmigration do
  desc "php migration commands (List/Status/Migrate/Rollback/Up/Down)"

  task :list do
    run_locally do
      execute "#{fetch(:current_path)}vendor/bin/phpmig list"
    end
  end

  task :status do
    run_locally do
      execute "#{fetch(:current_path)}vendor/bin/phpmig status -b #{fetch(:current_path)}phpmig-#{fetch(:app_environment)}.php"
    end
  end

  task :migrate do
    run_locally do
      execute "#{fetch(:current_path)}vendor/bin/phpmig migrate -b #{fetch(:current_path)}phpmig-#{fetch(:app_environment)}.php"
    end
  end

  task :rollback do
    run_locally do
      execute "#{fetch(:current_path)}vendor/bin/phpmig roolback -b #{fetch(:current_path)}phpmig-#{fetch(:app_environment)}.php"
    end
  end

  task :up do
    run_locally do
      execute "#{fetch(:current_path)}vendor/bin/phpmig up -b #{fetch(:current_path)}phpmig-#{fetch(:app_environment)}.php"
    end
  end

  task :down do
    run_locally do
      execute "#{fetch(:current_path)}vendor/bin/phpmig down -b #{fetch(:current_path)}phpmig-#{fetch(:app_environment)}.php"
    end
  end
end
