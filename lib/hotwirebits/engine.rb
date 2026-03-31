# frozen_string_literal: true

module HotwireBits
  class Engine < ::Rails::Engine
    isolate_namespace HotwireBits

    initializer "hotwirebits.inflections", before: :set_autoload_paths do
      Rails.autoloaders.each do |autoloader|
        autoloader.inflector.inflect("hotwirebits" => "HotwireBits")
      end
    end

    initializer "hotwirebits.helpers" do
      ActiveSupport.on_load(:action_controller_base) do
        helper HotwirebitsHelper
      end
    end

    initializer "hotwirebits.assets" do |app|
      if app.config.respond_to?(:assets) && app.config.assets
        app.config.assets.precompile += %w[hotwirebits/theme.css]
      end
    end
  end
end
