namespace :react do
  desc "React compile and minify"
  task :build do
    run_locally do
      execute :npm, "run-script build"
    end
  end
end
