# frozen_string_literal: true

module HotwireBits
  class SwapComponent < Base
    EFFECTS = {
      rotate: "swap-rotate",
      flip: "swap-flip",
      fade: "swap-fade"
    }.freeze

    def initialize(on_content: nil, off_content: nil, active: :on, effect: :fade, **attrs)
      @on_content = on_content
      @off_content = off_content
      @active = active
      @effect = effect
      @extra_attrs = attrs
    end

    private

    def effect_class
      EFFECTS[@effect] || EFFECTS[:fade]
    end

    def on?
      @active == :on
    end
  end
end
