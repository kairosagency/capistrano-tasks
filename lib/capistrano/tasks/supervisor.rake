module Capistrano
  class FileNotFound < StandardError
  end
end

namespace :supervisor do
  desc "Restart supervisor process"
  task :restart do

    set :process, ask('What process do you want to restart ?', nil)

    on roles(:web) do
      execute :sudo, "supervisorctl restart #{fetch(:process)}"
    end
  end
end
