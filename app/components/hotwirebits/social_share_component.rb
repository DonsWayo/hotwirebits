# frozen_string_literal: true

module HotwireBits
  class SocialShareComponent < Base
    PLATFORMS = %i[twitter facebook linkedin email].freeze

    def initialize(url:, title: nil, platforms: %i[twitter facebook linkedin email], **attrs)
      @url = url
      @title = title
      @platforms = platforms & PLATFORMS
      @extra_attrs = attrs
    end

    def share_url(platform)
      encoded_url = ERB::Util.url_encode(@url)
      encoded_title = ERB::Util.url_encode(@title.to_s)
      case platform
      when :twitter then "https://twitter.com/intent/tweet?url=#{encoded_url}&text=#{encoded_title}"
      when :facebook then "https://www.facebook.com/sharer/sharer.php?u=#{encoded_url}"
      when :linkedin then "https://www.linkedin.com/sharing/share-offsite/?url=#{encoded_url}"
      when :mailto then "mailto:?subject=#{encoded_title}&body=#{encoded_url}"
      end
    end
  end
end
