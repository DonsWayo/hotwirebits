# frozen_string_literal: true

module HotwireBits
  class NewsletterSectionComponent < Base
    def initialize(title: "Subscribe to our newsletter", description: nil, placeholder: "Enter your email",
      button_label: "Subscribe", privacy_note: nil, **attrs)
      @title = title
      @description = description
      @placeholder = placeholder
      @button_label = button_label
      @privacy_note = privacy_note
      @extra_attrs = attrs
    end
  end
end
