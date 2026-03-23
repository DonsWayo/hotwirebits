# frozen_string_literal: true

module HotwireBits
  class BreadcrumbComponent < Base
    def initialize(items: [], separator: '/', **attrs)
      @items = items
      @separator = separator
      @extra_attrs = attrs
    end
  end
end
