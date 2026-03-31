# frozen_string_literal: true

require_relative "boot"
require "action_controller/railtie"
require "action_view/railtie"
require "rails/test_unit/railtie"

Bundler.require(*Rails.groups)

module HotwireBitsDocs
  class Application < Rails::Application
    config.load_defaults "8.1"
    config.eager_load = false
    config.hosts.clear
  end
end
