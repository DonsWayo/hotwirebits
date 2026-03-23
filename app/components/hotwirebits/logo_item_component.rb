# frozen_string_literal: true

module HotwireBits
  class LogoItemComponent < Base
    def initialize(name:, url: nil, image_url: nil, grayscale: true, **attrs)
      @name = name
      @url = url
      @image_url = image_url
      @grayscale = grayscale
      @extra_attrs = attrs
    end

    def item_classes
      merge_classes(
        'flex items-center justify-center transition-all',
        @grayscale ? 'grayscale opacity-60 hover:grayscale-0 hover:opacity-100' : nil
      )
    end
  end
end
