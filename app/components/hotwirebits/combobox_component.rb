# frozen_string_literal: true

module HotwireBits
  class ComboboxComponent < Base
    def initialize(name: nil, options: [], selected: nil, placeholder: "Search...", allow_create: false,
      disabled: false, **attrs)
      @name = name
      @options = options
      @selected = selected
      @placeholder = placeholder
      @allow_create = allow_create
      @disabled = disabled
      @extra_attrs = attrs
    end

    private

    def hidden_input
      tag.input(type: "hidden", name: @name, value: @selected, data: {rb_combobox_target: "hidden"})
    end

    def search_input
      tag.input(
        type: "text",
        placeholder: @placeholder,
        disabled: @disabled,
        class: "flex h-9 w-full rounded-md border border-hw-input bg-hw-background px-3 text-sm text-hw-foreground ring-offset-hw-background placeholder:text-hw-muted-foreground focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-hw-ring focus-visible:ring-offset-2",
        data: {action: "input->hw-combobox#search focus->hw-combobox#open click@window->hw-combobox#close",
               rb_combobox_target: "input"},
        role: "combobox",
        aria: {expanded: false, autocomplete: "list"},
        **@extra_attrs
      )
    end

    def dropdown
      tag.div(
        class: "absolute z-50 mt-1 w-full rounded-md border border-hw-border bg-hw-popover shadow-md hidden",
        data: {rb_combobox_target: "dropdown"}
      ) do
        tag.ul(class: "max-h-60 overflow-auto p-1", role: "listbox") do
          safe_join(@options.map do |opt|
            value = opt.is_a?(Array) ? opt.last : opt
            label = opt.is_a?(Array) ? opt.first : opt
            tag.li(
              label,
              class: "relative flex cursor-pointer select-none items-center rounded-sm px-2 py-1.5 text-sm outline-none hover:bg-hw-accent hover:text-hw-accent-foreground",
              role: "option",
              data: {action: "click->hw-combobox#select", value: value}
            )
          end)
        end
      end
    end
  end
end
