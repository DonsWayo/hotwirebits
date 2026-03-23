# frozen_string_literal: true

Rails.application.configure do
  config.enable_reloading = false
  config.eager_load = true
  config.consider_all_requests_local = false
  config.action_controller.perform_caching = true
  config.public_file_server.enabled = ENV['RAILS_SERVE_STATIC_FILES'].present?
  config.assets.compile = false
  config.active_support.deprecation = :notify
  config.log_formatter = ::Logger::Formatter.new
  config.log_tags = [:request_id]
  config.action_mailer.raise_delivery_errors = false
  config.active_record.dump_schema_after_migration = false if defined?(ActiveRecord)
end
