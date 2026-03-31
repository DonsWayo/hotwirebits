# frozen_string_literal: true

module HotwireBits
  class TextRotateComponent < Base
    def initialize(texts: [], interval: 2000, effect: :fade, **attrs)
      @texts = texts
      @interval = interval
      @effect = effect
      @extra_attrs = attrs
    end

    def wrapper_classes
      merge_classes("inline-block overflow-hidden relative align-baseline", @extra_attrs.delete(:class))
    end

    def effect_classes
      case @effect
      when :slide then "translate-y-full opacity-0"
      when :flip then "rotate-x-90 opacity-0"
      else "opacity-0"
      end
    end
  end
end
