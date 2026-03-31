# frozen_string_literal: true

module HotwireBits
  class AnimatedNumberComponent < Base
    EASINGS = {
      linear: "linear",
      ease: "ease",
      ease_in: "ease-in",
      ease_out: "ease-out",
      ease_in_out: "ease-in-out"
    }.freeze

    def initialize(value: 0, duration: 1000, prefix: "", suffix: "", easing: :ease_out, **attrs)
      @value = value
      @duration = duration
      @prefix = prefix
      @suffix = suffix
      @easing = easing
      @extra_attrs = attrs
    end

    private

    def easing_value
      EASINGS[@easing] || EASINGS[:ease_out]
    end
  end
end
