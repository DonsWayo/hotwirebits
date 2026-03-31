# frozen_string_literal: true

module HotwireBits
  class MultiselectComponent < Base
    def initialize(name: nil, options: [], selected: [], placeholder: "Select options...", disabled: false, max: nil,
      **attrs)
      @name = name
      @options = options
      @selected = selected || []
      @placeholder = placeholder
      @disabled = disabled
      @max = max
      @extra_attrs = attrs
    end

    private

    def trigger
      tag.button(
        type: "button",
        disabled: @disabled,
        class: "flex h-9 w-full items-center justify-between rounded-md border border-hw-input bg-hw-background px-3 text-sm text-hw-foreground ring-offset-hw-background placeholder:text-hw-muted-foreground focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-hw-ring focus-visible:ring-offset-2 disabled:cursor-not-allowed disabled:opacity-50",
        data: {action: "click->hw-multiselect#toggle"}
      ) do
        safe_join([
          tag.span(@selected.any? ? "#{@selected.size} selected" : @placeholder,
            class: @selected.any? ? "" : "text-hw-muted-foreground"),
          tag.svg(class: "h-4 w-4 opacity-50", fill: "none", stroke: "currentColor", stroke_width: "2",
            viewBox: "0 0 24 24") do
            tag.path(stroke_linecap: "round", stroke_linejoin: "round", d: "M19 9l-7 7-7-7")
          end
        ])
      end
    end

    def dropdown
      tag.div(class: "absolute z-50 mt-1 w-full rounded-md border border-hw-border bg-hw-popover shadow-md hidden",
        data: {rb_multiselect_target: "dropdown"}) do
        tag.ul(class: "max-h-60 overflow-auto p-1") do
          safe_join(@options.map do |opt|
            value = opt.is_a?(Array) ? opt.last : opt
            label = opt.is_a?(Array) ? opt.first : opt
            checked = @selected.include?(value)
            tag.li(class: "relative flex cursor-pointer select-none items-center rounded-sm px-2 py-1.5 text-sm outline-none hover:bg-hw-accent hover:text-hw-accent-foreground") do
              safe_join([
                tag.input(type: "checkbox", name: "#{@name}[]", value: value, checked: checked,
                  class: "mr-2 h-4 w-4 rounded border-hw-input"),
                tag.span(label)
              ])
            end
          end)
        end
      end
    end
  end
end
