module Capistrano
  class FileNotFound < StandardError
  end
end

namespace :phpfpm do
  desc "Restart php fpm"
  task :restart do
    on roles(:web) do
      unless fetch(:php_version)
        set :php_version, "5"
      end

      execute :sudo, :service, "php" + fetch(:php_version) + "-fpm restart"
    end
  end
end
