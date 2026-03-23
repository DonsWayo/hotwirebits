# frozen_string_literal: true

module HotwireBits
  class ThemeControllerComponent < Base
    def initialize(light_label: 'Light', dark_label: 'Dark', **attrs)
      @light_label = light_label
      @dark_label = dark_label
      @extra_attrs = attrs
    end
  end
end
