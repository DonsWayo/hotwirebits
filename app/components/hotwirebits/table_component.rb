# frozen_string_literal: true

module HotwireBits
  class TableComponent < Base
    def initialize(striped: false, bordered: false, hoverable: false, **attrs)
      @striped = striped
      @bordered = bordered
      @hoverable = hoverable
      @extra_attrs = attrs
    end

    def table_classes
      merge_classes(
        'w-full text-sm',
        @bordered ? 'border border-hw-border' : '',
        @extra_attrs.delete(:class)
      )
    end

    def row_classes(index)
      merge_classes(
        @striped && index.odd? ? 'bg-hw-muted/50' : '',
        @hoverable ? 'hover:bg-hw-muted/80 transition-colors' : ''
      )
    end
  end
end
