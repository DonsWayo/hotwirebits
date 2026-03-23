# frozen_string_literal: true

module HotwireBits
  class ProductOverviewComponent < Base
    def initialize(name:, price:, images: [], description: nil, features: [], rating: nil, **attrs)
      @name = name
      @price = price
      @images = images
      @description = description
      @features = features
      @rating = rating
      @extra_attrs = attrs
    end

    def main_image
      @images.first
    end
  end
end
