# frozen_string_literal: true

module HotwireBits
  class JoinComponent < Base
    def initialize(direction: :horizontal, **attrs)
      @direction = direction
      @extra_attrs = attrs
    end

    def join_classes
      merge_classes(
        "join",
        (@direction == :vertical) ? "join-vertical" : "join-horizontal",
        @extra_attrs.delete(:class)
      )
    end
  end
end
