# frozen_string_literal: true

module HotwireBits
  class DeviceMockupComponent < Base
    def initialize(type: :browser, device: nil, **attrs)
      @type = type
      @device = device
      @extra_attrs = attrs
    end

    def frame_classes
      case @type
      when :browser
        "rounded-lg border border-hw-border overflow-hidden bg-hw-background shadow-lg"
      when :phone
        phone_classes
      when :tablet
        "rounded-[2rem] border-[8px] border-hw-border overflow-hidden bg-black shadow-xl"
      when :window
        "rounded-lg border border-hw-border overflow-hidden bg-hw-foreground shadow-lg"
      end
    end

    private

    def phone_classes
      case @device
      when :android
        "rounded-[2rem] border-[6px] border-hw-border overflow-hidden bg-black shadow-xl"
      when :iphone
        "rounded-[3rem] border-[10px] border-hw-foreground overflow-hidden bg-black shadow-xl"
      else
        "rounded-[2rem] border-[8px] border-hw-border overflow-hidden bg-black shadow-xl"
      end
    end
  end
end
