module Capistrano
    class FileNotFound < StandardError
    end
  end
  
  namespace :goosemigration do
    desc "goose migration commands (Status/Up/Down) using config file"

    # You need ton initiate variables in your deploy
    # :migration_bin_current_path
    # :database_config_file

    task :status do
      on roles(:web) do
        execute "#{fetch(:migration_bin_current_path)} -f #{fetch(:database_config_file)} -a status"
      end
    end
  
    task :up do
      on roles(:web) do
        execute "#{fetch(:migration_bin_current_path)} -f #{fetch(:database_config_file)} -a up"
      end
    end

    task :upTo do
      set :version, ask("What version do you need to up?", nil)
      on roles(:web) do
        execute "#{fetch(:migration_bin_current_path)} -f #{fetch(:database_config_file)} -a up-to #{fetch(:version)}"
      end
    end
  
    task :down do
      on roles(:web) do
        execute "#{fetch(:migration_bin_current_path)} -f #{fetch(:database_config_file)} -a down"
      end
    end

    task :down do
      set :version, ask("What version do you need to down?", nil)
      on roles(:web) do
        execute "#{fetch(:migration_bin_current_path)} -f #{fetch(:database_config_file)} down-to #{fetch(:version)}"
      end
    end
  end
  