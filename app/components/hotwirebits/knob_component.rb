# frozen_string_literal: true

module HotwireBits
  class KnobComponent < Base
    SIZES = {
      sm: 48,
      md: 64,
      lg: 96
    }.freeze

    def initialize(value: 0, min: 0, max: 100, step: 1, size: :md, color: nil, name: nil, disabled: false, **attrs)
      @value = value.to_i
      @min = min.to_i
      @max = max.to_i
      @step = step.to_i
      @size = size
      @color = color || 'hw-primary'
      @name = name
      @disabled = disabled
      @extra_attrs = attrs
    end

    def call
      size_px = SIZES[@size] || SIZES[:md]
      stroke = size_px / 10
      radius = (size_px - stroke) / 2.0
      circumference = 2 * Math::PI * radius
      progress = ((@value - @min).to_f / [@max - @min, 1].max) * 0.75
      dashoffset = circumference * (1 - progress)
      center = size_px / 2.0

      tag.div(class: 'relative inline-flex items-center justify-center', data: { controller: 'hw-knob' },
              **@extra_attrs) do
        safe_join([
                    tag.svg(width: size_px, height: size_px, class: '-rotate-[135deg]') do
                      safe_join([
                                  tag.circle(
                                    cx: center, cy: center, r: radius,
                                    fill: 'none',
                                    stroke: 'currentColor',
                                    stroke_width: stroke,
                                    stroke_dasharray: "#{circumference * 0.75} #{circumference * 0.25}",
                                    class: 'text-hw-muted'
                                  ),
                                  tag.circle(
                                    cx: center, cy: center, r: radius,
                                    fill: 'none',
                                    stroke: 'currentColor',
                                    stroke_width: stroke,
                                    stroke_dasharray: "#{circumference * 0.75} #{circumference * 0.25}",
                                    stroke_dashoffset: dashoffset,
                                    stroke_linecap: 'round',
                                    class: "text-#{@color} transition-all duration-150",
                                    data: { rb_knob_target: 'progress' }
                                  )
                                ])
                    end,
                    tag.span(@value.to_s, class: 'absolute text-xs font-medium text-hw-foreground',
                                          data: { rb_knob_target: 'value' }),
                    tag.input(
                      type: 'range',
                      name: @name,
                      value: @value,
                      min: @min,
                      max: @max,
                      step: @step,
                      disabled: @disabled,
                      class: 'absolute inset-0 opacity-0 cursor-pointer',
                      data: { action: 'input->hw-knob#update' }
                    )
                  ])
      end
    end
  end
end
