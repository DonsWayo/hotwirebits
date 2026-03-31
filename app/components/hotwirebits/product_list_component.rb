# frozen_string_literal: true

module HotwireBits
  class ProductListComponent < Base
    def initialize(products: [], columns: 4, **attrs)
      @products = products
      @columns = columns
      @extra_attrs = attrs
    end

    def grid_classes
      cols = case @columns
      when 2 then "grid-cols-2"
      when 3 then "grid-cols-2 md:grid-cols-3"
      when 5 then "grid-cols-2 md:grid-cols-3 lg:grid-cols-5"
      else "grid-cols-2 md:grid-cols-3 lg:grid-cols-4"
      end
      merge_classes("grid gap-6", cols, @extra_attrs.delete(:class))
    end
  end
end
