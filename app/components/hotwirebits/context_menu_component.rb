# frozen_string_literal: true

module HotwireBits
  class ContextMenuComponent < Base
    def initialize(items: [], **attrs)
      @items = items
      @extra_attrs = attrs
    end

    def container_classes
      merge_classes('contents', @extra_attrs.delete(:class))
    end
  end
end
