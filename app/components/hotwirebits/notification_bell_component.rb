# frozen_string_literal: true

module HotwireBits
  class NotificationBellComponent < Base
    SIZES = {
      sm: "h-5 w-5",
      md: "h-6 w-6",
      lg: "h-7 w-7"
    }.freeze

    def initialize(count: 0, href: nil, size: :md, **attrs)
      @count = count.to_i
      @href = href
      @size = size
      @extra_attrs = attrs
    end

    def icon_size
      SIZES[@size] || SIZES[:md]
    end
  end
end
