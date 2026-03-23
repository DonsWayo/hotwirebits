# frozen_string_literal: true

require_relative 'boot'
require 'rails/all'

module Dummy
  class Application < Rails::Application
    config.load_defaults Rails::VERSION.to_f
    config.eager_load = false
    config.active_support.deprecation = :stderr
    config.view_component.show_previews = true
    config.view_component.preview_paths << Rails.root.join('previews')
  end
end
