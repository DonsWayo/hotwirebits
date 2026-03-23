# frozen_string_literal: true

module RailsBits
  class NativeSelectComponent < Base
    def initialize(name: nil, options: [], selected: nil, placeholder: 'Select...', disabled: false, **attrs)
      @name = name
      @options = options
      @selected = selected
      @placeholder = placeholder
      @disabled = disabled
      @extra_attrs = attrs
    end

    def call
      tag.select(class: select_classes, name: @name, disabled: @disabled, **@extra_attrs) do
        safe_join([
                    tag.option(@placeholder, value: '', disabled: true, selected: @selected.nil?),
                    *@options.map do |opt|
                      if opt.is_a?(Array)
                        tag.option(opt.first, value: opt.last, selected: @selected == opt.last)
                      else
                        tag.option(opt, value: opt, selected: @selected == opt)
                      end
                    end
                  ])
      end
    end

    private

    def select_classes
      'h-9 w-full rounded-md border border-rb-input bg-rb-background px-3 text-sm text-rb-foreground ring-offset-rb-background focus:outline-none focus:ring-2 focus:ring-rb-ring focus:ring-offset-2 disabled:cursor-not-allowed disabled:opacity-50'
    end
  end
end
