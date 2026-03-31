# frozen_string_literal: true

module HotwireBits
  class SearchInputComponent < Base
    def initialize(name: "q", value: nil, placeholder: "Search...", size: :md, with_button: false,
      button_label: "Search", disabled: false, **attrs)
      @name = name
      @value = value
      @placeholder = placeholder
      @size = size
      @with_button = with_button
      @button_label = button_label
      @disabled = disabled
      @extra_attrs = attrs
    end

    private

    def input_classes
      sizes = {sm: "h-8 pl-8 pr-8 text-xs", md: "h-9 pl-9 pr-9 text-sm", lg: "h-10 pl-10 pr-10 text-base"}
      merge_classes(
        "flex w-full rounded-md border border-hw-input bg-hw-background text-hw-foreground",
        "ring-offset-hw-background placeholder:text-hw-muted-foreground",
        "focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-hw-ring focus-visible:ring-offset-2",
        "disabled:cursor-not-allowed disabled:opacity-50",
        sizes[@size] || sizes[:md]
      )
    end

    def search_icon
      icon_size = {sm: "h-3 w-3 left-2.5", md: "h-4 w-4 left-3", lg: "h-5 w-5 left-3.5"}[@size] || "h-4 w-4 left-3"
      tag.div(class: merge_classes("absolute top-1/2 -translate-y-1/2 text-hw-muted-foreground",
        icon_size.split(" ").last)) do
        tag.svg(class: icon_size.split(" ")[0..1].join(" "), fill: "none", stroke: "currentColor", stroke_width: "2",
          viewBox: "0 0 24 24") do
          tag.path(stroke_linecap: "round", stroke_linejoin: "round", d: "M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z")
        end
      end
    end

    def clear_button
      tag.button(type: "button",
        class: "absolute right-2 top-1/2 -translate-y-1/2 text-hw-muted-foreground hover:text-hw-foreground") do
        tag.svg(class: "h-4 w-4", fill: "none", stroke: "currentColor", stroke_width: "2", viewBox: "0 0 24 24") do
          tag.path(stroke_linecap: "round", stroke_linejoin: "round", d: "M6 18L18 6M6 6l12 12")
        end
      end
    end
  end
end
