# frozen_string_literal: true

module RailsBits
  class BentoGridComponent < Base
    renders_many :items, lambda { |col_span: 1, row_span: 1, **attrs, &block|
      BentoItem.new(col_span: col_span, row_span: row_span, **attrs, &block)
    }

    class BentoItem < Base
      def initialize(col_span: 1, row_span: 1, **attrs)
        @col_span = col_span
        @row_span = row_span
        @extra_attrs = attrs
      end

      def item_classes
        merge_classes(
          "col-span-#{@col_span} row-span-#{@row_span}",
          @extra_attrs.delete(:class)
        )
      end
    end

    def initialize(columns: 3, **attrs)
      @columns = columns.clamp(2, 4)
      @extra_attrs = attrs
    end

    def grid_classes
      merge_classes(
        "grid grid-cols-#{@columns} gap-4 auto-rows-[180px]",
        @extra_attrs.delete(:class)
      )
    end
  end
end
