module Capistrano
  class FileNotFound < StandardError
  end
end

namespace :phpmigration do
  desc "php migration commands (List/Status/Migrate/Rollback/Up/Down)"

  set :migration_current_path, -> { "#{current_path}" }

  task :list do
    on roles(:db) do
      execute "#{fetch(:migration_current_path)}/vendor/bin/phpmig list"
    end
  end

  task :status do
    on roles(:db) do
      execute "#{fetch(:migration_current_path)}/vendor/bin/phpmig status -b #{fetch(:migration_current_path)}/config/phpmig/#{fetch(:app_environment)}.php"
    end
  end

  task :migrate do
    on roles(:db) do
      execute "#{fetch(:migration_current_path)}/vendor/bin/phpmig migrate -b #{fetch(:migration_current_path)}/config/phpmig/#{fetch(:app_environment)}.php"
    end
  end

  task :rollback do
    on roles(:db) do
      execute "#{fetch(:migration_current_path)}/vendor/bin/phpmig roolback -b #{fetch(:migration_current_path)}/config/phpmig/#{fetch(:app_environment)}.php"
    end
  end

  task :up do
    set :version, ask("What version do you need to up?", nil)
    on roles(:db) do
      execute "#{fetch(:migration_current_path)}/vendor/bin/phpmig up -b #{fetch(:migration_current_path)}/config/phpmig/#{fetch(:app_environment)}.php #{fetch(:version)}"
    end
  end

  task :down do
    set :version, ask("What version do you need to down?", nil)
    on roles(:db) do
      execute "#{fetch(:migration_current_path)}/vendor/bin/phpmig down -b #{fetch(:migration_current_path)}/config/phpmig/#{fetch(:app_environment)}.php #{fetch(:version)}"
    end
  end
end

namespace :consul_migration do
  desc "migration commands using consul kv (List/Status/Migrate/Rollback/Up/Down)"

  set :migration_current_path, -> { "#{current_path}" }

  task :list do
    on roles(:db) do
      execute "#{fetch(:migration_current_path)}/vendor/bin/phpmig list"
    end
  end

  task :status do
    on roles(:db) do
      execute "#{fetch(:migration_current_path)}/vendor/bin/phpmig status -b #{fetch(:migration_current_path)}/config/phpmig/conf.php"
    end
  end

  task :migrate do
    on roles(:db) do
      execute "#{fetch(:migration_current_path)}/vendor/bin/phpmig migrate -b #{fetch(:migration_current_path)}/config/phpmig/conf.php"
    end
  end

  task :rollback do
    on roles(:db) do
      execute "#{fetch(:migration_current_path)}/vendor/bin/phpmig roolback -b #{fetch(:migration_current_path)}/config/phpmig/conf.php"
    end
  end

  task :up do
    set :version, ask("What version do you need to up?", nil)
    on roles(:db) do
      execute "#{fetch(:migration_current_path)}/vendor/bin/phpmig up -b #{fetch(:migration_current_path)}/config/phpmig/conf.php #{fetch(:version)}"
    end
  end

  task :down do
    set :version, ask("What version do you need to down?", nil)
    on roles(:db) do
      execute "#{fetch(:migration_current_path)}/vendor/bin/phpmig down -b #{fetch(:migration_current_path)}/config/phpmig/conf.php #{fetch(:version)}"
    end
  end
end
