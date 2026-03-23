# frozen_string_literal: true

module HotwireBits
  class HeroComponent < Base
    VARIANTS = {
      centered: 'text-center items-center',
      split: 'md:text-left items-center md:items-start',
      with_image: 'text-center items-center'
    }.freeze

    def initialize(title:, subtitle: nil, primary_cta: nil, secondary_cta: nil, image_url: nil, variant: :centered,
                   **attrs)
      @title = title
      @subtitle = subtitle
      @primary_cta = primary_cta
      @secondary_cta = secondary_cta
      @image_url = image_url
      @variant = variant
      @extra_attrs = attrs
    end

    def container_classes
      merge_classes(
        'w-full py-16 md:py-24 px-4',
        @extra_attrs.delete(:class)
      )
    end

    def inner_classes
      merge_classes(
        'mx-auto max-w-5xl flex flex-col gap-6',
        VARIANTS[@variant] || VARIANTS[:centered]
      )
    end
  end
end
