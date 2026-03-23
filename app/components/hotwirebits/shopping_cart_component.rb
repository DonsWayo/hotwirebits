# frozen_string_literal: true

module HotwireBits
  class ShoppingCartComponent < Base
    def initialize(items: [], total: nil, **attrs)
      @items = items
      @total = total || calculate_total
      @extra_attrs = attrs
    end

    private

    def calculate_total
      @items.sum { |item| (item[:price].to_s.gsub(/[^0-9.]/, '').to_f * item[:quantity].to_i) }
    end
  end
end
