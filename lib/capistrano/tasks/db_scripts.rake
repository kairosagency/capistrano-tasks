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
      execute "#{fetch(:db_scripts_path)}/sync_prod_db.sh -e #{fetch(:app_environment)} -P #{fetch(:remote_db_password)}"
    end
  end
end