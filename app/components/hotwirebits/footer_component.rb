# frozen_string_literal: true

module HotwireBits
  class FooterComponent < Base
    def initialize(brand: nil, copyright: nil, columns: nil, sections: nil, social_links: [], **attrs)
      @brand = brand
      @copyright = copyright
      @columns = sections || columns || []
      @social_links = social_links
      @extra_attrs = attrs
    end
  end
end
