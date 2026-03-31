# frozen_string_literal: true

module HotwireBits
  class StatusDotComponent < Base
    STATUSES = {
      online: "bg-hw-success",
      offline: "bg-hw-muted-foreground/40",
      busy: "bg-hw-destructive",
      away: "bg-hw-warning"
    }.freeze

    SIZES = {
      sm: "h-1.5 w-1.5",
      md: "h-2.5 w-2.5",
      lg: "h-3 w-3"
    }.freeze

    def initialize(status: :online, size: :md, with_pulse: false, label: nil, **attrs)
      @status = status
      @size = size
      @with_pulse = with_pulse
      @label = label
      @extra_attrs = attrs
    end

    private

    def dot_classes
      merge_classes(
        "inline-block rounded-full",
        STATUSES[@status] || STATUSES[:online],
        SIZES[@size] || SIZES[:md],
        @with_pulse ? "animate-pulse" : nil
      )
    end
  end
end
