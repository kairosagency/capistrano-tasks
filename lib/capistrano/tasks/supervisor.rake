module Capistrano
  class FileNotFound < StandardError
  end
end

namespace :supervisor do
  desc "Restart supervisor process"
  task :restart do
    set :process, ask('What process do you want to restart ?')
    on roles(:web) do
      execute :sudo, "supervisorctl restart #{process}"
    end
  end
end
