namespace :db do
  namespace :dev do
    desc "USAGE: rake db:dev:init"
    task :init do
      puts "Reinitializing the development database"
      system("rake db:drop db:create db:migrate db:seed")
    end
  end

  namespace :test do
    desc "USAGE: rake db:test:init"
    task :init do
      puts "\n\nReinitializing the test database\n"
        system("RAILS_ENV=test rake db:drop db:create db:migrate")
        # system("RAILS_ENV=test rake parallel:drop parallel:create parallel:migrate")
    end
  end

  namespace :prod do
    desc "USAGE: rake db:prod:init"
    task :init do
      puts "\n\nReinitializing the production database\n"
        system("RAILS_ENV=production rake db:drop db:create db:migrate")
        # system("RAILS_ENV=test rake parallel:drop parallel:create parallel:migrate")
    end
  end
end