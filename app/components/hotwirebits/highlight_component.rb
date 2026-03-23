# frozen_string_literal: true

module HotwireBits
  class HighlightComponent < Base
    def initialize(text:, query:, **attrs)
      @text = text
      @query = query
      @extra_attrs = attrs
    end

    def highlighted_text
      return ERB::Util.html_escape(@text) if @query.blank?

      escaped_text = ERB::Util.html_escape(@text)
      escaped_query = Regexp.escape(ERB::Util.html_escape(@query))

      escaped_text.gsub(/(#{escaped_query})/i,
                        '<mark class="bg-yellow-200 text-inherit rounded-sm px-0.5">\1</mark>').html_safe
    end
  end
end
