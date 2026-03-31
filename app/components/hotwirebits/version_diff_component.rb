# frozen_string_literal: true

module HotwireBits
  class VersionDiffComponent < Base
    VIEWS = %i[side_by_side unified].freeze

    def initialize(old_text:, new_text:, view: :side_by_side, **attrs)
      @old_text = old_text
      @new_text = new_text
      @view = VIEWS.include?(view) ? view : :side_by_side
      @extra_attrs = attrs
    end

    def container_classes
      merge_classes("rounded-lg border border-hw-border overflow-hidden text-sm font-mono", @extra_attrs.delete(:class))
    end

    private

    def diff_lines
      old_lines = @old_text.to_s.lines
      new_lines = @new_text.to_s.lines
      max = [old_lines.size, new_lines.size].max
      result = []
      max.times do |i|
        ol = old_lines[i]
        nl = new_lines[i]
        if ol == nl
          result << {type: :context, old_line: i + 1, new_line: i + 1, content: ol&.chomp}
        else
          result << {type: :removed, old_line: i + 1, content: ol&.chomp} if ol
          result << {type: :added, new_line: i + 1, content: nl&.chomp} if nl
        end
      end
      result
    end
  end
end
