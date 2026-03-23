# frozen_string_literal: true

module RailsBits
  class ContainerComponent < Base
    SIZES = {
      sm: 'max-w-screen-sm',
      md: 'max-w-screen-md',
      lg: 'max-w-screen-lg',
      xl: 'max-w-screen-xl',
      "2xl": 'max-w-screen-2xl',
      full: 'max-w-full'
    }.freeze

    def initialize(size: :lg, centered: true, **attrs)
      @size = size
      @centered = centered
      @extra_attrs = attrs
    end

    def container_classes
      merge_classes(
        'w-full px-4 sm:px-6 lg:px-8',
        SIZES[@size],
        @centered ? 'mx-auto' : nil,
        @extra_attrs.delete(:class)
      )
    end
  end
end
