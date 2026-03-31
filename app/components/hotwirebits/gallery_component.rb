# frozen_string_literal: true

module HotwireBits
  class GalleryComponent < Base
    def initialize(images: [], columns: 3, gap: 4, with_lightbox: true, **attrs)
      @images = images
      @columns = columns
      @gap = gap
      @with_lightbox = with_lightbox
      @extra_attrs = attrs
    end

    def container_classes
      merge_classes(grid_classes, @extra_attrs.delete(:class))
    end

    private

    def grid_classes
      cols = case @columns
      when 2 then "grid-cols-2"
      when 4 then "grid-cols-2 md:grid-cols-4"
      when 5 then "grid-cols-2 md:grid-cols-3 lg:grid-cols-5"
      else "grid-cols-2 md:grid-cols-3"
      end
      "grid #{cols} gap-#{@gap}"
    end
  end
end
