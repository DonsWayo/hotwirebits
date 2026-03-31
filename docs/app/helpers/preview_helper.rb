# frozen_string_literal: true

module PreviewHelper
  def rb_preview(component_slug, props = {})
    class_name = component_slug.to_s.gsub('-', '_').split('_').map(&:capitalize).join
    file_name = component_slug.to_s.gsub('-', '_')
    components_dir = Rails.root.join('..', 'app', 'components', 'hotwirebits')
    component_file = components_dir.join("#{file_name}_component.rb")

    # Load Base class first if not loaded
    unless defined?(HotwireBits::Base)
      base_file = components_dir.join('base.rb')
      require base_file.to_s if File.exist?(base_file)
    end

    unless File.exist?(component_file)
      return tag.div(class: 'hw-preview') do
        tag.span('Preview', style: 'color: var(--color-hw-muted-foreground); font-size: 0.75rem')
      end
    end

    begin
      full_class = "HotwireBits::#{class_name}Component"
      component_class = full_class.safe_constantize

      # Load the file if class not yet loaded
      unless component_class
        require component_file.to_s
        component_class = full_class.safe_constantize
      end

      unless component_class
        return tag.div(class: 'hw-preview') do
          tag.span(class_name, style: 'color: var(--color-hw-muted-foreground); font-size: 0.75rem')
        end
      end

      safe_props = (props || {}).respond_to?(:symbolize_keys) ? props.symbolize_keys : (props || {})
      render(component_class.new(**safe_props))
    rescue StandardError => e
      tag.div(class: 'hw-preview') do
        tag.div do
          safe_join([
                      tag.p(class_name, style: 'font-size: 0.875rem; font-weight: 500; color: var(--color-hw-foreground)'),
                      tag.p(e.message[0..120],
                            style: 'font-size: 0.75rem; color: var(--color-hw-muted-foreground); margin-top: 0.25rem')
                    ])
        end
      end
    end
  end

  def rb_props_table(props)
    return '' if props.blank?

    tag.div(class: 'hw-props-table') do
      tag.table do
        safe_join([
                    tag.thead do
                      tag.tr do
                        safe_join([tag.th('Prop'), tag.th('Type'), tag.th('Default'), tag.th('Required')])
                      end
                    end,
                    tag.tbody do
                      safe_join(props.map do |p|
                        tag.tr do
                          safe_join([
                                      tag.td(tag.code(p['name'])),
                                      tag.td(tag.code(p['type']), style: 'color: var(--color-hw-muted-foreground)'),
                                      tag.td(p['default'] || 'nil', style: 'color: var(--color-hw-muted-foreground)'),
                                      tag.td(p['required'] ? 'Yes' : 'No',
                                             style: p['required'] ? 'color: var(--color-hw-destructive)' : 'color: var(--color-hw-muted-foreground)')
                                    ])
                        end
                      end)
                    end
                  ])
      end
    end
  end
end
