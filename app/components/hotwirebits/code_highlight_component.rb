# frozen_string_literal: true

module HotwireBits
  class CodeHighlightComponent < Base
    def initialize(code:, language: "text", theme: :light, line_numbers: false, **attrs)
      @code = code
      @language = language
      @theme = theme
      @line_numbers = line_numbers
      @extra_attrs = attrs
    end

    def container_classes
      merge_classes(
        "rounded-lg border border-hw-border overflow-hidden",
        theme_classes,
        @extra_attrs.delete(:class)
      )
    end

    def theme_classes
      case @theme
      when :dark then "bg-gray-950 text-gray-100"
      else "bg-hw-background text-hw-foreground"
      end
    end

    def lines
      @code.to_s.split("\n")
    end
  end
end
