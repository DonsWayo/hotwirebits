# frozen_string_literal: true

module HotwireBits
  class TestimonialComponent < Base
    def initialize(quote:, author: nil, role: nil, company: nil, avatar: nil, rating: nil, **attrs)
      @quote = quote
      @author = author
      @role = role
      @company = company
      @avatar = avatar
      @rating = rating
      @extra_attrs = attrs
    end

    def container_classes
      merge_classes(
        'rounded-lg border border-hw-border bg-hw-card p-6',
        @extra_attrs.delete(:class)
      )
    end
  end
end
