# frozen_string_literal: true

module RailsBits
  class AlertComponent < Base
    TYPES = {
      info: { bg: 'bg-rb-info/10 text-rb-info border-rb-info/30',
              icon: 'M11.25 11.25l.041-.02a.75.75 0 011.063.852l-.708 2.836a.75.75 0 001.063.853l.041-.021M21 12a9 9 0 11-18 0 9 9 0 0118 0zm-9-3.75h.008v.008H12V8.25z' },
      success: { bg: 'bg-rb-success/10 text-rb-success border-rb-success/30',
                 icon: 'M9 12.75L11.25 15 15 9.75M21 12a9 9 0 11-18 0 9 9 0 0118 0z' },
      warning: { bg: 'bg-rb-warning/10 text-rb-warning border-rb-warning/30',
                 icon: 'M12 9v3.75m-9.303 3.376c-.866 1.5.217 3.374 1.948 3.374h14.71c1.73 0 2.813-1.874 1.948-3.374L13.949 3.378c-.866-1.5-3.032-1.5-3.898 0L2.697 16.126zM12 15.75h.007v.008H12v-.008z' },
      error: { bg: 'bg-rb-destructive/10 text-rb-destructive border-rb-destructive/30',
               icon: 'M12 9v3.75m9-.75a9 9 0 11-18 0 9 9 0 0118 0zm-9 3.75h.008v.008H12v-.008z' }
    }.freeze

    def initialize(title: nil, message: nil, type: :info, dismissible: false, icon: true, **attrs)
      @title = title
      @message = message
      @type = type
      @dismissible = dismissible
      @icon = icon
      @extra_attrs = attrs
    end

    private

    def type_config
      TYPES[@type] || TYPES[:info]
    end

    def alert_classes
      merge_classes(
        'relative w-full rounded-lg border p-4',
        type_config[:bg],
        @extra_attrs.delete(:class)
      )
    end
  end
end
