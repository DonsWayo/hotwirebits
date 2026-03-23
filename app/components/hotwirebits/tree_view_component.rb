# frozen_string_literal: true

module HotwireBits
  class TreeViewComponent < Base
    def initialize(items: [], **attrs)
      @items = items
      @extra_attrs = attrs
    end

    def container_classes
      merge_classes(
        'space-y-0.5',
        @extra_attrs.delete(:class)
      )
    end

    def icon_for(item)
      return unless item[:children]&.any?

      item[:expanded] ? '▾' : '▸'
    end
  end
end
