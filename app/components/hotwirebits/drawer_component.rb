# frozen_string_literal: true

module HotwireBits
  class DrawerComponent < Base
    renders_one :header
    renders_one :footer

    def initialize(title: nil, snap_points: [0.5, 1], open: false, **attrs)
      @title = title
      @snap_points = snap_points
      @open = open
      @extra_attrs = attrs
    end

    private

    def snap_points_data
      @snap_points.join(",")
    end
  end
end
