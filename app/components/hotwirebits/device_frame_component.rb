# frozen_string_literal: true

module HotwireBits
  class DeviceFrameComponent < Base
    DEVICES = %i[phone tablet desktop watch].freeze
    COLORS = %i[black silver gold midnight].freeze

    def initialize(device: :phone, color: :black, **attrs)
      @device = DEVICES.include?(device) ? device : :phone
      @color = color
      @extra_attrs = attrs
    end

    def frame_classes
      case @device
      when :phone
        'rounded-[2.5rem] border-[10px] overflow-hidden bg-black shadow-xl'
      when :tablet
        'rounded-[1.5rem] border-[12px] overflow-hidden bg-black shadow-xl'
      when :desktop
        'rounded-lg border border-neutral-300 overflow-hidden bg-white shadow-xl'
      when :watch
        'rounded-[2rem] border-[8px] overflow-hidden bg-black shadow-xl'
      end
    end

    def border_color
      case @color
      when :silver then 'border-neutral-300'
      when :gold then 'border-amber-300'
      when :midnight then 'border-neutral-800'
      else 'border-neutral-900'
      end
    end
  end
end
