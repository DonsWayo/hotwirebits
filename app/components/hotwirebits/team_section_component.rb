# frozen_string_literal: true

module HotwireBits
  class TeamSectionComponent < Base
    def initialize(title: nil, members: [], columns: 3, **attrs)
      @title = title
      @members = members
      @columns = [columns, 4].min
      @extra_attrs = attrs
    end

    def container_classes
      merge_classes('py-16 md:py-24 px-4', @extra_attrs.delete(:class))
    end

    def grid_classes
      "grid gap-8 grid-cols-1 sm:grid-cols-2 lg:grid-cols-#{@columns}"
    end
  end
end
