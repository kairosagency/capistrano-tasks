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
      set :remote_db_password, ENV['REMOTE_DB_PASSWORD']
    end

    on roles(:db) do
      as 'postgres' do
        # just checks the user for debug
        execute :whoami 
        # this ways it executes as postgres user
        #{fetch(:remote_db_password)}
        if fetch(:phpmig_conf) != nil 
          execute "PG_REMOTE_PASSWORD=\"#{fetch(:remote_db_password)}\"", :bash, "#{fetch(:db_scripts_path)}/sync_prod_db.sh -e #{fetch(:app_environment)} -c #{fetch(:phpmig_conf)}"
        else 
          execute "PG_REMOTE_PASSWORD=\"#{fetch(:remote_db_password)}\"", :bash, "#{fetch(:db_scripts_path)}/sync_prod_db.sh -e #{fetch(:app_environment)}"
        end
      end
    end
  end
end