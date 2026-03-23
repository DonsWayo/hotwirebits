# frozen_string_literal: true

module HotwireBits
  class DataTableComponent < Base
    def initialize(columns:, rows:, sort_by: nil, sort_direction: :asc, current_page: nil, total_pages: nil, **attrs)
      @columns = columns
      @rows = rows
      @sort_by = sort_by
      @sort_direction = sort_direction
      @current_page = current_page
      @total_pages = total_pages
      @extra_attrs = attrs
    end

    def sort_icon(column_key)
      return unless @columns.find { |c| c[:key] == column_key }&.dig(:sortable)

      if @sort_by == column_key
        @sort_direction == :asc ? '↑' : '↓'
      else
        '↕'
      end
    end

    def next_sort_direction(column_key)
      if @sort_by == column_key && @sort_direction == :asc
        :desc
      else
        :asc
      end
    end

    def container_classes
      merge_classes(
        'rounded-lg border border-hw-border',
        @extra_attrs.delete(:class)
      )
    end
  end
end
