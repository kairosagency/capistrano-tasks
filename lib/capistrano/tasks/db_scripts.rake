module Capistrano
  class FileNotFound < StandardError
  end
end

namespace :db_scripts do
  desc "db sync migration commands (sync_db)"
  set :scripts_path, -> { "#{current_path}" }
  
  task :sync_db do
    run_locally do
      remote_db_password = capture('echo $REMOTE_DB_PASSWORD')
      set :remote_db_password, -> { "#{remote_db_password}" }
    end

    on roles(:web) do
      execute "echo #{fetch(:remote_db_password)}"
      execute "#{fetch(:shell_current_path)}/db_scripts/sync_prod_db.sh -e #{fetch(:app_environment)} -P #{fetch(:remote_db_password)}"
    end
  end
end