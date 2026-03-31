# frozen_string_literal: true

module HotwireBits
  class StackedListComponent < Base
    def initialize(items: [], divided: true, **attrs)
      @items = items
      @divided = divided
      @extra_attrs = attrs
    end

    def container_classes
      merge_classes(
        @divided ? "divide-y divide-hw-border border-y border-hw-border" : "space-y-2",
        @extra_attrs.delete(:class)
      )
    end
  end
end
