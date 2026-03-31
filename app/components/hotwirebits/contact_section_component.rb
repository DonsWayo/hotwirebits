# frozen_string_literal: true

module HotwireBits
  class ContactSectionComponent < Base
    def initialize(title:, description: nil, fields: [], submit_label: "Submit", **attrs)
      @title = title
      @description = description
      @fields = fields
      @submit_label = submit_label
      @extra_attrs = attrs
    end

    def container_classes
      merge_classes("py-16 md:py-24 px-4", @extra_attrs.delete(:class))
    end
  end
end
