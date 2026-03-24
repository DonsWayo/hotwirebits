# frozen_string_literal: true

module HotwireBits
  class WindowMockupComponent < Base
    def initialize(title: nil, resizable: false, **attrs)
      @title = title
      @resizable = resizable
      @extra_attrs = attrs
    end
  end
end
