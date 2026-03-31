# frozen_string_literal: true

require "rails/generators"

module HotwireBits
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("templates", __dir__)
      desc "Install HotwireBits into your Rails application"

      def copy_theme_stylesheet
        copy_file "theme.css", "app/assets/stylesheets/hotwirebits/theme.css"
      end

      def create_stimulus_controllers_directory
        empty_directory "app/javascript/controllers/hotwirebits"
        create_file "app/javascript/controllers/hotwirebits/.keep"
      end

      def add_stimulus_import
        stimulus_manifest = "app/javascript/controllers/index.js"
        return unless File.exist?(stimulus_manifest)

        append_to_file stimulus_manifest do
          <<~RUBY

            // HotwireBits Stimulus controllers
            import HotwireBits from "hotwirebits"
          RUBY
        end
      end

      def show_readme
        say ""
        say "HotwireBits installed successfully!", :green
        say ""
        say "Add to your layout's <head>:"
        say '  <%= stylesheet_link_tag "hotwirebits/theme" %>', :cyan
        say ""
        say "Generate your first component:"
        say "  rails generate hotwirebits:component Button", :cyan
        say ""
      end
    end
  end
end
