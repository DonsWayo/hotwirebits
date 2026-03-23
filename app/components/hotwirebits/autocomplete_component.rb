# frozen_string_literal: true

module HotwireBits
  class AutocompleteComponent < Base
    def initialize(name:, url:, placeholder: 'Search...', min_chars: 2, value: nil, disabled: false, **attrs)
      @name = name
      @url = url
      @placeholder = placeholder
      @min_chars = min_chars
      @value = value
      @disabled = disabled
      @extra_attrs = attrs
    end

    def call
      tag.div(
        class: 'relative',
        data: {
          controller: 'hw-autocomplete',
          rb_autocomplete_url_value: @url,
          rb_autocomplete_min_chars_value: @min_chars
        },
        **@extra_attrs
      ) do
        safe_join([
                    input_element,
                    results_element,
                    tag.input(type: 'hidden', name: @name, value: @value, data: { rb_autocomplete_target: 'hidden' })
                  ])
      end
    end

    private

    def input_element
      tag.input(
        type: 'text',
        placeholder: @placeholder,
        value: @value,
        disabled: @disabled,
        class: merge_classes(
          'flex w-full rounded-md border border-hw-input bg-hw-background px-3 py-2 text-sm text-hw-foreground',
          'ring-offset-hw-background placeholder:text-hw-muted-foreground',
          'focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-hw-ring focus-visible:ring-offset-2',
          'disabled:cursor-not-allowed disabled:opacity-50'
        ),
        autocomplete: 'off',
        data: {
          rb_autocomplete_target: 'input',
          action: 'input->hw-autocomplete#search keydown->hw-autocomplete#keydown'
        }
      )
    end

    def results_element
      tag.ul(
        class: 'absolute z-50 mt-1 max-h-60 w-full overflow-auto rounded-md border border-hw-border bg-hw-popover shadow-md hidden',
        role: 'listbox',
        data: { rb_autocomplete_target: 'results' }
      )
    end
  end
end
