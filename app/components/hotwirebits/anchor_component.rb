# frozen_string_literal: true

module HotwireBits
  class AnchorComponent < Base
    def initialize(href:, label: nil, icon: nil, **attrs)
      @href = href
      @label = label
      @icon = icon
      @extra_attrs = attrs
    end
  end
end
