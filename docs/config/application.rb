# frozen_string_literal: true

require_relative 'boot'
require 'rails/all'

Bundler.require(*Rails.groups)

module HotwireBitsDocs
  class Application < Rails::Application
    config.load_defaults Rails::VERSION.to_f.to_s
    config.autoload_lib(ignore: %w[assets tasks])
    config.eager_load = false
    config.hosts.clear
    config.view_component.show_previews = true
  end
end
