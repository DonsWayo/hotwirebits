# frozen_string_literal: true

module HotwireBits
  class AvatarComponent < Base
    SIZES = {
      xs: 'h-6 w-6 text-[10px]',
      sm: 'h-8 w-8 text-xs',
      md: 'h-10 w-10 text-sm',
      lg: 'h-12 w-12 text-base',
      xl: 'h-16 w-16 text-lg'
    }.freeze

    STATUS_COLORS = {
      online: 'bg-green-500',
      offline: 'bg-gray-400',
      busy: 'bg-red-500',
      away: 'bg-yellow-500'
    }.freeze

    def initialize(src: nil, alt: nil, initials: nil, fallback: nil, size: :md, status: nil,
                   status_position: :bottom_right, **attrs)
      @src = src
      @alt = alt || ''
      @initials = initials
      @fallback = fallback
      @size = size
      @status = status
      @status_position = status_position
      @extra_attrs = attrs
    end

    private

    def avatar_content
      size_classes = SIZES[@size] || SIZES[:md]

      if @src
        tag.img(src: @src, alt: @alt, class: merge_classes(size_classes, 'rounded-full object-cover'))
      elsif @initials
        tag.div(@initials,
                class: merge_classes(size_classes,
                                     'rounded-full bg-hw-muted flex items-center justify-center font-medium text-hw-muted-foreground'))
      else
        tag.div(class: merge_classes(size_classes,
                                     'rounded-full bg-hw-muted flex items-center justify-center text-hw-muted-foreground')) do
          tag.svg(class: 'h-[60%] w-[60%]', fill: 'currentColor', viewBox: '0 0 24 24') do
            tag.path(d: 'M12 12c2.21 0 4-1.79 4-4s-1.79-4-4-4-4 1.79-4 4 1.79 4 4 4zm0 2c-2.67 0-8 1.34-8 4v2h16v-2c0-2.66-5.33-4-8-4z')
          end
        end
      end
    end

    def status_indicator
      positions = {
        top_right: '-top-0.5 -right-0.5',
        top_left: '-top-0.5 -left-0.5',
        bottom_right: '-bottom-0.5 -right-0.5',
        bottom_left: '-bottom-0.5 -left-0.5'
      }
      tag.span(class: merge_classes(
        'absolute block h-2.5 w-2.5 rounded-full ring-2 ring-white',
        STATUS_COLORS[@status] || STATUS_COLORS[:offline],
        positions[@status_position] || positions[:bottom_right]
      ))
    end
  end
end
