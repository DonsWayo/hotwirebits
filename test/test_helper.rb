# frozen_string_literal: true

ENV['RAILS_ENV'] = 'test'

require_relative '../test/dummy/config/environment'
require 'rails/test_help'
require 'capybara/cuprite'

class ActiveSupport::TestCase
  parallelize(workers: :number_of_processors)
  fixtures :all
end

class ActionDispatch::IntegrationTest
  include Capybara::DSL

  Capybara.register_driver(:cuprite) do |app|
    Capybara::Cuprite::Driver.new(app, window_size: [1400, 900])
  end

  Capybara.javascript_driver = :cuprite
end
