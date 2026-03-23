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
        'rounded-lg border border-hw-border overflow-hidden bg-hw-background shadow-lg'
      when :phone
        phone_classes
      when :tablet
        'rounded-[2rem] border-[8px] border-neutral-800 overflow-hidden bg-black shadow-xl'
      when :window
        'rounded-lg border border-neutral-700 overflow-hidden bg-neutral-900 shadow-lg'
      end
    end

    private

    def phone_classes
      case @device
      when :android
        'rounded-[2rem] border-[6px] border-neutral-800 overflow-hidden bg-black shadow-xl'
      when :iphone
        'rounded-[3rem] border-[10px] border-neutral-900 overflow-hidden bg-black shadow-xl'
      else
        'rounded-[2rem] border-[8px] border-neutral-800 overflow-hidden bg-black shadow-xl'
      end
    end
  end
end
