# frozen_string_literal: true

module HotwireBits
  class DataViewComponent < Base
    renders_many :items

    def initialize(view: :grid, sort_by: nil, per_page: 12, **attrs)
      @view = view
      @sort_by = sort_by
      @per_page = per_page
      @extra_attrs = attrs
    end

    def call
      tag.div(class: 'space-y-4', data: { controller: 'hw-data-view' }, **@extra_attrs) do
        safe_join([
                    toolbar_element,
                    content_element
                  ])
      end
    end

    private

    def toolbar_element
      tag.div(class: 'flex items-center justify-between') do
        safe_join([
                    sort_element,
                    view_toggle_element
                  ])
      end
    end

    def sort_element
      tag.div(class: 'flex items-center gap-2') do
        tag.span('Sort:', class: 'text-sm text-hw-muted-foreground') +
          tag.span(@sort_by || 'Default', class: 'text-sm font-medium text-hw-foreground')
      end
    end

    def view_toggle_element
      tag.div(class: 'inline-flex rounded-md border border-hw-input') do
        safe_join([
                    toggle_button(:grid, true, grid_icon),
                    toggle_button(:list, false, list_icon)
                  ])
      end
    end

    def toggle_button(view, first, icon)
      tag.button(
        type: 'button',
        class: merge_classes(
          'inline-flex items-center justify-center h-8 w-8 transition-colors',
          first ? 'rounded-l-md' : 'rounded-r-md -ml-px',
          @view == view ? 'bg-hw-accent text-hw-accent-foreground' : 'bg-transparent text-hw-muted-foreground hover:bg-hw-accent hover:text-hw-accent-foreground'
        ),
        data: { action: 'click->hw-data-view#switch', view: view }
      ) do
        icon
      end
    end

    def content_element
      grid = @view == :grid
      tag.div(class: grid ? 'grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-4' : 'space-y-2',
              data: { rb_data_view_target: 'content' }) do
        safe_join(items)
      end
    end

    def grid_icon
      tag.svg(class: 'h-4 w-4', fill: 'none', stroke: 'currentColor', stroke_width: '2', viewBox: '0 0 24 24') do
        tag.path(stroke_linecap: 'round', stroke_linejoin: 'round',
                 d: 'M4 6a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2H6a2 2 0 01-2-2V6zM14 6a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2h-2a2 2 0 01-2-2V6zM4 16a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2H6a2 2 0 01-2-2v-2zM14 16a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2h-2a2 2 0 01-2-2v-2z')
      end
    end

    def list_icon
      tag.svg(class: 'h-4 w-4', fill: 'none', stroke: 'currentColor', stroke_width: '2', viewBox: '0 0 24 24') do
        tag.path(stroke_linecap: 'round', stroke_linejoin: 'round', d: 'M4 6h16M4 12h16M4 18h16')
      end
    end
  end
end
