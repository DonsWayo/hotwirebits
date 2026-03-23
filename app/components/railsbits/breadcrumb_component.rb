# frozen_string_literal: true

module RailsBits
  class BreadcrumbComponent < Base
    def initialize(items: [], separator: '/', **attrs)
      @items = items
      @separator = separator
      @extra_attrs = attrs
    end
  end
end
