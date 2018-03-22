module Capistrano
    class FileNotFound < StandardError
    end
  end
  
  namespace :goose_migration do
    desc "goose migration commands (Status/Up/Down) using config file"

    # You need ton initiate variables in your deploy
    # :db_config_file
    # :migration_bin_current_path

    set :local_db_migrations_path, -> { "#{current_path}#{fetch(:db_migrations_path)}" }
    set :local_goose_bin_path, -> { "#{current_path}#{fetch(:goose_bin_path)}" }

    task :status do
      set :user, ask("Specify the user?", nil)
      set :dbname, ask("Specify the dbname?", nil)
      set :password, ask("Specify the password?", nil)
      set :host, ask("Specify the host?", "127.0.0.1")
      set :port, ask("Specify the port?", "5432")
      set :sslmode, ask("Specify the sslmode?", "disable")

      on roles(:db) do
        execute "#{fetch(:local_goose_bin_path)} -dir #{fetch(:local_db_migrations_path)} postgres \"dbname=#{fetch(:dbname)} user=#{fetch(:user)} password=#{fetch(:password)} host=#{fetch(:host)} port=#{fetch(:port)} sslmode=#{fetch(:sslmode)}\" status"
      end
    end
  
    # task :up do
    #   on roles(:db) do
    #     execute "#{fetch(:local_migration_bin_current_path)} -f #{fetch(:local_db_config_file)} -a up"
    #   end
    # end

    # TODO: Need to add this functionality into the migrate.sh
    # task :upTo do
    #   set :version, ask("What version do you need to up?", nil)
    #   on roles(:db) do
    #     execute "#{fetch(:local_migration_bin_current_path)} -f #{fetch(:local_db_config_file)} -a up-to #{fetch(:version)}"
    #   end
    # end
  
    # task :down do
    #   on roles(:db) do
    #     execute "#{fetch(:local_migration_bin_current_path)} -f #{fetch(:local_db_config_file)} -a down"
    #   end
    # end

    # TODO: Need to add this functionality into the migrate.sh
    # task :down do
    #   set :version, ask("What version do you need to down?", nil)
    #   on roles(:db) do
    #     execute "#{fetch(:local_migration_bin_current_path)} -f #{fetch(:local_db_config_file)} down-to #{fetch(:version)}"
    #   end
    # end
  end
  