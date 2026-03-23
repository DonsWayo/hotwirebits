# frozen_string_literal: true

module RailsBits
  class TabsComponent < Base
    VARIANTS = {
      underline: :underline,
      pill: :pill,
      enclosed: :enclosed
    }.freeze

    renders_many :tab_contents, lambda { |id:, **attrs, &block|
      TabContent.new(id: id, **attrs, &block)
    }

    class TabContent < Base
      def initialize(id:, **attrs)
        @id = id
        @extra_attrs = attrs
      end
    end

    def initialize(tabs: [], variant: :underline, active_tab: nil, **attrs)
      @tabs = tabs
      @variant = variant
      @active_tab = active_tab || tabs.first&.dig(:id)
      @extra_attrs = attrs
    end

    private

    def container_classes
      merge_classes(@variant == :enclosed ? 'rounded-md border border-rb-border p-1' : nil)
    end

    def list_classes
      base = 'flex'
      base += ' gap-1' if @variant == :pill || @variant == :enclosed
      base += ' border-b border-rb-border' if @variant == :underline
      merge_classes(base)
    end

    def tab_classes(active)
      base = 'inline-flex items-center justify-center gap-2 whitespace-nowrap rounded-md px-3 py-2 text-sm font-medium transition-colors cursor-pointer focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-rb-ring'

      case @variant
      when :underline
        merge_classes(base, ' -mb-px border-b-2',
                      active ? 'border-rb-primary text-rb-foreground' : 'border-transparent text-rb-muted-foreground hover:text-rb-foreground hover:border-rb-border')
      when :pill
        merge_classes(base,
                      active ? 'bg-rb-primary text-rb-primary-foreground' : 'text-rb-muted-foreground hover:bg-rb-accent hover:text-rb-accent-foreground')
      when :enclosed
        merge_classes(base,
                      active ? 'bg-rb-background text-rb-foreground shadow-sm' : 'text-rb-muted-foreground hover:text-rb-foreground')
      end
    end
  end
end
