# frozen_string_literal: true

module HotwireBits
  class ReviewComponent < Base
    def initialize(author:, content:, rating: 5, title: nil, date: nil, verified: false, **attrs)
      @author = author
      @rating = rating.to_i.clamp(0, 5)
      @title = title
      @content = content
      @date = date
      @verified = verified
      @extra_attrs = attrs
    end

    def initials
      @author.to_s.split.map(&:first).join[0..1].upcase
    end
  end
end
