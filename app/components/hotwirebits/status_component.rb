# frozen_string_literal: true

module HotwireBits
  class StatusComponent < Base
    COLORS = {
      online: "bg-hw-success",
      offline: "bg-hw-muted-foreground/60",
      busy: "bg-hw-destructive",
      away: "bg-hw-warning",
      error: "bg-hw-destructive",
      success: "bg-hw-success",
      warning: "bg-hw-warning",
      info: "bg-hw-info"
    }.freeze

    SIZES = {
      xs: "h-1.5 w-1.5",
      sm: "h-2 w-2",
      md: "h-2.5 w-2.5",
      lg: "h-3 w-3"
    }.freeze

    def initialize(status: :online, size: :md, label: nil, **attrs)
      @status = status
      @size = size
      @label = label
      @extra_attrs = attrs
    end
  end
end
