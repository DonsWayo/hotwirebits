# frozen_string_literal: true

module HotwireBits
  class NotificationComponent < Base
    def initialize(title: nil, message: nil, icon: nil, closable: false, time: nil, **attrs)
      @title = title
      @message = message
      @icon = icon
      @closable = closable
      @time = time
      @extra_attrs = attrs
    end

    private

    def notification_classes
      merge_classes(
        "flex items-start gap-3 rounded-lg border border-hw-border bg-hw-card p-4 shadow-sm",
        @extra_attrs.delete(:class)
      )
    end
  end
end
