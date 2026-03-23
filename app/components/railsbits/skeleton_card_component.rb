# frozen_string_literal: true

module RailsBits
  class SkeletonCardComponent < Base
    def initialize(lines: 3, has_image: false, has_avatar: false, **attrs)
      @lines = lines
      @has_image = has_image
      @has_avatar = has_avatar
      @extra_attrs = attrs
    end

    def line_width(index)
      widths = ['w-full', 'w-4/5', 'w-3/4', 'w-2/3', 'w-1/2']
      widths[index % widths.length]
    end
  end
end
