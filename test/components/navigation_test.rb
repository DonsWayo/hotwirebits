# frozen_string_literal: true

require "test_helper"

class NavbarComponentTest < ViewComponent::TestCase
  test "renders navbar" do
    render_inline(HotwireBits::NavbarComponent.new(brand: "MyApp"))

    assert_selector "nav"
    assert_text "MyApp"
  end

  test "renders navbar with menu items" do
    items = [{ label: "Home", href: "/" }, { label: "About", href: "/about" }]
    render_inline(HotwireBits::NavbarComponent.new(brand: "App", items: items))

    assert_text "Home"
    assert_text "About"
  end
end

class BreadcrumbComponentTest < ViewComponent::TestCase
  test "renders breadcrumb" do
    items = [{ label: "Home", href: "/" }, { label: "Products", href: "/products" }, { label: "Widget" }]
    render_inline(HotwireBits::BreadcrumbComponent.new(items: items))

    assert_selector "nav[aria-label='Breadcrumb']"
    assert_text "Home"
    assert_text "Products"
    assert_text "Widget"
  end
end

class PaginationComponentTest < ViewComponent::TestCase
  test "renders pagination" do
    render_inline(HotwireBits::PaginatorComponent.new(current_page: 2, total_pages: 10))

    assert_selector "nav[aria-label='Pagination']"
    assert_text "2"
    assert_text "10"
  end

  test "includes hw-paginator controller" do
    render_inline(HotwireBits::PaginatorComponent.new(current_page: 1, total_pages: 5))

    assert_selector "nav[data-controller='hw-paginator']"
  end
end

class TabsComponentTest < ViewComponent::TestCase
  test "renders tabs" do
    render_inline(HotwireBits::TabsComponent.new(tabs: [
      { label: "Tab 1", content: "Content 1" },
      { label: "Tab 2", content: "Content 2" }
    ]))

    assert_text "Tab 1"
    assert_text "Tab 2"
    assert_selector "div[data-controller='hw-tabs']"
  end
end

class MenuComponentTest < ViewComponent::TestCase
  test "renders menu" do
    items = [{ label: "Settings", href: "/settings" }, { label: "Profile", href: "/profile" }]
    render_inline(HotwireBits::MenuComponent.new(items: items))

    assert_text "Settings"
    assert_text "Profile"
  end
end

class DropdownComponentTest < ViewComponent::TestCase
  test "renders dropdown" do
    items = [{ label: "Edit", href: "/edit" }, { label: "Delete", href: "/delete" }]
    render_inline(HotwireBits::DropdownComponent.new(trigger_label: "Actions", items: items))

    assert_text "Actions"
    assert_text "Edit"
    assert_text "Delete"
    assert_selector "div[data-controller='hw-dropdown']"
  end
end

class SidebarComponentTest < ViewComponent::TestCase
  test "renders sidebar" do
    render_inline(HotwireBits::SidebarComponent.new(title: "Dashboard"))

    assert_text "Dashboard"
  end

  test "renders sidebar with content slot" do
    component = HotwireBits::SidebarComponent.new(title: "Nav")
    render_inline(component) do |c|
      c.with_body { "Menu items" }
    end

    assert_text "Menu items"
  end
end

class NavLinkComponentTest < ViewComponent::TestCase
  test "renders nav link" do
    render_inline(HotwireBits::NavLinkComponent.new(label: "Home", href: "/"))

    assert_selector "a[href='/']", text: "Home"
  end

  test "renders active nav link" do
    render_inline(HotwireBits::NavLinkComponent.new(label: "Current", href: "/current", active: true))

    assert_selector "a", text: "Current"
  end
end

class StepsComponentTest < ViewComponent::TestCase
  test "renders steps" do
    steps = [{ label: "Step 1" }, { label: "Step 2" }, { label: "Step 3" }]
    render_inline(HotwireBits::StepsComponent.new(steps: steps, current: 1))

    assert_text "Step 1"
    assert_text "Step 2"
    assert_text "Step 3"
    assert_selector "div[data-controller='hw-steps']"
  end
end

class FooterComponentTest < ViewComponent::TestCase
  test "renders footer" do
    render_inline(HotwireBits::FooterComponent.new(brand: "MyApp"))

    assert_text "MyApp"
  end

  test "renders footer with links" do
    sections = [{ title: "Links", links: [{ label: "Terms", href: "/terms" }] }]
    render_inline(HotwireBits::FooterComponent.new(brand: "App", sections: sections))

    assert_text "Terms"
  end
end
