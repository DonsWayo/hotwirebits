# frozen_string_literal: true

module RailsBits
  class TimelineComponent < Base
    def initialize(items: [], **attrs)
      @items = items
      @extra_attrs = attrs
    end

    def container_classes
      merge_classes(
        'relative',
        @extra_attrs.delete(:class)
      )
    end
  end
end
