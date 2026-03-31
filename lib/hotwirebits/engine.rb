# frozen_string_literal: true

module HotwireBits
  class Engine < ::Rails::Engine
    initializer 'hotwirebits.helpers' do
      ActiveSupport.on_load(:action_view) do
        include HotwirebitsHelper
      end
    end

    initializer 'hotwirebits.assets' do |app|
      app.config.assets.precompile += %w[hotwirebits/theme.css]
    end
  end
end
