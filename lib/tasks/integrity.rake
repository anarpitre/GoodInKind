namespace :ci do
  task :copy_yml do
    system("cp config/database.yml.ci config/database.yml")
  end

  task :spec do
    system("bundle exec rspec spec/")
  end

  desc "Prepare for CI and run entire test suite"
  task :build => ['ci:copy_yml', 'db:create', 'db:migrate', 'ci:spec'] do
  end
end

