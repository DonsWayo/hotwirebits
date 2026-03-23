# frozen_string_literal: true

module HotwireBits
  class FileInputComponent < Base
    def initialize(name: nil, accept: nil, multiple: false, disabled: false, label: 'Choose file', **attrs)
      @name = name
      @accept = accept
      @multiple = multiple
      @disabled = disabled
      @label = label
      @extra_attrs = attrs
    end

    def call
      tag.label(class: label_classes) do
        safe_join([
                    tag.input(
                      type: 'file',
                      name: @name,
                      accept: @accept,
                      multiple: @multiple,
                      disabled: @disabled,
                      class: 'sr-only',
                      **@extra_attrs
                    ),
                    tag.span(class: 'flex items-center gap-2') do
                      safe_join([
                                  tag.svg(class: 'h-4 w-4 text-hw-muted-foreground', fill: 'none', stroke: 'currentColor',
                                          stroke_width: '2', viewBox: '0 0 24 24') do
                                    tag.path(stroke_linecap: 'round', stroke_linejoin: 'round',
                                             d: 'M7 16a4 4 0 01-.88-7.903A5 5 0 1115.9 6L16 6a5 5 0 011 9.9M15 13l-3-3m0 0l-3 3m3-3v12')
                                  end,
                                  tag.span(@label, class: 'text-sm')
                                ])
                    end
                  ])
      end
    end

    private

    def label_classes
      merge_classes(
        'flex h-9 items-center justify-center rounded-md border border-dashed border-hw-input',
        'bg-hw-background px-3 text-sm text-hw-muted-foreground ring-offset-hw-background',
        'hover:bg-hw-accent hover:text-hw-accent-foreground cursor-pointer',
        'disabled:cursor-not-allowed disabled:opacity-50'
      )
    end
  end
end
