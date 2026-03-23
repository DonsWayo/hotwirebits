# frozen_string_literal: true

module RailsBits
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
        'group flex items-center gap-3 rounded-md px-3 py-2 text-sm transition-colors',
        @active ? 'bg-rb-accent text-rb-accent-foreground font-medium' : 'text-rb-muted-foreground hover:bg-rb-accent/50 hover:text-rb-accent-foreground'
      )
    end
  end
end
