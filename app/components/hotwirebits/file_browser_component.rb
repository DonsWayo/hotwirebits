# frozen_string_literal: true

module HotwireBits
  class FileBrowserComponent < Base
    def initialize(files: [], selected: nil, **attrs)
      @files = files
      @selected = selected
      @extra_attrs = attrs
    end
  end
end
