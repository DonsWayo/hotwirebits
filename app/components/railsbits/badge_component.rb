# frozen_string_literal: true

module RailsBits
  class BadgeComponent < Base
    VARIANTS = {
      default: 'border-transparent bg-rb-primary text-rb-primary-foreground',
      secondary: 'border-transparent bg-rb-secondary text-rb-secondary-foreground',
      destructive: 'border-transparent bg-rb-destructive text-rb-destructive-foreground',
      outline: 'text-rb-foreground',
      success: 'border-transparent bg-rb-success text-rb-success-foreground',
      warning: 'border-transparent bg-rb-warning text-rb-warning-foreground',
      info: 'border-transparent bg-rb-info text-rb-info-foreground'
    }.freeze

    SIZES = {
      sm: 'px-1.5 py-0 text-[10px]',
      md: 'px-2.5 py-0.5 text-xs',
      lg: 'px-3 py-1 text-sm'
    }.freeze

    def initialize(label: nil, variant: :default, size: :md, dot: false, removable: false, dismiss_url: nil, **attrs)
      @label = label
      @variant = variant
      @size = size
      @dot = dot
      @removable = removable
      @dismiss_url = dismiss_url
      @extra_attrs = attrs
    end

    def call
      content_or_label = content || @label

      tag.div(class: badge_classes, **@extra_attrs) do
        safe_join([
          (tag.span(class: 'h-1.5 w-1.5 rounded-full bg-current') if @dot),
          content_or_label,
          (dismiss_button if @removable)
        ].compact)
      end
    end

    private

    def badge_classes
      merge_classes(
        'inline-flex items-center rounded-full border font-semibold transition-colors',
        'focus:outline-none focus:ring-2 focus:ring-rb-ring focus:ring-offset-2',
        VARIANTS[@variant] || VARIANTS[:default],
        SIZES[@size] || SIZES[:md]
      )
    end

    def dismiss_button
      tag.button(
        type: 'button',
        class: 'ml-1 -mr-0.5 h-3.5 w-3.5 rounded-full p-0.5 hover:bg-white/20',
        data: { action: 'click->rb-badge#dismiss' }
      ) do
        tag.svg(xmlns: 'http://www.w3.org/2000/svg', viewBox: '0 0 24 24', fill: 'none',
                stroke: 'currentColor', stroke_width: '2', class: 'h-2.5 w-2.5') do
          tag.path(stroke_linecap: 'round', stroke_linejoin: 'round', d: 'M6 18L18 6M6 6l12 12')
        end
      end
    end
  end
end
