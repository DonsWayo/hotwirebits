# frozen_string_literal: true

module HotwireBits
  class PaginatorComponent < Base
    MAX_VISIBLE = 5

    def initialize(current_page: 1, total_pages: 1, per_page: 20, total_items: 0, rows_options: [10, 20, 50, 100],
      path: nil, **attrs)
      @current_page = current_page.to_i
      @total_pages = total_pages.to_i
      @per_page = per_page.to_i
      @total_items = total_items.to_i
      @rows_options = rows_options
      @path = path
      @extra_attrs = attrs
    end

    def page_url(page)
      return "#" unless @path

      @path.is_a?(Proc) ? @path.call(page) : "#{@path}?page=#{page}&per_page=#{@per_page}"
    end

    def pages
      return (1..@total_pages).to_a if @total_pages <= MAX_VISIBLE + 2

      list = [1]
      start = [@current_page - 1, 2].max
      finish = [@current_page + 1, @total_pages - 1].min

      list << :gap if start > 2
      list.concat((start..finish).to_a)
      list << :gap if finish < @total_pages - 1
      list << @total_pages if @total_pages > 1
      list
    end

    def range_text
      from = [(@current_page - 1) * @per_page + 1, @total_items].min
      to = [@current_page * @per_page, @total_items].min
      "#{from}\u2013#{to} of #{@total_items}"
    end
  end
end
