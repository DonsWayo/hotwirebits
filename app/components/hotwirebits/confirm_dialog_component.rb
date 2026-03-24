# frozen_string_literal: true

module HotwireBits
  class ConfirmDialogComponent < Base
    def initialize(message:, title: 'Confirm', confirm_label: 'Confirm', cancel_label: 'Cancel', variant: :default,
                   open: false, **attrs)
      @title = title
      @message = message
      @confirm_label = confirm_label
      @cancel_label = cancel_label
      @variant = variant
      @open = open
      @extra_attrs = attrs
    end

    def confirm_button_classes
      merge_classes(
        'inline-flex h-9 items-center justify-center rounded-md px-4 text-sm font-medium ring-offset-hw-background transition-colors focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-hw-ring focus-visible:ring-offset-2',
        @variant == :destructive ? 'bg-hw-destructive text-hw-destructive-foreground hover:bg-hw-destructive/90' : 'bg-hw-primary text-hw-primary-foreground hover:bg-hw-primary/90'
      )
    end
  end
end
