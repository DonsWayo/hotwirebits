# frozen_string_literal: true

require 'rails/generators'

module RailsBits
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path('templates', __dir__)
      desc 'Install RailsBits into your Rails application'

      def copy_theme_stylesheet
        copy_file 'theme.css', 'app/assets/stylesheets/railsbits/theme.css'
      end

      def create_stimulus_controllers_directory
        empty_directory 'app/javascript/controllers/railsbits'
        create_file 'app/javascript/controllers/railsbits/.keep'
      end

      def add_stimulus_import
        stimulus_manifest = 'app/javascript/controllers/index.js'
        return unless File.exist?(stimulus_manifest)

        append_to_file stimulus_manifest do
          <<~RUBY

            // RailsBits Stimulus controllers
            import RailsBits from "railsbits"
          RUBY
        end
      end

      def show_readme
        say ''
        say 'RailsBits installed successfully!', :green
        say ''
        say "Add to your layout's <head>:"
        say '  <%= stylesheet_link_tag "railsbits/theme" %>', :cyan
        say ''
        say 'Generate your first component:'
        say '  rails generate railsbits:component Button', :cyan
        say ''
      end
    end
  end
end
