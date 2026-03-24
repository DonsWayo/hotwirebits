# frozen_string_literal: true

module HotwireBits
  class ChipComponent < Base
    def initialize(label: nil, removable: false, avatar: nil, icon: nil, size: :md, **attrs)
      @label = label
      @removable = removable
      @avatar = avatar
      @icon = icon
      @size = size
      @extra_attrs = attrs
    end

    private

    def chip_classes
      sizes = {
        sm: 'h-6 text-xs px-2 gap-1',
        md: 'h-8 text-sm px-2.5 gap-1.5',
        lg: 'h-10 text-sm px-3 gap-2'
      }
      merge_classes(
        'inline-flex items-center rounded-full border border-hw-border bg-hw-background',
        'text-hw-foreground font-medium',
        sizes[@size] || sizes[:md]
      )
    end

    def avatar_element
      return unless @avatar

      tag.img(src: @avatar, class: 'h-5 w-5 rounded-full', alt: '')
    end

    def icon_element
      return unless @icon

      tag.span(@icon.html_safe, class: 'h-4 w-4') if @icon.is_a?(String)
    end

    def dismiss_button
      tag.button(type: 'button',
                 class: 'ml-0.5 -mr-1 h-4 w-4 rounded-full hover:bg-hw-muted p-0.5 focus:outline-none') do
        tag.svg(xmlns: 'http://www.w3.org/2000/svg', viewBox: '0 0 24 24', fill: 'none',
                stroke: 'currentColor', stroke_width: '2', class: 'h-3 w-3') do
          tag.path(stroke_linecap: 'round', stroke_linejoin: 'round', d: 'M6 18L18 6M6 6l12 12')
        end
      end
    end
  end
end
