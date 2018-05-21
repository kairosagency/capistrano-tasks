module Capistrano
  class FileNotFound < StandardError
  end
end

namespace :db_scripts do
  desc "db sync migration commands (sync_db)"
  set :db_scripts_path, -> { "#{current_path}/db_scripts" }
  
  task :sync_db do
    run_locally do
      # read db password env var
      set :remote_db_password, Capistrano::CLI.password_prompt('Enter database password: ')
    end

    on roles(:db) do
      as 'postgres' do
        # just checks the user for debug
        execute :whoami 
        # this ways it executes as postgres user
        execute :export, "PG_REMOTE_PASSWORD=\"$REMOTE_DB_PASSWORD\""
        if fetch(:phpmig_conf) != nil 
          execute :bash, "#{fetch(:db_scripts_path)}/sync_prod_db.sh -e #{fetch(:app_environment)} -c #{fetch(:phpmig_conf)}"
        else 
          execute :bash, "#{fetch(:db_scripts_path)}/sync_prod_db.sh -e #{fetch(:app_environment)}"
        end
      end
    end
  end
end