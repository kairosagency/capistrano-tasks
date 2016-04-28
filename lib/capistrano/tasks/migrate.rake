module Capistrano
  class FileNotFound < StandardError
  end
end

namespace :phpmigration do
  desc "Supervisor commands (Start/Stop/Restart/Reread/Update)"

  task :status do
    set :process, ask('What process do you want to restart ?', nil)
    on roles(:web) do
      execute "vendor/bin/phpmig status -b phpmig-#{fetch(:app_environment)}.php"
    end
  end
end
