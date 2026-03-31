# frozen_string_literal: true

require 'rails/generators'

module HotwireBits
  module Generators
    class ComponentGenerator < Rails::Generators::NamedBase
      source_root File.expand_path('templates', __dir__)
      desc 'Generate a HotwireBits component (ERB partial + ViewComponent)'

      class_option :format, type: :string, default: 'both', desc: 'Format: erb, view_component, or both'
      class_option :skip_stimulus, type: :boolean, default: false, desc: 'Skip Stimulus controller generation'

      def create_erb_partial
        return unless erb? || both?

        template 'component.html.erb.tt', "app/views/hotwirebits/_#{file_name}.html.erb"
      end

      def create_view_component
        return unless view_component? || both?

        template 'component.rb.tt', "app/components/hotwirebits/#{file_name}_component.rb"
        template 'component.html.erb.tt', "app/components/hotwirebits/#{file_name}_component.html.erb"
      end

      def create_stimulus_controller
        return if options[:skip_stimulus]

        template 'controller.js.tt', "app/javascript/controllers/hotwirebits/#{file_name}_controller.js"
      end

      private

      def erb?
        options[:format] == 'erb'
      end

      def view_component?
        options[:format] == 'view_component'
      end

      def both?
        options[:format] == 'both'
      end
    end
  end
end
