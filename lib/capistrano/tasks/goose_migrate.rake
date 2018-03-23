module Capistrano
  class FileNotFound < StandardError
  end
end

namespace :goose_migration do
  desc "goose migration commands (Status/Up/Down) using config file"

  # You need ton initiate variables in your deploy
  # :db_config_file
  # :migration_bin_current_path

  set :local_db_config_file, -> { "#{current_path}#{fetch(:db_config_file)}" }
  set :local_migration_bin_current_path, -> { "#{current_path}#{fetch(:migration_bin_current_path)}" }

  task :status do
    on roles(:db) do
      execute "#{fetch(:local_migration_bin_current_path)} -f #{fetch(:local_db_config_file)} -a status"
    end
  end

  task :up do
    on roles(:db) do
      execute "#{fetch(:local_migration_bin_current_path)} -f #{fetch(:local_db_config_file)} -a up"
    end
  end

  # TODO: Need to add this functionality into the migrate.sh
  # task :upTo do
  #   set :version, ask("What version do you need to up?", nil)
  #   on roles(:db) do
  #     execute "#{fetch(:local_migration_bin_current_path)} -f #{fetch(:local_db_config_file)} -a up-to #{fetch(:version)}"
  #   end
  # end

  task :down do
    on roles(:db) do
      execute "#{fetch(:local_migration_bin_current_path)} -f #{fetch(:local_db_config_file)} -a down"
    end
  end

  # TODO: Need to add this functionality into the migrate.sh
  # task :down do
  #   set :version, ask("What version do you need to down?", nil)
  #   on roles(:db) do
  #     execute "#{fetch(:local_migration_bin_current_path)} -f #{fetch(:local_db_config_file)} down-to #{fetch(:version)}"
  #   end
  # end
end
