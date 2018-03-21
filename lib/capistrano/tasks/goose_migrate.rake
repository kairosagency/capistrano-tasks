module Capistrano
    class FileNotFound < StandardError
    end
  end
  
  namespace :goosemigration do
    desc "goose migration commands (Status/Up/Down) using config file"

    # You need ton initiate variables in your deploy
    # :db_config_file
    # :migrations_sql_path
    # :migration_bin_current_path

    set :local_db_config_file, -> { "#{current_path}#{fetch(:db_config_file)}" }
    set :local_migrations_sql_path, -> { "#{current_path}#{fetch(:migrations_sql_path)}" }
    set :local_migration_bin_current_path, -> { "#{current_path}#{fetch(:migration_bin_current_path)}" }

    task :status do
      on roles(:db) do
        execute "#{fetch(:local_migration_bin_current_path)} -dir #{fetch(:local_migrations_sql_path)} -f #{fetch(:local_db_config_file)} -a status"
      end
    end
  
    task :up do
      on roles(:db) do
        execute "#{fetch(:local_migration_bin_current_path)} -dir #{fetch(:local_migrations_sql_path)} -f #{fetch(:local_db_config_file)} -a up"
      end
    end

    task :upTo do
      set :version, ask("What version do you need to up?", nil)
      on roles(:db) do
        execute "#{fetch(:local_migration_bin_current_path)} -dir #{fetch(:local_migrations_sql_path)} -f #{fetch(:local_db_config_file)} -a up-to #{fetch(:version)}"
      end
    end
  
    task :down do
      on roles(:db) do
        execute "#{fetch(:local_migration_bin_current_path)} -dir #{fetch(:local_migrations_sql_path)} -f #{fetch(:local_db_config_file)} -a down"
      end
    end

    task :down do
      set :version, ask("What version do you need to down?", nil)
      on roles(:db) do
        execute "#{fetch(:local_migration_bin_current_path)} -dir #{fetch(:local_migrations_sql_path)} -f #{fetch(:local_db_config_file)} down-to #{fetch(:version)}"
      end
    end
  end
  