# frozen_string_literal: true

module RailsBits
  class SimpleGridComponent < Base
    def initialize(min_col_width: '250px', gap: nil, **attrs)
      @min_col_width = min_col_width
      @gap = gap
      @extra_attrs = attrs
    end

    def grid_classes
      merge_classes(
        'grid',
        @gap && "gap-#{@gap}",
        @extra_attrs.delete(:class)
      )
    end

    def grid_styles
      "grid-template-columns: repeat(auto-fit, minmax(#{@min_col_width}, 1fr));"
    end
  end
end
