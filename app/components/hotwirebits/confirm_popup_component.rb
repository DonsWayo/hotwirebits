# frozen_string_literal: true

module HotwireBits
  class ConfirmPopupComponent < Base
    def initialize(message:, confirm_label: "Confirm", cancel_label: "Cancel", position: :bottom, **attrs)
      @message = message
      @confirm_label = confirm_label
      @cancel_label = cancel_label
      @position = position
      @extra_attrs = attrs
    end

    def popup_classes
      merge_classes(
        "absolute z-50 w-64 rounded-md border border-hw-border bg-hw-popover p-3 text-hw-popover-foreground shadow-md hidden",
        position_classes,
        @extra_attrs.delete(:class)
      )
    end

    def position_classes
      case @position
      when :top then "bottom-full mb-2"
      when :bottom then "top-full mt-2"
      when :left then "right-full mr-2"
      when :right then "left-full ml-2"
      else "top-full mt-2"
      end
    end
  end
end
