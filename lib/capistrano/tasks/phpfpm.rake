module Capistrano
  class FileNotFound < StandardError
  end
end

namespace :phpfpm do
  desc "Restart php fpm"
  task :restart do
    on roles(:web) do
      execute :sudo, :service, "php5-fpm restart"
    end
  end
end
