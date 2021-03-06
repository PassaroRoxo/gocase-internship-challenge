namespace :dev do
  desc "Setup dev environment"
  task setup: :environment do
    if Rails.env.development?
      showSpinner("Run bundle...") { %x(bundle install) }
      showSpinner("Create DB...") { %x(rails db:create) }
      showSpinner("Migrate database...") { %x(rails db:migrate) }
      showSpinner("Load database...") { %x(rails db:seed) }
    else
      puts "Environment isnt development"
    end
  end

  desc "ReSetup dev environment"
  task resetup: :environment do
    if Rails.env.development?
      showSpinner("Drop DB...") { %x(rails db:drop) }
      showSpinner("Create DB...") { %x(rails db:create) }
      showSpinner("Migrate database...") { %x(rails db:migrate) }
      showSpinner("Load database...") { %x(rails db:seed) }
    else
      puts "Environment isnt development"
    end
  end

  desc "Run Tests"
  task tests: :environment do
    if Rails.env.development?
      puts %x(bundle exec rspec spec/requests/orders_spec.rb spec/requests/batches_spec.rb)
    else
      puts "Environment isnt development"
    end
  end

  private
  def showSpinner(msgStart, msgEnd = "Complet!")
    spinner = TTY::Spinner.new("[:spinner] #{msgStart}", format: :dots)
    spinner.auto_spin
    yield
    spinner.success("(#{msgEnd})")
  end
end
