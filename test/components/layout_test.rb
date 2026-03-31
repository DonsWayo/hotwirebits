# frozen_string_literal: true

require "test_helper"

class ContainerComponentTest < ViewComponent::TestCase
  test "renders container" do
    render_inline(HotwireBits::ContainerComponent.new) { "Content" }

    assert_text "Content"
    assert_selector "div"
  end

  test "renders container with size" do
    render_inline(HotwireBits::ContainerComponent.new(size: :lg)) { "Large container" }

    assert_text "Large container"
  end
end

class GridComponentTest < ViewComponent::TestCase
  test "renders grid" do
    render_inline(HotwireBits::GridComponent.new(columns: 3)) { "Grid content" }

    assert_text "Grid content"
  end
end

class FlexComponentTest < ViewComponent::TestCase
  test "renders flex" do
    render_inline(HotwireBits::FlexComponent.new) { "Flex content" }

    assert_text "Flex content"
  end

  test "renders flex column" do
    render_inline(HotwireBits::FlexComponent.new(direction: :column)) { "Column" }

    assert_text "Column"
  end
end

class StackComponentTest < ViewComponent::TestCase
  test "renders stack" do
    render_inline(HotwireBits::StackComponent.new) { "Stacked" }

    assert_text "Stacked"
  end

  test "renders stack with gap" do
    render_inline(HotwireBits::StackComponent.new(gap: 8)) { "Gapped" }

    assert_text "Gapped"
  end
end

class DividerComponentTest < ViewComponent::TestCase
  test "renders horizontal divider" do
    render_inline(HotwireBits::DividerComponent.new)

    assert_selector "div"
  end

  test "renders vertical divider" do
    render_inline(HotwireBits::DividerComponent.new(orientation: :vertical))

    assert_selector "div"
  end

  test "renders divider with label" do
    render_inline(HotwireBits::DividerComponent.new(label: "OR"))

    assert_text "OR"
  end
end

class ScrollAreaComponentTest < ViewComponent::TestCase
  test "renders scroll area" do
    render_inline(HotwireBits::ScrollAreaComponent.new(height: "300px")) { "Scrollable content" }

    assert_text "Scrollable content"
  end
end

class AspectRatioComponentTest < ViewComponent::TestCase
  test "renders aspect ratio" do
    render_inline(HotwireBits::AspectRatioComponent.new(ratio: "16/9")) { "Content" }

    assert_text "Content"
  end
end

class AppShellComponentTest < ViewComponent::TestCase
  test "renders app shell" do
    component = HotwireBits::AppShellComponent.new
    render_inline(component) do |c|
      c.with_header { "Header" }
      c.with_sidebar { "Sidebar" }
      c.with_body { "Main" }
      c.with_footer { "Footer" }
    end

    assert_text "Header"
    assert_text "Sidebar"
    assert_text "Main"
    assert_text "Footer"
  end
end

# Data Display

class DataTableComponentTest < ViewComponent::TestCase
  test "renders data table" do
    columns = [{key: :name, label: "Name"}, {key: :age, label: "Age"}]
    rows = [{name: "John", age: 30}, {name: "Jane", age: 25}]

    render_inline(HotwireBits::DataTableComponent.new(columns: columns, rows: rows))

    assert_selector "table"
    assert_text "Name"
    assert_text "Age"
    assert_text "John"
    assert_text "Jane"
  end
end

class StatsComponentTest < ViewComponent::TestCase
  test "renders stats" do
    stats = [{label: "Revenue", value: "$12,345"}, {label: "Users", value: "1,234"}]
    render_inline(HotwireBits::StatsComponent.new(stats: stats))

    assert_text "Revenue"
    assert_text "$12,345"
    assert_text "Users"
    assert_text "1,234"
  end
end

class TimelineComponentTest < ViewComponent::TestCase
  test "renders timeline" do
    items = [{title: "Event 1", description: "First event"}, {title: "Event 2"}]
    render_inline(HotwireBits::TimelineComponent.new(items: items))

    assert_text "Event 1"
    assert_text "First event"
    assert_text "Event 2"
  end
end

class AccordionComponentTest < ViewComponent::TestCase
  test "renders accordion" do
    items = [{title: "Section 1", content: "Content 1"}, {title: "Section 2", content: "Content 2"}]
    render_inline(HotwireBits::AccordionComponent.new(items: items))

    assert_text "Section 1"
    assert_text "Content 1"
    assert_text "Section 2"
    assert_text "Content 2"
    assert_selector "div[data-controller='hw-accordion']"
  end
end

class TreeViewComponentTest < ViewComponent::TestCase
  test "renders tree view" do
    items = [{label: "Root", children: [{label: "Child"}]}]
    render_inline(HotwireBits::TreeViewComponent.new(items: items))

    assert_text "Root"
    assert_text "Child"
    assert_selector "[data-controller='hw-tree']"
  end
end

class CodeBlockComponentTest < ViewComponent::TestCase
  test "renders code block" do
    render_inline(HotwireBits::CodeBlockComponent.new(code: "puts 'hello'", language: "ruby"))

    assert_text "puts 'hello'"
    assert_selector "pre"
  end
end

class HighlightComponentTest < ViewComponent::TestCase
  test "renders highlighted text" do
    render_inline(HotwireBits::HighlightComponent.new(text: "Hello World", query: "World"))

    assert_text "Hello World"
  end

  test "escapes user text" do
    render_inline(HotwireBits::HighlightComponent.new(text: "<script>alert(1)</script>", query: "script"))

    refute_selector "script"
  end
end

class MeterGroupComponentTest < ViewComponent::TestCase
  test "renders meter group" do
    meters = [{label: "CPU", value: 75, color: :default}, {label: "Memory", value: 50, color: :success}]
    render_inline(HotwireBits::MeterGroupComponent.new(meters: meters))

    assert_text "CPU"
    assert_text "75%"
    assert_text "Memory"
    assert_text "50%"
  end
end
