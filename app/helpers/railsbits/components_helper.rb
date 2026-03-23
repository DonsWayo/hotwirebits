# frozen_string_literal: true

module RailsBits
  module ComponentsHelper
    # Render any RailsBits component
    #
    #   rb(:button, label: "Click me", variant: :primary)
    #   rb(:alert, type: :success, message: "Done!")
    #   rb(:avatar, src: user.avatar_url, alt: user.name)
    def rb(component_name, **attrs, &block)
      component_class = "RailsBits::#{component_name.to_s.camelize}Component".safe_constantize
      if component_class
        render component_class.new(**attrs), &block
      else
        render partial: "railsbits/#{component_name}", locals: attrs, &block
      end
    end
  end
end
