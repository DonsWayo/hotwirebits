# frozen_string_literal: true

module HotwireBits
  class SpoilerComponent < Base
    def initialize(max_height: 100, show_more_label: 'Show more', show_less_label: 'Show less', **attrs)
      @max_height = max_height
      @show_more_label = show_more_label
      @show_less_label = show_less_label
      @extra_attrs = attrs
    end
  end
end
