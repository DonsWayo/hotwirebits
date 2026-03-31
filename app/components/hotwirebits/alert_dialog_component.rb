# frozen_string_literal: true

module HotwireBits
  class AlertDialogComponent < Base
    renders_one :confirm_action
    renders_one :cancel_action

    VARIANTS = {
      default: "bg-hw-primary text-hw-primary-foreground hover:bg-hw-primary/90",
      destructive: "bg-hw-destructive text-hw-destructive-foreground hover:bg-hw-destructive/90"
    }.freeze

    def initialize(title: nil, description: nil, confirm_label: "Confirm", cancel_label: "Cancel", variant: :default,
      open: false, **attrs)
      @title = title
      @description = description
      @confirm_label = confirm_label
      @cancel_label = cancel_label
      @variant = variant
      @open = open
      @extra_attrs = attrs
    end

    private

    def confirm_classes
      merge_classes(
        "inline-flex items-center justify-center rounded-md text-sm font-medium",
        "ring-offset-hw-background transition-colors focus-visible:outline-none focus-visible:ring-2",
        "focus-visible:ring-hw-ring focus-visible:ring-offset-2 disabled:pointer-events-none disabled:opacity-50",
        "h-10 px-4 py-2",
        VARIANTS[@variant] || VARIANTS[:default]
      )
    end

    def cancel_classes
      "inline-flex items-center justify-center rounded-md text-sm font-medium border border-hw-input bg-hw-background hover:bg-hw-accent hover:text-hw-accent-foreground h-10 px-4 py-2 ring-offset-hw-background focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-hw-ring focus-visible:ring-offset-2"
    end
  end
end
