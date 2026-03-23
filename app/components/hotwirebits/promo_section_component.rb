# frozen_string_literal: true

module HotwireBits
  class PromoSectionComponent < Base
    VARIANTS = {
      default: 'bg-white',
      dark: 'bg-hw-foreground text-hw-background',
      gradient: 'bg-gradient-to-br from-hw-primary to-hw-primary/70 text-hw-primary-foreground',
      light: 'bg-hw-muted'
    }.freeze

    def initialize(title:, badge: nil, description: nil, cta: nil, image: nil, variant: :default, **attrs)
      @badge = badge
      @title = title
      @description = description
      @cta = cta
      @image = image
      @variant = variant
      @extra_attrs = attrs
    end

    def section_classes
      merge_classes(
        'rounded-2xl overflow-hidden',
        VARIANTS[@variant] || VARIANTS[:default],
        @extra_attrs.delete(:class)
      )
    end
  end
end
