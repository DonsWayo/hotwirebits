# frozen_string_literal: true

require_relative "lib/hotwirebits/version"

Gem::Specification.new do |spec|
  spec.name = "hotwirebits"
  spec.version = HotwireBits::VERSION
  spec.authors = ["HotwireBits Contributors"]
  spec.email = ["hello@hotwirebits.dev"]

  spec.summary = "The most comprehensive free UI component library for Ruby on Rails"
  spec.description = "HotwireBits provides 240+ beautifully designed, accessible UI components for Ruby on Rails. " \
                     "Each component ships in ERB partial and ViewComponent formats with Tailwind CSS v4 styling, " \
                     "Stimulus interactivity, and Turbo compatibility including Turbo Native."
  spec.homepage = "https://hotwirebits.dev"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.4.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/hotwirebits/hotwirebits"
  spec.metadata["changelog_uri"] = "https://github.com/hotwirebits/hotwirebits/blob/main/CHANGELOG.md"

  spec.files = Dir["lib/**/*", "app/**/*", "LICENSE", "README.md"]
  spec.require_paths = ["lib"]

  spec.add_dependency "rails", ">= 7.0"
  spec.add_dependency "stimulus-rails", ">= 1.0"
  spec.add_dependency "turbo-rails", ">= 1.0"
  spec.add_dependency "view_component", ">= 3.0"
  spec.add_dependency "tailwindcss-rails", ">= 3.0"

  spec.metadata["rubygems_mfa_required"] = "true"
end
