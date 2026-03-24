# frozen_string_literal: true

module HotwireBits
  class BreadcrumbAdvancedComponent < Base
    SEPARATORS = {
      slash: '/',
      chevron: nil,
      arrow: '>'
    }.freeze

    def initialize(items: [], max_items: nil, separator: :slash, **attrs)
      @items = items
      @max_items = max_items
      @separator = separator
      @extra_attrs = attrs
    end

    def visible_items
      if @max_items && @items.size > @max_items
        first = @items.first
        last_items = @items.last(@max_items - 1)
        [first, { label: '...', collapsed: true }] + last_items
      else
        @items
      end
    end

    def separator_char
      SEPARATORS[@separator] || '/'
    end
  end
end
