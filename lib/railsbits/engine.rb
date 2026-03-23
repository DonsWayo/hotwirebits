# frozen_string_literal: true

module RailsBits
  class Engine < ::Rails::Engine
    isolate_namespace RailsBits

    initializer 'railsbits.assets' do |app|
      app.config.assets.precompile += %w[railsbits/theme.css]
    end

    initializer 'railsbits.helpers' do
      ActiveSupport.on_load(:action_view) do
        include RailsBits::ComponentsHelper
      end
    end
  end
end
