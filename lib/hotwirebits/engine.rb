# frozen_string_literal: true

module HotwireBits
  class Engine < ::Rails::Engine
    isolate_namespace HotwireBits

    initializer 'hotwirebits.assets' do |app|
      app.config.assets.precompile += %w[hotwirebits/theme.css]
    end

    initializer 'hotwirebits.helpers' do
      ActiveSupport.on_load(:action_view) do
        include HotwireBits::ComponentsHelper
      end
    end
  end
end
