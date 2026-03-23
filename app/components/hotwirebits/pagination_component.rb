# frozen_string_literal: true

module HotwireBits
  class PaginationComponent < Base
    MAX_VISIBLE = 5

    def initialize(current_page:, total_pages:, path:, **attrs)
      @current_page = current_page.to_i
      @total_pages = total_pages.to_i
      @path = path
      @extra_attrs = attrs
    end

    def page_url(page)
      @path.is_a?(Proc) ? @path.call(page) : "#{@path}?page=#{page}"
    end

    def pages
      return (1..@total_pages).to_a if @total_pages <= MAX_VISIBLE + 2

      pages = [1]
      start = [@current_page - 1, 2].max
      finish = [@current_page + 1, @total_pages - 1].min

      pages << :gap if start > 2
      pages.concat((start..finish).to_a)
      pages << :gap if finish < @total_pages - 1
      pages << @total_pages if @total_pages > 1
      pages
    end
  end
end
