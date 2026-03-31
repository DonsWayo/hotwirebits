# frozen_string_literal: true

module HotwireBits
  class SelectComponent < Base
    SIZES = {
      sm: "h-8 px-3 text-xs",
      md: "h-9 px-3 text-sm",
      lg: "h-10 px-4 text-base"
    }.freeze

    def initialize(name: nil, options: [], selected: nil, placeholder: "Select...", size: :md, disabled: false,
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

    private

    def select_classes
      error_classes = @error ? "border-hw-destructive focus-visible:ring-hw-destructive" : "border-hw-input focus-visible:ring-hw-ring"
      merge_classes(
        "flex w-full rounded-md border bg-hw-background text-hw-foreground ring-offset-hw-background",
        "placeholder:text-hw-muted-foreground focus-visible:outline-none focus-visible:ring-2",
        "focus-visible:ring-offset-2 disabled:cursor-not-allowed disabled:opacity-50",
        "appearance-none bg-[url('data:image/svg+xml;charset=utf-8,%3Csvg%20xmlns%3D%22http%3A%2F%2Fwww.w3.org%2F2000%2Fsvg%22%20fill%3D%22none%22%20viewBox%3D%220%200%2024%2024%22%20stroke-width%3D%221.5%22%20stroke%3D%22currentColor%22%3E%3Cpath%20stroke-linecap%3D%22round%22%20stroke-linejoin%3D%22round%22%20d%3D%22m19.5%208.25-7.5%207.5-7.5-7.5%22%20%2F%3E%3C%2Fsvg%3E')] bg-[length:1rem] bg-[right_0.5rem_center] bg-no-repeat pr-8",
        error_classes,
        SIZES[@size] || SIZES[:md]
      )
    end
  end
end
