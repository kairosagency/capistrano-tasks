module Capistrano
  class FileNotFound < StandardError
  end
end

namespace :db_scripts do
  desc "db sync migration commands (sync_db)"

  set :scripts_path, -> { "#{current_path}" }

  task :sync_db do
    on roles(:web) do
      execute "#{fetch(:scripts_path)}/db_scripts/sync_prod_db.sh -e #{fetch(:app_environment)} -P $REMOTE_DB_PASSWORD"
    end
  end
end
