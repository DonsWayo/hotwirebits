# frozen_string_literal: true

module HotwireBits
  class SkeletonComponent < Base
    def initialize(shape: :rectangle, width: nil, height: nil, circle_size: nil, **attrs)
      @shape = shape
      @width = width
      @height = height
      @circle_size = circle_size
      @extra_attrs = attrs
    end

    private

    def skeleton_classes
      base = 'animate-pulse bg-hw-muted'
      case @shape
      when :circle
        merge_classes(base, 'rounded-full')
      when :text
        merge_classes(base, 'rounded h-4 w-full')
      else
        merge_classes(base, 'rounded-md')
      end
    end

    def skeleton_style
      styles = []
      if @shape == :circle
        size = @circle_size || '40px'
        styles << "width: #{size}; height: #{size};"
      else
        styles << "width: #{@width};" if @width
        styles << "height: #{@height};" if @height
      end
      styles.join(' ')
    end
  end
end
