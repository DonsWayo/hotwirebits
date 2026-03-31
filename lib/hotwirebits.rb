# frozen_string_literal: true

require "rails"
require "view_component"
require "turbo-rails"
require "stimulus-rails"

require_relative "hotwirebits/version"
require_relative "hotwirebits/engine"

module HotwireBits
  # HotwireBits - The most comprehensive free UI component library for Ruby on Rails
  #
  # Each component ships in two formats:
  #   - ERB partials (copy-paste friendly)
  #   - ViewComponent classes (Ruby-first)
  #
  # All styled with Tailwind CSS v4, interactive via Stimulus, Turbo-compatible.
end
