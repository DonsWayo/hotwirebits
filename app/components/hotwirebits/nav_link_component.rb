# frozen_string_literal: true

module HotwireBits
  class NavLinkComponent < Base
    def initialize(label: nil, href: nil, icon: nil, active: false, badge: nil, **attrs)
      @label = label
      @href = href
      @icon = icon
      @active = active
      @badge = badge
      @extra_attrs = attrs
    end

    private

    def link_classes
      merge_classes(
        "group flex items-center gap-3 rounded-md px-3 py-2 text-sm transition-colors",
        @active ? "bg-hw-accent text-hw-accent-foreground font-medium" : "text-hw-muted-foreground hover:bg-hw-accent/50 hover:text-hw-accent-foreground"
      )
    end
  end
end
