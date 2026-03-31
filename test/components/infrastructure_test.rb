# frozen_string_literal: true

require "test_helper"

class BaseComponentTest < ActionView::TestCase
  test "Base inherits from ViewComponent::Base" do
    assert HotwireBits::Base < ViewComponent::Base
  end

  test "Base has private merge_classes method" do
    component = HotwireBits::Base.new
    assert component.respond_to?(:merge_classes, true)
  end

  test "merge_classes joins classes and handles nils" do
    component = Class.new(HotwireBits::Base) do
      def test_merge(*args)
        merge_classes(*args)
      end
    end.new

    assert_equal "a b c", component.test_merge("a", "b", "c")
    assert_equal "a b", component.test_merge("a", nil, "b")
    assert_equal "a b", component.test_merge("a", "", "b")
    assert_equal "", component.test_merge(nil, nil)
  end
end

class EngineTest < ActionView::TestCase
  test "engine is a Rails::Engine" do
    assert HotwireBits::Engine < Rails::Engine
  end

  test "engine has helpers initializer" do
    initializers = HotwireBits::Engine.initializers.map(&:name)
    assert_includes initializers, "hotwirebits.helpers"
  end

  test "engine has assets initializer" do
    initializers = HotwireBits::Engine.initializers.map(&:name)
    assert_includes initializers, "hotwirebits.assets"
  end
end

class VersionTest < ActionView::TestCase
  test "version is defined" do
    assert HotwireBits::VERSION.present?
    assert_match(/\A\d+\.\d+\.\d+\z/, HotwireBits::VERSION)
  end

  test "version is 0.1.0" do
    assert_equal "0.1.0", HotwireBits::VERSION
  end
end

class ThemeCssTest < ActionView::TestCase
  test "theme.css defines all required color variables" do
    theme_path = File.join(HotwireBits::Engine.root, "app", "assets", "stylesheets", "hotwirebits", "theme.css")
    theme = File.read(theme_path)

    %w[
      --color-hw-background --color-hw-foreground
      --color-hw-primary --color-hw-primary-foreground
      --color-hw-secondary --color-hw-secondary-foreground
      --color-hw-muted --color-hw-muted-foreground
      --color-hw-accent --color-hw-accent-foreground
      --color-hw-destructive --color-hw-destructive-foreground
      --color-hw-success --color-hw-success-foreground
      --color-hw-warning --color-hw-warning-foreground
      --color-hw-info --color-hw-info-foreground
      --color-hw-border --color-hw-input --color-hw-ring
      --color-hw-bg --color-hw-fg
    ].each do |var|
      assert theme.include?(var), "Missing CSS variable: #{var}"
    end
  end

  test "theme.css has dark mode overrides" do
    theme_path = File.join(HotwireBits::Engine.root, "app", "assets", "stylesheets", "hotwirebits", "theme.css")
    theme = File.read(theme_path)

    assert theme.include?("prefers-color-scheme: dark"), "Missing dark mode media query"
    assert theme.include?(".dark"), "Missing .dark class overrides"
  end

  test "theme.css has radius variables" do
    theme_path = File.join(HotwireBits::Engine.root, "app", "assets", "stylesheets", "hotwirebits", "theme.css")
    theme = File.read(theme_path)

    assert theme.include?("--radius-hw-sm")
    assert theme.include?("--radius-hw-md")
    assert theme.include?("--radius-hw-lg")
    assert theme.include?("--radius-hw-xl")
  end

  test "corporate theme defines all variables" do
    theme_path = File.join(HotwireBits::Engine.root, "app", "assets", "stylesheets", "hotwirebits", "themes", "corporate.css")
    theme = File.read(theme_path)

    assert theme.include?("--color-hw-primary")
    assert theme.include?("--color-hw-background")
    assert theme.include?("--color-hw-destructive")
    assert theme.include?("--color-hw-success")
    assert theme.include?("--color-hw-warning")
  end

  test "midnight theme defines all variables" do
    theme_path = File.join(HotwireBits::Engine.root, "app", "assets", "stylesheets", "hotwirebits", "themes", "midnight.css")
    theme = File.read(theme_path)

    assert theme.include?("--color-hw-primary")
    assert theme.include?("--color-hw-background")
    assert theme.include?("--color-hw-destructive")
    assert theme.include?("--color-hw-success")
    assert theme.include?("--color-hw-ring")
  end
end

class StimulusIndexTest < ActionView::TestCase
  test "index.js imports and registers all controllers" do
    index_path = File.join(HotwireBits::Engine.root, "app", "javascript", "controllers", "hotwirebits", "index.js")
    index = File.read(index_path)

    import_count = index.scan(/^import /).length
    register_count = index.scan("application.register(").length

    assert import_count > 50, "Expected 50+ imports, got #{import_count}"
    assert_equal register_count, import_count - 1, "Registrations should match imports (minus application import)"
  end

  test "all registered controllers have JS files" do
    index_path = File.join(HotwireBits::Engine.root, "app", "javascript", "controllers", "hotwirebits", "index.js")
    index = File.read(index_path)
    js_dir = File.join(HotwireBits::Engine.root, "app", "javascript", "controllers", "hotwirebits")

    index.scan(/from ".*?(\w+_controller)"/).flatten.each do |filename|
      path = File.join(js_dir, "#{filename}.js")
      assert File.exist?(path), "Missing JS file: #{filename}.js"
    end
  end
end

class GemspecTest < ActionView::TestCase
  test "gemspec includes all runtime dependencies" do
    gemspec_path = File.join(HotwireBits::Engine.root, "hotwirebits.gemspec")
    gemspec = File.read(gemspec_path)

    assert gemspec.include?("rails")
    assert gemspec.include?("stimulus-rails")
    assert gemspec.include?("turbo-rails")
    assert gemspec.include?("view_component")
    assert gemspec.include?("tailwindcss-rails")
  end

  test "gemspec has correct name" do
    assert_equal "hotwirebits", Gem::Specification.load(File.join(HotwireBits::Engine.root, "hotwirebits.gemspec")).name
  end
end
