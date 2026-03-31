# frozen_string_literal: true

module HotwireBits
  class LoadingOverlayComponent < Base
    SIZES = {
      sm: "h-4 w-4",
      md: "h-8 w-8",
      lg: "h-12 w-12"
    }.freeze

    def initialize(text: nil, message: nil, spinner_size: :md, **attrs)
      @text = text || message
      @spinner_size = spinner_size
      @extra_attrs = attrs
    end

    private

    def spinner_class
      SIZES[@spinner_size] || SIZES[:md]
    end
  end
end
