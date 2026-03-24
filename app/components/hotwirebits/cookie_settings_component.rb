# frozen_string_literal: true

module HotwireBits
  class CookieSettingsComponent < Base
    def initialize(categories: [], **attrs)
      @categories = categories
      @extra_attrs = attrs
    end
  end
end
