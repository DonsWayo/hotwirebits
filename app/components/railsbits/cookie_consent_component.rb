# frozen_string_literal: true

module RailsBits
  class CookieConsentComponent < Base
    def initialize(message: 'We use cookies to improve your experience.', accept_label: 'Accept',
                   settings_label: 'Settings', position: :bottom, **attrs)
      @message = message
      @accept_label = accept_label
      @settings_label = settings_label
      @position = position
      @extra_attrs = attrs
    end

    def position_classes
      case @position
      when :top then 'top-0'
      else 'bottom-0'
      end
    end

    def container_classes
      merge_classes(
        "fixed inset-x-0 #{position_classes} z-50 p-4",
        @extra_attrs.delete(:class)
      )
    end
  end
end
