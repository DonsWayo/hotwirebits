# frozen_string_literal: true

module HotwireBits
  class ToolbarComponent < Base
    def initialize(items: [], with_separator: false, **attrs)
      @items = items
      @with_separator = with_separator
      @extra_attrs = attrs
    end

    private

    def toolbar_classes
      merge_classes(
        'inline-flex items-center rounded-md border border-hw-input bg-hw-background p-1 gap-0.5'
      )
    end

    def item_element(item, index)
      content = safe_join([
        (tag.span(class: 'h-4 w-4 shrink-0') { safe_svg(item[:icon]) } if item[:icon]),
        (tag.span(item[:label], class: 'text-sm') if item[:label])
      ].compact)

      inner = if item[:href]
                tag.a(href: item[:href], class: item_classes, title: item[:label]) { content }
              else
                tag.button(type: 'button', class: item_classes, title: item[:label]) { content }
              end

      if @with_separator && index > 0
        safe_join([separator_element, inner])
      else
        inner
      end
    end

    def item_classes
      merge_classes(
        'inline-flex items-center gap-1.5 rounded-sm px-2 py-1.5 text-sm text-hw-muted-foreground',
        'hover:bg-hw-accent hover:text-hw-accent-foreground transition-colors',
        'focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-hw-ring'
      )
    end

    def separator_element
      tag.div(class: 'mx-1 h-4 w-px bg-hw-border', role: 'separator')
    end
  end
end
