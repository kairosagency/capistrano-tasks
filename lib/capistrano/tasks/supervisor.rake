module Capistrano
  class FileNotFound < StandardError
  end
end

namespace :supervisor do
  desc "Supervisor commands (Start/Stop/Restart/Reread/Update)"

  task :start do
    set :process, ask('What process do you want to restart ?', nil)
    on roles(:web) do
      execute :sudo, "supervisorctl start #{fetch(:process)}"
    end
  end

  task :stop do
    set :process, ask('What process do you want to restart ?', nil)
    on roles(:web) do
      execute :sudo, "supervisorctl stop #{fetch(:process)}"
    end
  end

  task :restart do
    set :process, ask('What process do you want to restart ?', nil)
    on roles(:web) do
      execute :sudo, "supervisorctl restart #{fetch(:process)}"
    end
  end

  task :update do
    on roles(:web) do
      execute :sudo, "supervisorctl update"
    end
  end

  task :reread do
    on roles(:web) do
      execute :sudo, "supervisorctl reread"
    end
  end
end
