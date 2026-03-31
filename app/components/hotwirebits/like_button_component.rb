# frozen_string_literal: true

module HotwireBits
  class LikeButtonComponent < Base
    SIZES = {
      sm: "h-4 w-4",
      md: "h-5 w-5",
      lg: "h-6 w-6"
    }.freeze

    def initialize(liked: false, count: 0, name: nil, size: :md, **attrs)
      @liked = liked
      @count = count.to_i
      @name = name
      @size = size
      @extra_attrs = attrs
    end

    def icon_size
      SIZES[@size] || SIZES[:md]
    end
  end
end
