module Capistrano
  class FileNotFound < StandardError
  end
end

namespace :supervisor do
  desc "Restart supervisor process"

  set :process, ask('What process do you want to restart ?', nil)

  task :start do
    on roles(:web) do
      execute :sudo, "supervisorctl start #{fetch(:process)}"
    end
  end

  task :stop do
    on roles(:web) do
      execute :sudo, "supervisorctl stop #{fetch(:process)}"
    end
  end

  task :restart do
    on roles(:web) do
      execute :sudo, "supervisorctl restart #{fetch(:process)}"
    end
  end
end
