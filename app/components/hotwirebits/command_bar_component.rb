# frozen_string_literal: true

module HotwireBits
  class CommandBarComponent < Base
    def initialize(commands: [], placeholder: "Type a command or search...", **attrs)
      @commands = commands
      @placeholder = placeholder
      @extra_attrs = attrs
    end
  end
end
