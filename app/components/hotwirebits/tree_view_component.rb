# frozen_string_literal: true

module HotwireBits
  class TreeViewComponent < Base
    def initialize(items: [], **attrs)
      @items = items
      @extra_attrs = attrs
    end

    def container_classes
      merge_classes(
        "space-y-0.5",
        @extra_attrs.delete(:class)
      )
    end

    def icon_for(item)
      return unless item[:children]&.any?

      item.fetch(:expanded, true) ? "▾" : "▸"
    end

    def render_node(item)
      has_children = item[:children]&.any?
      label = ERB::Util.html_escape(item[:label].to_s)
      icon_html = item[:icon] ? "<span class=\"h-4 w-4 shrink-0 text-hw-muted-foreground\">#{ERB::Util.html_escape(item[:icon].to_s)}</span>" : ""
      chevron = has_children ? "<span class=\"text-hw-muted-foreground\">#{icon_for(item)}</span>" : ""
      children_html = (has_children && item.fetch(:expanded, true)) ? render_children(item[:children]) : ""
      <<~HTML.html_safe
        <li class="list-none">
          <div class="flex items-center gap-1.5 px-2 py-1 rounded-md hover:bg-hw-muted cursor-pointer text-sm"
               data-action="click->hw-tree#toggle">
            #{chevron}
            #{icon_html}
            <span>#{label}</span>
          </div>
          #{children_html}
        </li>
      HTML
    end

    def render_children(children)
      items = children.map { |child| render_node(child) }.join
      "<ul class=\"list-none pl-4\" data-hw-tree-target=\"content\">#{items}</ul>"
    end
  end
end
