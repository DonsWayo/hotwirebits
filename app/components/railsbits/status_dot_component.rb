# frozen_string_literal: true

module RailsBits
  class StatusDotComponent < Base
    STATUSES = {
      online: 'bg-rb-success',
      offline: 'bg-rb-muted-foreground/40',
      busy: 'bg-rb-destructive',
      away: 'bg-rb-warning'
    }.freeze

    SIZES = {
      sm: 'h-1.5 w-1.5',
      md: 'h-2.5 w-2.5',
      lg: 'h-3 w-3'
    }.freeze

    def initialize(status: :online, size: :md, with_pulse: false, **attrs)
      @status = status
      @size = size
      @with_pulse = with_pulse
      @extra_attrs = attrs
    end

    private

    def dot_classes
      merge_classes(
        'inline-block rounded-full',
        STATUSES[@status] || STATUSES[:online],
        SIZES[@size] || SIZES[:md],
        @with_pulse ? 'animate-pulse' : nil
      )
    end
  end
end
