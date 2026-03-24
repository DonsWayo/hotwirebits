# frozen_string_literal: true

module HotwireBits
  class SpinnerComponent < Base
    SIZES = {
      xs: 'h-3 w-3',
      sm: 'h-4 w-4',
      md: 'h-6 w-6',
      lg: 'h-8 w-8',
      xl: 'h-12 w-12'
    }.freeze

    def initialize(size: :md, label: 'Loading...', show_label: false, **attrs)
      @size = size
      @label = label
      @show_label = show_label
      @extra_attrs = attrs
    end
  end
end
