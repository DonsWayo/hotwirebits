# frozen_string_literal: true

module HotwireBits
  class RatingComponent < Base
    SIZES = {
      sm: 'h-4 w-4',
      md: 'h-5 w-5',
      lg: 'h-6 w-6',
      xl: 'h-8 w-8'
    }.freeze

    def initialize(name: nil, value: 0, max: 5, size: :md, readonly: false, allow_half: false, icon: :star, **attrs)
      @name = name
      @value = value
      @max = max
      @size = size
      @readonly = readonly
      @allow_half = allow_half
      @icon = icon
      @extra_attrs = attrs
    end

    def call
      tag.div(class: 'flex items-center gap-0.5', data: { controller: 'hw-rating' }) do
        safe_join([
                    hidden_input,
                    *@max.times.map do |i|
                      star_button(i + 1)
                    end
                  ])
      end
    end

    private

    def hidden_input
      tag.input(type: 'hidden', name: @name, value: @value, data: { rb_rating_target: 'input' })
    end

    def star_button(index)
      filled = index <= @value
      tag.button(
        type: 'button',
        class: merge_classes('text-hw-muted-foreground', filled ? 'text-yellow-400' : ''),
        data: { action: @readonly ? nil : 'click->hw-rating#select', value: index },
        disabled: @readonly
      ) do
        if @icon == :star
          tag.svg(class: SIZES[@size] || SIZES[:md], fill: filled ? 'currentColor' : 'none', stroke: 'currentColor',
                  viewBox: '0 0 24 24') do
            tag.path(stroke_linecap: 'round', stroke_linejoin: 'round', stroke_width: '1.5',
                     d: 'M11.049 2.927c.3-.921 1.603-.921 1.902 0l1.519 4.674a1 1 0 00.95.69h4.915c.969 0 1.371 1.24.588 1.81l-3.976 2.888a1 1 0 00-.363 1.118l1.518 4.674c.3.922-.755 1.688-1.538 1.118l-3.976-2.888a1 1 0 00-1.176 0l-3.976 2.888c-.783.57-1.838-.197-1.538-1.118l1.518-4.674a1 1 0 00-.363-1.118l-3.976-2.888c-.784-.57-.38-1.81.588-1.81h4.914a1 1 0 00.951-.69l1.519-4.674z')
          end
        else
          tag.svg(class: SIZES[@size] || SIZES[:md], fill: filled ? 'currentColor' : 'none', stroke: 'currentColor',
                  viewBox: '0 0 24 24') do
            tag.path(stroke_linecap: 'round', stroke_linejoin: 'round', stroke_width: '1.5',
                     d: 'M4.318 6.318a4.5 4.5 0 000 6.364L12 20.364l7.682-7.682a4.5 4.5 0 00-6.364-6.364L12 7.636l-1.318-1.318a4.5 4.5 0 00-6.364 0z')
          end
        end
      end
    end
  end
end
