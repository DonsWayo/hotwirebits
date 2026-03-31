# frozen_string_literal: true

module HotwireBits
  class PanelComponent < Base
    renders_one :actions

    def initialize(title: nil, collapsed: false, **attrs)
      @title = title
      @collapsed = collapsed
      @extra_attrs = attrs
    end

    private

    def header_element
      tag.div(class: "flex items-center justify-between px-4 py-3") do
        safe_join([
          tag.button(
            type: "button",
            class: "flex items-center gap-2 text-sm font-medium text-hw-foreground hover:text-hw-foreground/80",
            data: {action: "click->hw-panel#toggle"}
          ) do
            safe_join([
              tag.svg(
                class: merge_classes("h-4 w-4 shrink-0 transition-transform duration-200", @collapsed ? "" : "rotate-90"),
                data: {rb_panel_target: "chevron"},
                fill: "none", stroke: "currentColor", stroke_width: "2", viewBox: "0 0 24 24"
              ) do
                tag.path(stroke_linecap: "round", stroke_linejoin: "round", d: "M9 5l7 7-7 7")
              end,
              tag.span(@title)
            ])
          end,
          (tag.div(class: "flex items-center gap-1") { actions } if actions?)
        ])
      end
    end

    def content_element
      tag.div(
        class: merge_classes("px-4 pb-4", @collapsed ? "hidden" : ""),
        data: {rb_panel_target: "content"}
      ) do
        content
      end
    end
  end
end
