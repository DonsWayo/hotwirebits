# frozen_string_literal: true

module HotwireBits
  class CtaSectionComponent < Base
    def initialize(title:, description: nil, primary_cta: nil, secondary_cta: nil, image_url: nil, variant: :simple,
      **attrs)
      @title = title
      @description = description
      @primary_cta = primary_cta
      @secondary_cta = secondary_cta
      @image_url = image_url
      @variant = variant
      @extra_attrs = attrs
    end

    def container_classes
      merge_classes(
        "py-16 md:py-24 px-4",
        @extra_attrs.delete(:class)
      )
    end
  end
end
