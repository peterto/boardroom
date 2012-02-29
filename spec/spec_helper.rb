require 'rubygems'
require 'spork'

module MySpecHelper
def login_user
  @request.env["devise.mapping"]   = Devise.mappings[:user]
   user = Fabricate(:admin)
   sign_in user
 end
end
include MySpecHelper
#uncomment the following line to use spork with the debugger
#require 'spork/ext/ruby-debug'

Spork.prefork do
  ENV["RAILS_ENV"] ||= 'test'
  require File.expand_path("../../config/environment", __FILE__)
  require 'rspec/rails'
  require 'rspec/autorun'
  require 'capybara/rspec'
  # require 'capybara/firebug'
  require 'database_cleaner'

  # Requires supporting ruby files with custom matchers and macros, etc,
  # in spec/support/ and its subdirectories.
  Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

  RSpec.configure do |config|

    # ## Mock Framework
    #
    # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
    #
    # config.mock_with :mocha
    # config.mock_with :flexmock
    # config.mock_with :rr

    # If you're not using ActiveRecord, or you'd prefer not to run each of your
    # examples within a transaction, remove the following line or assign false
    # instead of true.
    config.use_transactional_fixtures = false

    #Devise helpers
    config.include Devise::TestHelpers, :type => :controller
    
    # If true, the base class of anonymous controllers will be inferred
    # automatically. This will be the default behavior in future versions of
    # rspec-rails.
    config.infer_base_class_for_anonymous_controllers = false
  
    
  end
  
  Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

end

Spork.each_run do
  [ "support/config/*.rb", "support/*.rb" ].each do |path|
    Dir["#{File.dirname(__FILE__)}/#{path}"].each do |file|
      require file
    end
  end
end

Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}