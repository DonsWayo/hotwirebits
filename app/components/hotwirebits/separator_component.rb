# frozen_string_literal: true

module HotwireBits
  class SeparatorComponent < Base
    def initialize(orientation: :horizontal, decorative: true, label: nil, **attrs)
      @orientation = orientation
      @decorative = decorative
      @label = label
      @extra_attrs = attrs
    end

    def call
      if @label
        tag.div(class: 'relative flex items-center', role: 'none') do
          safe_join([
                      tag.div(class: horizontal_class),
                      tag.span(@label, class: 'px-2 text-xs text-hw-muted-foreground font-medium'),
                      tag.div(class: horizontal_class)
                    ])
        end
      else
        tag.div(class: separator_classes, role: (@decorative ? 'none' : 'separator'), **@extra_attrs)
      end
    end

    private

    def separator_classes
      if @orientation == :horizontal
        'shrink-0 bg-hw-border h-[1px] w-full'
      else
        'shrink-0 bg-hw-border h-full w-[1px]'
      end
    end

    def horizontal_class
      'shrink-0 bg-hw-border h-[1px] w-full'
    end
  end
end
