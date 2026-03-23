# frozen_string_literal: true

module RailsBits
  class CarouselComponent < Base
    renders_many :slides

    def initialize(items: [], autoplay: false, show_dots: true, show_arrows: true, interval: 5000, **attrs)
      @items = items
      @autoplay = autoplay
      @show_dots = show_dots
      @show_arrows = show_arrows
      @interval = interval
      @extra_attrs = attrs
    end

    def container_classes
      merge_classes(
        'relative w-full overflow-hidden',
        @extra_attrs.delete(:class)
      )
    end

    def all_slides
      slides? ? slides : @items
    end
  end
end
