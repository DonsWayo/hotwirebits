# frozen_string_literal: true

module HotwireBits
  class ToastComponent < Base
    TYPES = {
      success: {bg: "border-hw-success/30", icon: "text-hw-success", default_title: "Success"},
      error: {bg: "border-hw-destructive/30", icon: "text-hw-destructive", default_title: "Error"},
      warning: {bg: "border-hw-warning/30", icon: "text-hw-warning", default_title: "Warning"},
      info: {bg: "border-hw-info/30", icon: "text-hw-info", default_title: "Info"}
    }.freeze

    ICONS = {
      success: '<path stroke-linecap="round" stroke-linejoin="round" d="M9 12.75L11.25 15 15 9.75M21 12a9 9 0 11-18 0 9 9 0 0118 0z"/>',
      error: '<path stroke-linecap="round" stroke-linejoin="round" d="M12 9v3.75m9-.75a9 9 0 11-18 0 9 9 0 0118 0zm-9 3.75h.008v.008H12v-.008z"/>',
      warning: '<path stroke-linecap="round" stroke-linejoin="round" d="M12 9v3.75m-9.303 3.376c-.866 1.5.217 3.374 1.948 3.374h14.71c1.73 0 2.813-1.874 1.948-3.374L13.949 3.378c-.866-1.5-3.032-1.5-3.898 0L2.697 16.126zM12 15.75h.007v.008H12v-.008z"/>',
      info: '<path stroke-linecap="round" stroke-linejoin="round" d="M11.25 11.25l.041-.02a.75.75 0 011.063.852l-.708 2.836a.75.75 0 001.063.853l.041-.021M21 12a9 9 0 11-18 0 9 9 0 0118 0zm-9-3.75h.008v.008H12V8.25z"/>'
    }.freeze

    def initialize(title: nil, description: nil, type: :info, duration: 5000, action: nil, **attrs)
      @title = title
      @description = description
      @type = type
      @duration = duration
      @action = action
      @extra_attrs = attrs
    end

    private

    def type_config
      TYPES[@type] || TYPES[:info]
    end

    def icon_svg
      ICONS[@type] || ICONS[:info]
    end

    def toast_classes
      merge_classes(
        "pointer-events-auto relative flex w-full items-center justify-between space-x-4 overflow-hidden rounded-md border p-4 pr-8 shadow-lg transition-all",
        type_config[:bg],
        "bg-hw-background",
        @extra_attrs.delete(:class)
      )
    end
  end
end
