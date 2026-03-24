# frozen_string_literal: true

module HotwireBits
  class ThemeSelectorComponent < Base
    def initialize(themes: [], current_theme: nil, **attrs)
      @themes = themes
      @current_theme = current_theme
      @extra_attrs = attrs
    end
  end
end
