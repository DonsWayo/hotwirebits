# frozen_string_literal: true

module HotwireBits
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
      merge_classes(@variant == :enclosed ? 'rounded-md border border-hw-border p-1' : nil)
    end

    def list_classes
      base = 'flex'
      base += ' gap-1' if @variant == :pill || @variant == :enclosed
      base += ' border-b border-hw-border' if @variant == :underline
      merge_classes(base)
    end

    def tab_classes(active)
      base = 'inline-flex items-center justify-center gap-2 whitespace-nowrap rounded-md px-3 py-2 text-sm font-medium transition-colors cursor-pointer focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-hw-ring'

      case @variant
      when :underline
        merge_classes(base, ' -mb-px border-b-2',
                      active ? 'border-hw-primary text-hw-foreground' : 'border-transparent text-hw-muted-foreground hover:text-hw-foreground hover:border-hw-border')
      when :pill
        merge_classes(base,
                      active ? 'bg-hw-primary text-hw-primary-foreground' : 'text-hw-muted-foreground hover:bg-hw-accent hover:text-hw-accent-foreground')
      when :enclosed
        merge_classes(base,
                      active ? 'bg-hw-background text-hw-foreground shadow-sm' : 'text-hw-muted-foreground hover:text-hw-foreground')
      end
    end
  end
end
