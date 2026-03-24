# frozen_string_literal: true

module HotwireBits
  class BrowserMockupComponent < Base
    def initialize(url: nil, title: nil, **attrs)
      @url = url
      @title = title
      @extra_attrs = attrs
    end
  end
end
