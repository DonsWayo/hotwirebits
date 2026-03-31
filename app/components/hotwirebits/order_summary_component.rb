# frozen_string_literal: true

module HotwireBits
  class OrderSummaryComponent < Base
    def initialize(items: [], subtotal: nil, tax: nil, shipping: nil, total: nil, **attrs)
      @items = items
      @subtotal = subtotal
      @tax = tax
      @shipping = shipping
      @total = total || calculate_total
      @extra_attrs = attrs
    end

    private

    def calculate_total
      sub = @items.sum { |i| i[:price].to_s.gsub(/[^0-9.]/, "").to_f * i[:quantity].to_i }
      tax_val = @tax.to_s.gsub(/[^0-9.]/, "").to_f
      ship_val = @shipping.to_s.gsub(/[^0-9.]/, "").to_f
      sub + tax_val + ship_val
    end
  end
end
