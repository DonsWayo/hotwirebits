# frozen_string_literal: true

module HotwireBits
  class FooterComponent < Base
    def initialize(brand: nil, copyright: nil, columns: [], social_links: [], **attrs)
      @brand = brand
      @copyright = copyright
      @columns = columns
      @social_links = social_links
      @extra_attrs = attrs
    end
  end
end
