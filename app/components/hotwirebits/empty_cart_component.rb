# frozen_string_literal: true

module HotwireBits
  class EmptyCartComponent < Base
    def initialize(message: "Your cart is empty", action_label: "Continue Shopping", action_href: nil, icon: nil,
      **attrs)
      @message = message
      @action_label = action_label
      @action_href = action_href
      @icon = icon
      @extra_attrs = attrs
    end
  end
end
