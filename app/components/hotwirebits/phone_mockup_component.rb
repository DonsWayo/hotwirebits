# frozen_string_literal: true

module HotwireBits
  class PhoneMockupComponent < Base
    DEVICES = %i[iphone android].freeze

    def initialize(device: :iphone, color: :black, **attrs)
      @device = DEVICES.include?(device) ? device : :iphone
      @color = color
      @extra_attrs = attrs
    end

    def frame_classes
      case @device
      when :android
        'rounded-[2rem] border-[6px] overflow-hidden shadow-xl'
      else
        'rounded-[3rem] border-[10px] overflow-hidden shadow-xl'
      end
    end

    def border_color
      case @color
      when :silver then 'border-neutral-300 bg-neutral-300'
      when :gold then 'border-amber-200 bg-amber-200'
      else 'border-neutral-900 bg-neutral-900'
      end
    end
  end
end
