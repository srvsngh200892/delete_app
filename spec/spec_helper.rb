require 'rubygems'
require 'simplecov'


# require 'simplecov-rcov'
# SimpleCov.formatter = SimpleCov::Formatter::RcovFormatter
# SimpleCov.start 'rails'
#SimpleCov.start
# include ActionDispatch::TestProcess



SimpleCov.start 'rails' do
  add_group 'API Controllers' , 'app/controllers/api/v1'
  add_group "Serializers", "app/serializers"
  add_filter '/spec/'
  add_filter '/db/'
  add_filter '/vendor/'
  add_filter '/config/'

  add_group "Domain", "app/domain"
  add_group "Models", "app/models"
  add_group "Services", "app/services"
  add_group "Lib", 'lib'
end
# This file is copied to spec/ when you run 'rails generate rspec:install'

# Use guard with guard init rspec
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'shoulda/matchers'
require 'factory_girl'

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    # Choose a test framework:
    with.test_framework :rspec


    # Choose one or more libraries:

    with.library :rails

    # Or, choose the following (which implies all of the above):

  end
end

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

# Checks for pending migrations before tests are run.
# If you are not using ActiveRecord, you can remove this line.
ActiveRecord::Migration.check_pending! if defined?(ActiveRecord::Migration)

RSpec.configure do |config|
  #config.include Capybara::DSL

  # config.filter_run :focus => true
  # ## Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  # config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = false

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = false

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = "default"
  config.include FactoryGirl::Syntax::Methods

  config.include RequestHelper

  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.before(:suite) do
     DatabaseCleaner.clean_with(:truncation)
     DatabaseCleaner.strategy = :transaction
  end

  config.after(:suite) do
     DatabaseCleaner.clean_with(:truncation)
  end

  factory_girl_results = {}
  config.before(:suite) do
    ActiveSupport::Notifications.subscribe("factory_girl.run_factory") do |name, start, finish, id, payload|
      factory_name = payload[:name]
      strategy_name = payload[:strategy]
      factory_girl_results[factory_name] ||= {}
      factory_girl_results[factory_name][strategy_name] ||= 0
      factory_girl_results[factory_name][strategy_name] += 1
    end
  end

  config.after(:suite) do
    puts "\n----------END of Rspec Suite----------"
    puts "Number of Factories Created"
    puts factory_girl_results
  end



  config.include RequestHelper
end
