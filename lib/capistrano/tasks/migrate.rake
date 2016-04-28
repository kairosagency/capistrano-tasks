module Capistrano
  class FileNotFound < StandardError
  end
end

namespace :phpmigration do
  desc "Supervisor commands (Start/Stop/Restart/Reread/Update)"

  task :status do
    set :process, ask('What process do you want to restart ?', nil)
    on roles(:web) do
      execute "#{fetch(:current_path)}vendor/bin/phpmig status -b #{fetch(:current_path)}phpmig-#{fetch(:app_environment)}.php"
    end
  end
end
