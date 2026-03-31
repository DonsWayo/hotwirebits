# frozen_string_literal: true

require_relative 'boot'

# Only require the Rails frameworks we need (no ActiveRecord for a UI component gem)
require 'action_controller/railtie'
require 'action_view/railtie'
require 'active_support/railtie'
require 'rails/test_unit/railtie'

module Dummy
  class Application < Rails::Application
    config.load_defaults "#{Rails::VERSION::MAJOR}.#{Rails::VERSION::MINOR}".to_f
    config.eager_load = false
    config.root = File.expand_path('../..', __FILE__)
  end
end
