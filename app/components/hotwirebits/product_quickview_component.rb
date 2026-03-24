# frozen_string_literal: true

module HotwireBits
  class ProductQuickviewComponent < Base
    def initialize(name:, price:, image: nil, description: nil, rating: nil, href: nil, **attrs)
      @name = name
      @price = price
      @image = image
      @description = description
      @rating = rating
      @href = href
      @extra_attrs = attrs
    end
  end
end
