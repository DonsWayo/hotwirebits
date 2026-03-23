# frozen_string_literal: true

module HotwireBits
  class StatusComponent < Base
    COLORS = {
      online: 'bg-green-500',
      offline: 'bg-gray-400',
      busy: 'bg-red-500',
      away: 'bg-yellow-500',
      error: 'bg-red-500',
      success: 'bg-green-500',
      warning: 'bg-yellow-500',
      info: 'bg-blue-500'
    }.freeze

    SIZES = {
      xs: 'h-1.5 w-1.5',
      sm: 'h-2 w-2',
      md: 'h-2.5 w-2.5',
      lg: 'h-3 w-3'
    }.freeze

    def initialize(status: :online, size: :md, label: nil, **attrs)
      @status = status
      @size = size
      @label = label
      @extra_attrs = attrs
    end

    def call
      tag.span(class: 'inline-flex items-center gap-1.5', **@extra_attrs) do
        safe_join([
          tag.span(class: merge_classes(
            'rounded-full',
            COLORS[@status] || COLORS[:offline],
            SIZES[@size] || SIZES[:md]
          )),
          (@label ? tag.span(@label, class: 'text-sm text-hw-muted-foreground') : nil)
        ].compact)
      end
    end
  end
end
