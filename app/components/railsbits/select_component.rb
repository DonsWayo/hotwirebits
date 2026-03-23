# frozen_string_literal: true

module RailsBits
  class SelectComponent < Base
    SIZES = {
      sm: 'h-8 px-3 text-xs',
      md: 'h-9 px-3 text-sm',
      lg: 'h-10 px-4 text-base'
    }.freeze

    def initialize(name: nil, options: [], selected: nil, placeholder: 'Select...', size: :md, disabled: false,
                   multiple: false, error: false, **attrs)
      @name = name
      @options = options
      @selected = selected
      @placeholder = placeholder
      @size = size
      @disabled = disabled
      @multiple = multiple
      @error = error
      @extra_attrs = attrs
    end

    def call
      tag.select(class: select_classes, name: @name, disabled: @disabled, multiple: @multiple, **@extra_attrs) do
        safe_join([
                    tag.option(@placeholder, value: '', disabled: true, selected: @selected.nil?),
                    *@options.map do |opt|
                      if opt.is_a?(Array)
                        tag.option(opt.first, value: opt.last, selected: Array(@selected).include?(opt.last))
                      elsif opt.is_a?(Hash)
                        tag.optgroup(label: opt[:label]) do
                          safe_join(opt[:options].map do |o|
                            tag.option(o.first, value: o.last, selected: Array(@selected).include?(o.last))
                          end)
                        end
                      else
                        tag.option(opt, value: opt, selected: Array(@selected).include?(opt))
                      end
                    end
                  ])
      end
    end

    private

    def select_classes
      error_classes = @error ? 'border-rb-destructive focus-visible:ring-rb-destructive' : 'border-rb-input focus-visible:ring-rb-ring'
      merge_classes(
        'flex w-full rounded-md border bg-rb-background text-rb-foreground ring-offset-rb-background',
        'placeholder:text-rb-muted-foreground focus-visible:outline-none focus-visible:ring-2',
        'focus-visible:ring-offset-2 disabled:cursor-not-allowed disabled:opacity-50',
        "appearance-none bg-[url('data:image/svg+xml;charset=utf-8,%3Csvg%20xmlns%3D%22http%3A%2F%2Fwww.w3.org%2F2000%2Fsvg%22%20fill%3D%22none%22%20viewBox%3D%220%200%2024%2024%22%20stroke-width%3D%221.5%22%20stroke%3D%22currentColor%22%3E%3Cpath%20stroke-linecap%3D%22round%22%20stroke-linejoin%3D%22round%22%20d%3D%22m19.5%208.25-7.5%207.5-7.5-7.5%22%20%2F%3E%3C%2Fsvg%3E')] bg-[length:1rem] bg-[right_0.5rem_center] bg-no-repeat pr-8",
        error_classes,
        SIZES[@size] || SIZES[:md]
      )
    end
  end
end
