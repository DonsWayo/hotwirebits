# frozen_string_literal: true

module PreviewHelper
  def rb_preview(component_name, props = {})
    component_class = "HotwireBits::#{component_name.to_s.camelize}Component".safe_constantize
    return tag.p("Component not found: #{component_name}", class: 'text-hw-muted-fg text-sm') unless component_class

    begin
      render(component_class.new(**props.symbolize_keys))
    rescue StandardError => e
      tag.div(class: 'p-4 rounded-lg border border-hw-border bg-hw-muted/50') do
        safe_join([
                    tag.p("Preview: #{component_name}", class: 'text-sm font-medium text-hw-fg mb-1'),
                    tag.p(e.message.truncate(100), class: 'text-xs text-hw-muted-fg')
                  ])
      end
    end
  end

  def rb_code_block(code, language: 'ruby', label: nil)
    tag.div(class: 'code-block-wrapper') do
      safe_join([
                  (tag.div(class: 'code-block-header') do
                    safe_join([
                      (tag.span(label, class: 'code-block-label') if label),
                      tag.span(language.upcase, class: 'code-block-lang'),
                      tag.button('Copy', class: 'code-block-copy',
                                         data: { controller: 'rb-docs-copy', action: 'click->rb-docs-copy#copy' })
                    ].compact)
                  end),
                  tag.pre(class: "code-block code-block-#{language}") do
                    tag.code(syntax_highlight(code, language))
                  end
                ])
    end
  end

  def rb_props_table(props)
    return '' if props.blank?

    tag.table(class: 'props-table') do
      safe_join([
                  tag.thead do
                    tag.tr do
                      safe_join([
                                  tag.th('Prop'),
                                  tag.th('Type'),
                                  tag.th('Default'),
                                  tag.th('Required')
                                ])
                    end
                  end,
                  tag.tbody do
                    safe_join(props.map do |p|
                      tag.tr do
                        safe_join([
                                    tag.td(tag.code(p['name']), class: 'font-mono'),
                                    tag.td(tag.code(p['type']), class: 'text-hw-muted-fg'),
                                    tag.td(p['default'] || 'nil', class: 'text-hw-muted-fg'),
                                    tag.td(p['required'] ? 'Yes' : 'No',
                                           class: p['required'] ? 'text-hw-destructive' : 'text-hw-muted-fg')
                                  ])
                      end
                    end)
                  end
                ])
    end
  end

  def rb_callout(type: :info, title: nil, &block)
    colors = {
      info: 'border-hw-info/30 bg-hw-info/10 text-hw-info',
      warning: 'border-hw-warning/30 bg-hw-warning/10 text-hw-warning',
      tip: 'border-hw-success/30 bg-hw-success/10 text-hw-success',
      danger: 'border-hw-destructive/30 bg-hw-destructive/10 text-hw-destructive'
    }

    tag.div(class: "rounded-lg border p-4 #{colors[type] || colors[:info]}") do
      safe_join([
        (tag.p(title, class: 'font-medium mb-1') if title),
        tag.div(class: 'text-sm', &block)
      ].compact)
    end
  end

  private

  def syntax_highlight(code, _language)
    code.to_s.html_safe
  end
end
