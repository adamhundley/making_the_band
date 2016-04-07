ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'spec_helper'
require 'rspec/rails'
require 'capybara'
require "selenium-webdriver"

Capybara.register_driver :selenium do |app|
  Capybara::Selenium::Driver.new(app, :browser => :chrome)
end

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true

  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!

  RSpec.describe FactoryGirl do
  described_class.factories.map(&:name).each do |factory_name|
    describe "#{factory_name} factory" do
      it 'is valid' do
        factory = described_class.build(factory_name)
        expect(factory)
          .to be_valid, -> { factory.errors.full_messages.join("\n") }
      end
    end
  end
  end

  def stub_omniauth
    # first, set OmniAuth to run in test mode
    OmniAuth.config.test_mode = true
    # then, provide a set of fake oauth data that
    # omniauth will use when a user tries to authenticate:
    OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new({
      provider: 'facebook',
      extra: {
        raw_info: {
          user_id: "1234",
          name: "Horace",
          email: "horace@turing.io"
        }
      },
      credentials: {
        token: "pizza",
        expires_at: "1231231"
      },
      info: {
        location: "Denver, CO",
        image: "test"
      }

    })
  end
end

VCR.configure do |config|
  config.allow_http_connections_when_no_cassette = true
  config.cassette_library_dir = "spec/cassettes"
  config.hook_into :webmock
end
