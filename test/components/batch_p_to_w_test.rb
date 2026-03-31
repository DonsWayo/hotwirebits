# frozen_string_literal: true

require "test_helper"

# 1. PaginationComponent
class PaginationComponentTest < ViewComponent::TestCase
  test "renders pagination nav with page links" do
    render_inline(HotwireBits::PaginationComponent.new(current_page: 1, total_pages: 5, path: "/items"))

    assert_selector "nav[aria-label='Pagination']"
    assert_selector "a", text: "1"
    assert_selector "a", text: "5"
    assert_selector "a", text: "Next"
  end

  test "renders prev link when not on first page" do
    render_inline(HotwireBits::PaginationComponent.new(current_page: 3, total_pages: 5, path: "/items"))

    assert_selector "a", text: "Prev"
    assert_selector "a", text: "Next"
  end

  test "does not render prev on first page or next on last page" do
    render_inline(HotwireBits::PaginationComponent.new(current_page: 5, total_pages: 5, path: "/items"))

    assert_no_selector "a", text: "Next"
    assert_selector "a", text: "Prev"
  end
end

# 2. PanelComponent
class PanelComponentTest < ViewComponent::TestCase
  test "renders panel with title" do
    render_inline(HotwireBits::PanelComponent.new(title: "Settings")) { "Panel body" }

    assert_selector "div[data-controller='hw-panel']"
    assert_selector "span", text: "Settings"
    assert_text "Panel body"
  end

  test "renders collapsed panel" do
    render_inline(HotwireBits::PanelComponent.new(title: "Collapsed", collapsed: true)) { "Hidden content" }

    assert_selector "div[data-hw-panel-collapsed-value='true']"
  end
end

# 3. PasswordInputComponent
class PasswordInputComponentTest < ViewComponent::TestCase
  test "renders password input with defaults" do
    render_inline(HotwireBits::PasswordInputComponent.new)

    assert_selector "div[data-controller='hw-password']"
    assert_selector "input[type='password'][name='password']"
    assert_selector "input[placeholder='Enter password']"
  end

  test "renders without toggle button" do
    render_inline(HotwireBits::PasswordInputComponent.new(show_toggle: false))

    assert_selector "input[type='password']"
    assert_no_selector "button[data-action='click->hw-password#toggle']"
  end

  test "renders disabled password input" do
    render_inline(HotwireBits::PasswordInputComponent.new(disabled: true))

    assert_selector "input[disabled]"
  end
end

# 4. PasswordStrengthComponent
class PasswordStrengthComponentTest < ViewComponent::TestCase
  test "renders strength meter with empty password" do
    render_inline(HotwireBits::PasswordStrengthComponent.new(password: ""))

    assert_selector "div[data-controller='hw-password-strength']"
    assert_selector "div.flex.gap-1"
    assert_text "Weak"
  end

  test "renders strength meter with strong password" do
    render_inline(HotwireBits::PasswordStrengthComponent.new(password: "Str0ng!Pass"))

    assert_selector "div[data-controller='hw-password-strength']"
    assert_text "Strong"
  end
end

# 5. PasswordToggleComponent
class PasswordToggleComponentTest < ViewComponent::TestCase
  test "renders toggle button" do
    render_inline(HotwireBits::PasswordToggleComponent.new)

    assert_selector "button[type='button'][data-controller='hw-password-toggle']"
    assert_selector "button[aria-label='Toggle password visibility']"
    assert_selector "svg", count: 2
  end

  test "renders with target input" do
    render_inline(HotwireBits::PasswordToggleComponent.new(target_input: "#my-password"))

    assert_selector "button[data-hw-password-toggle-target-input-value='#my-password']"
  end
end

# 6. PermissionBadgeComponent
class PermissionBadgeComponentTest < ViewComponent::TestCase
  test "renders viewer badge by default" do
    render_inline(HotwireBits::PermissionBadgeComponent.new)

    assert_selector "span", text: "Viewer"
  end

  test "renders admin badge" do
    render_inline(HotwireBits::PermissionBadgeComponent.new(role: :admin))

    assert_selector "span", text: "Admin"
  end

  test "renders custom label" do
    render_inline(HotwireBits::PermissionBadgeComponent.new(role: :editor, label: "Moderator"))

    assert_selector "span", text: "Moderator"
  end
end

# 7. PhoneInputComponent
class PhoneInputComponentTest < ViewComponent::TestCase
  test "renders phone input with defaults" do
    render_inline(HotwireBits::PhoneInputComponent.new)

    assert_selector "input[type='tel'][name='phone']"
    assert_selector "input[placeholder='+1 (555) 000-0000']"
  end

  test "renders disabled phone input" do
    render_inline(HotwireBits::PhoneInputComponent.new(disabled: true))

    assert_selector "input[type='tel'][disabled]"
  end
end

# 8. PhoneMockupComponent
class PhoneMockupComponentTest < ViewComponent::TestCase
  test "renders iphone mockup by default" do
    render_inline(HotwireBits::PhoneMockupComponent.new) { "Screen content" }

    assert_text "Screen content"
    assert_selector "div.inline-block"
  end

  test "renders android mockup" do
    render_inline(HotwireBits::PhoneMockupComponent.new(device: :android)) { "Android screen" }

    assert_text "Android screen"
  end
end

# 9. PortalComponent
class PortalComponentTest < ViewComponent::TestCase
  test "renders portal template element" do
    render_inline(HotwireBits::PortalComponent.new) { "Portal content" }

    assert_selector "template[data-controller='hw-portal']", visible: :all
  end

  test "renders with custom target" do
    render_inline(HotwireBits::PortalComponent.new(target: "#modal-root")) { "Content" }

    assert_selector "template[data-hw-portal-target-value='#modal-root']", visible: :all
  end
end

# 10. ProductListComponent
class ProductListComponentTest < ViewComponent::TestCase
  test "renders empty product list" do
    render_inline(HotwireBits::ProductListComponent.new(products: []))

    assert_selector "div.grid"
  end

  test "renders products" do
    products = [
      {name: "Widget", price: "$9.99", href: "/widget"},
      {name: "Gadget", price: "$19.99", href: "/gadget"}
    ]
    render_inline(HotwireBits::ProductListComponent.new(products: products))

    assert_selector "a", count: 2
    assert_selector "h3", text: "Widget"
    assert_selector "p", text: "$9.99"
  end
end

# 11. ProductOverviewComponent
class ProductOverviewComponentTest < ViewComponent::TestCase
  test "renders product name and price" do
    render_inline(HotwireBits::ProductOverviewComponent.new(name: "Headphones", price: "$99"))

    assert_selector "h1", text: "Headphones"
    assert_selector "p", text: "$99"
    assert_selector "button", text: "Add to Cart"
  end

  test "renders with features" do
    render_inline(HotwireBits::ProductOverviewComponent.new(
      name: "Phone", price: "$499", features: ["Fast charging", "5G"]
    ))

    assert_selector "li", text: "Fast charging"
    assert_selector "li", text: "5G"
  end
end

# 12. ProductQuickviewComponent
class ProductQuickviewComponentTest < ViewComponent::TestCase
  test "renders quickview with name and price" do
    render_inline(HotwireBits::ProductQuickviewComponent.new(name: "Shirt", price: "$29"))

    assert_selector "h3", text: "Shirt"
    assert_selector "span", text: "$29"
    assert_selector "button", text: "Add to Cart"
  end

  test "renders details link when href provided" do
    render_inline(HotwireBits::ProductQuickviewComponent.new(name: "Shirt", price: "$29", href: "/shirt"))

    assert_selector "a[href='/shirt']", text: "Details"
  end
end

# 13. ProgressRingComponent
class ProgressRingComponentTest < ViewComponent::TestCase
  test "renders progress ring" do
    render_inline(HotwireBits::ProgressRingComponent.new(value: 75))

    assert_selector "svg"
    assert_selector "circle", count: 2
  end

  test "renders with label" do
    render_inline(HotwireBits::ProgressRingComponent.new(value: 50, max: 100, show_label: true))

    assert_selector "span", text: "50%"
  end
end

# 14. PromoSectionComponent
class PromoSectionComponentTest < ViewComponent::TestCase
  test "renders promo with title" do
    render_inline(HotwireBits::PromoSectionComponent.new(title: "Summer Sale"))

    assert_selector "section"
    assert_selector "h2", text: "Summer Sale"
  end

  test "renders with badge and description" do
    render_inline(HotwireBits::PromoSectionComponent.new(
      title: "New", badge: "Limited", description: "Don't miss out"
    ))

    assert_selector "span", text: "Limited"
    assert_selector "p", text: "Don't miss out"
  end

  test "renders CTA link" do
    render_inline(HotwireBits::PromoSectionComponent.new(
      title: "Promo", cta: {label: "Shop Now", href: "/shop"}
    ))

    assert_selector "a[href='/shop']", text: "Shop Now"
  end
end

# 15. RadioComponent
class RadioComponentTest < ViewComponent::TestCase
  test "renders radio input" do
    render_inline(HotwireBits::RadioComponent.new(name: "color", value: "red"))

    assert_selector "label"
    assert_selector "input[type='radio'][name='color'][value='red']"
  end

  test "renders radio with label" do
    render_inline(HotwireBits::RadioComponent.new(name: "color", value: "blue", label: "Blue"))

    assert_selector "span", text: "Blue"
  end

  test "renders checked and disabled radio" do
    render_inline(HotwireBits::RadioComponent.new(checked: true, disabled: true))

    assert_selector "input[checked]"
    assert_selector "input[disabled]"
  end
end

# 16. RangeSliderComponent
class RangeSliderComponentTest < ViewComponent::TestCase
  test "renders dual range inputs" do
    render_inline(HotwireBits::RangeSliderComponent.new)

    assert_selector "div[data-controller='hw-range-slider']"
    assert_selector "input[type='range']", count: 2
    assert_selector "input[name='min']"
    assert_selector "input[name='max']"
  end

  test "renders with custom values" do
    render_inline(HotwireBits::RangeSliderComponent.new(value_min: 10, value_max: 90, min: 0, max: 100))

    assert_selector "input[value='10']"
    assert_selector "input[value='90']"
  end
end

# 17. ResizableComponent
class ResizableComponentTest < ViewComponent::TestCase
  test "renders horizontal resizable panels" do
    component = HotwireBits::ResizableComponent.new(direction: :horizontal)
    render_inline(component) do |c|
      c.with_left { "Left panel" }
      c.with_right { "Right panel" }
    end

    assert_selector "div[data-controller='hw-resizable']"
    assert_text "Left panel"
    assert_text "Right panel"
  end
end

# 18. ReviewComponent
class ReviewComponentTest < ViewComponent::TestCase
  test "renders review with author and content" do
    render_inline(HotwireBits::ReviewComponent.new(author: "Jane Doe", review_content: "Great product!"))

    assert_text "Jane Doe"
    assert_text "Great product!"
    assert_text "JD"
  end

  test "renders with title and rating" do
    render_inline(HotwireBits::ReviewComponent.new(author: "John", review_content: "Nice", title: "Excellent", rating: 4))

    assert_text "John"
    assert_text "Nice"
    assert_text "Excellent"
  end

  test "renders verified badge" do
    render_inline(HotwireBits::ReviewComponent.new(author: "Jane", review_content: "Good", verified: true))

    assert_text "Verified"
  end
end

# 19. RichTextEditorComponent
class RichTextEditorComponentTest < ViewComponent::TestCase
  test "renders rich text editor" do
    render_inline(HotwireBits::RichTextEditorComponent.new(name: "body"))

    assert_selector "div[data-controller='hw-rich-text-editor']"
    assert_selector "input[type='hidden'][name='body']", visible: :all
    assert_selector "div[contenteditable='true']"
  end

  test "renders toolbar buttons" do
    render_inline(HotwireBits::RichTextEditorComponent.new(name: "content", toolbar: %w[bold italic]))

    assert_selector "button[title='Bold']"
    assert_selector "button[title='Italic']"
  end
end

# 20. SearchInputComponent
class SearchInputComponentTest < ViewComponent::TestCase
  test "renders search input with defaults" do
    render_inline(HotwireBits::SearchInputComponent.new)

    assert_selector "input[type='search'][name='q']"
    assert_selector "input[placeholder='Search...']"
    assert_selector "svg"
  end

  test "renders disabled search input" do
    render_inline(HotwireBits::SearchInputComponent.new(disabled: true))

    assert_selector "input[disabled]"
  end
end

# 21. SectionHeadingComponent
class SectionHeadingComponentTest < ViewComponent::TestCase
  test "renders heading with title" do
    render_inline(HotwireBits::SectionHeadingComponent.new(title: "Features"))

    assert_selector "h2", text: "Features"
  end

  test "renders with description" do
    render_inline(HotwireBits::SectionHeadingComponent.new(
      title: "About", description: "Learn more about us"
    ))

    assert_selector "h2", text: "About"
    assert_selector "p", text: "Learn more about us"
  end
end

# 22. SemiCircleProgressComponent
class SemiCircleProgressComponentTest < ViewComponent::TestCase
  test "renders semi-circle progress" do
    render_inline(HotwireBits::SemiCircleProgressComponent.new(value: 60))

    assert_selector "svg"
    assert_selector "path", count: 2
    assert_selector "span", text: "60%"
  end

  test "renders without label" do
    render_inline(HotwireBits::SemiCircleProgressComponent.new(value: 40, show_label: false))

    assert_selector "svg"
    assert_no_selector "span"
  end
end

# 23. ShoppingCartComponent
class ShoppingCartComponentTest < ViewComponent::TestCase
  test "renders empty cart" do
    render_inline(HotwireBits::ShoppingCartComponent.new(items: []))

    assert_selector "h2", text: "Shopping Cart (0)"
    assert_text "Your cart is empty"
  end

  test "renders cart with items" do
    items = [
      {name: "T-Shirt", price: "$25.00", quantity: 2},
      {name: "Jeans", price: "$50.00", quantity: 1}
    ]
    render_inline(HotwireBits::ShoppingCartComponent.new(items: items))

    assert_selector "h2", text: "Shopping Cart (2)"
    assert_text "T-Shirt"
    assert_text "Jeans"
    assert_selector "button", text: "Checkout"
  end
end

# 24. SimpleGridComponent
class SimpleGridComponentTest < ViewComponent::TestCase
  test "renders grid container with block content" do
    render_inline(HotwireBits::SimpleGridComponent.new) { "Grid items here" }

    assert_selector "div.grid"
    assert_text "Grid items here"
  end

  test "renders with custom min column width" do
    render_inline(HotwireBits::SimpleGridComponent.new(min_col_width: "300px")) { "Content" }

    assert_selector "div[style*='300px']"
  end
end

# 25. SkeletonCardComponent
class SkeletonCardComponentTest < ViewComponent::TestCase
  test "renders skeleton card with default lines" do
    render_inline(HotwireBits::SkeletonCardComponent.new)

    assert_selector "div.animate-pulse", count: 3
  end

  test "renders with image and avatar placeholders" do
    render_inline(HotwireBits::SkeletonCardComponent.new(has_image: true, has_avatar: true, lines: 2))

    assert_selector "div.animate-pulse.rounded-full"
    assert_selector "div.animate-pulse.rounded-md"
  end
end

# 26. SocialShareComponent
class SocialShareComponentTest < ViewComponent::TestCase
  test "renders share buttons for all platforms" do
    render_inline(HotwireBits::SocialShareComponent.new(url: "https://example.com"))

    assert_selector "a[target='_blank']", count: 4
    assert_selector "a[aria-label='Share on Twitter']"
    assert_selector "a[aria-label='Share on Facebook']"
    assert_selector "a[aria-label='Share on Linkedin']"
    assert_selector "a[aria-label='Share on Email']"
  end

  test "renders subset of platforms" do
    render_inline(HotwireBits::SocialShareComponent.new(
      url: "https://example.com", platforms: [:twitter, :email]
    ))

    assert_selector "a", count: 2
  end
end

# 27. SpaceComponent
class SpaceComponentTest < ViewComponent::TestCase
  test "renders spacer div" do
    render_inline(HotwireBits::SpaceComponent.new(h: "2rem"))

    assert_selector "div[aria-hidden='true']"
    assert_selector "div[style*='height: 2rem']"
  end

  test "renders with width" do
    render_inline(HotwireBits::SpaceComponent.new(w: "100px"))

    assert_selector "div[style*='width: 100px']"
  end
end

# 28. SpeedDialComponent
class SpeedDialComponentTest < ViewComponent::TestCase
  test "renders speed dial button" do
    render_inline(HotwireBits::SpeedDialComponent.new)

    assert_selector "div[data-controller='hw-speed-dial']"
    assert_selector "button[aria-label='Open actions']"
  end

  test "renders with actions" do
    actions = [{label: "Add", href: "/add"}, {label: "Edit", href: "/edit"}]
    render_inline(HotwireBits::SpeedDialComponent.new(actions: actions))

    assert_selector "a", count: 2
    assert_selector "span", text: "Add"
  end
end

# 29. SpeedDialFabComponent
class SpeedDialFabComponentTest < ViewComponent::TestCase
  test "renders floating action button" do
    render_inline(HotwireBits::SpeedDialFabComponent.new)

    assert_selector "div[data-controller='hw-speed-dial']"
    assert_selector "button[data-action='click->hw-speed-dial#toggle']"
  end
end

# 30. SplitButtonComponent
class SplitButtonComponentTest < ViewComponent::TestCase
  test "renders split button with label" do
    render_inline(HotwireBits::SplitButtonComponent.new(label: "Save"))

    assert_selector "div[data-controller='hw-dropdown']"
    assert_selector "button", text: "Save"
    assert_selector "button", count: 2
  end

  test "renders dropdown items" do
    items = [{label: "Save as draft", href: "/draft"}, {label: "Publish", href: "/publish"}]
    render_inline(HotwireBits::SplitButtonComponent.new(label: "Save", items: items))

    assert_selector "a", text: "Save as draft"
    assert_selector "a", text: "Publish"
  end
end

# 31. SplitterComponent
class SplitterComponentTest < ViewComponent::TestCase
  test "renders horizontal splitter" do
    component = HotwireBits::SplitterComponent.new(direction: :horizontal)
    render_inline(component) do |c|
      c.with_slot_1 { "Panel A" }
      c.with_slot_2 { "Panel B" }
    end

    assert_selector "div[data-controller='hw-splitter']"
    assert_text "Panel A"
    assert_text "Panel B"
  end
end

# 32. StackedListComponent
class StackedListComponentTest < ViewComponent::TestCase
  test "renders empty stacked list" do
    render_inline(HotwireBits::StackedListComponent.new(items: []))

    assert_selector "ul[role='list']"
  end

  test "renders items with titles" do
    items = [
      {title: "Item 1", subtitle: "Description 1"},
      {title: "Item 2"}
    ]
    render_inline(HotwireBits::StackedListComponent.new(items: items))

    assert_selector "li", count: 2
    assert_text "Item 1"
    assert_text "Description 1"
    assert_text "Item 2"
  end
end

# 33. StatComponent
class StatComponentTest < ViewComponent::TestCase
  test "renders stat with title and value" do
    render_inline(HotwireBits::StatComponent.new(title: "Revenue", value: "$12,345"))

    assert_selector "p", text: "Revenue"
    assert_selector "p", text: "$12,345"
  end

  test "renders with trend" do
    render_inline(HotwireBits::StatComponent.new(
      title: "Users", value: "1,234", trend_up: true, trend_value: "+12%"
    ))

    assert_text "+12%"
  end
end

# 34. StatusBarComponent
class StatusBarComponentTest < ViewComponent::TestCase
  test "renders empty status bar" do
    render_inline(HotwireBits::StatusBarComponent.new)

    assert_selector "div"
  end

  test "renders items with labels" do
    items = [{label: "Line", value: "42"}, {label: "Col", value: "8"}]
    render_inline(HotwireBits::StatusBarComponent.new(items: items))

    assert_text "Line"
    assert_text "42"
    assert_text "Col"
    assert_text "8"
  end
end

# 35. StepperFormComponent
class StepperFormComponentTest < ViewComponent::TestCase
  test "renders stepper with steps" do
    steps = [{label: "Account"}, {label: "Profile"}, {label: "Confirm"}]
    render_inline(HotwireBits::StepperFormComponent.new(steps: steps, current_step: 0))

    assert_selector "div[data-controller='hw-stepper-form']"
    assert_selector "span", text: "Account"
    assert_selector "span", text: "Profile"
    assert_selector "span", text: "Confirm"
    assert_selector "button", text: "Previous"
    assert_selector "button", text: "Next"
  end

  test "renders submit on last step" do
    steps = [{label: "Step 1"}, {label: "Step 2"}]
    render_inline(HotwireBits::StepperFormComponent.new(steps: steps, current_step: 1))

    assert_selector "button[type='submit']", text: "Submit"
  end
end

# 36. TableComponent
class TableComponentTest < ViewComponent::TestCase
  test "renders table wrapper" do
    render_inline(HotwireBits::TableComponent.new) { "<tr><td>Cell</td></tr>".html_safe }

    assert_selector "table"
    assert_selector "td", text: "Cell"
  end

  test "renders bordered table" do
    render_inline(HotwireBits::TableComponent.new(bordered: true)) { "" }

    assert_selector "table.border"
  end
end

# 37. TableOfContentsComponent
class TableOfContentsComponentTest < ViewComponent::TestCase
  test "renders table of contents with headings" do
    headings = [
      {id: "intro", text: "Introduction", level: 2},
      {id: "details", text: "Details", level: 3}
    ]
    render_inline(HotwireBits::TableOfContentsComponent.new(headings: headings))

    assert_selector "nav[aria-label='Table of contents']"
    assert_selector "a[href='#intro']", text: "Introduction"
    assert_selector "a[href='#details']", text: "Details"
  end

  test "renders with active item" do
    headings = [{id: "active", text: "Active Section", level: 2}]
    render_inline(HotwireBits::TableOfContentsComponent.new(headings: headings, active_id: "active"))

    assert_selector "a.font-medium", text: "Active Section"
  end
end

# 38. TagInputComponent
class TagInputComponentTest < ViewComponent::TestCase
  test "renders tag input with existing tags" do
    render_inline(HotwireBits::TagInputComponent.new(name: "tags", value: ["ruby", "rails"]))

    assert_selector "div[data-controller='hw-tag-input']"
    assert_selector "span", text: "ruby"
    assert_selector "span", text: "rails"
    assert_selector "input[type='hidden'][name='tags[]']", count: 2, visible: :all
    assert_selector "input[type='text'][placeholder='Add tag...']"
  end

  test "renders empty tag input" do
    render_inline(HotwireBits::TagInputComponent.new(name: "tags"))

    assert_selector "input[type='text']"
    assert_no_selector "input[type='hidden']", visible: :all
  end
end

# 39. TeamSectionComponent
class TeamSectionComponentTest < ViewComponent::TestCase
  test "renders team section with title and members" do
    members = [
      {name: "Alice Smith", role: "CEO"},
      {name: "Bob Jones", role: "CTO"}
    ]
    render_inline(HotwireBits::TeamSectionComponent.new(title: "Our Team", members: members))

    assert_selector "section"
    assert_selector "h2", text: "Our Team"
    assert_selector "h3", text: "Alice Smith"
    assert_selector "p", text: "CEO"
    assert_selector "h3", text: "Bob Jones"
  end

  test "renders without title" do
    members = [{name: "Jane Doe"}]
    render_inline(HotwireBits::TeamSectionComponent.new(members: members))

    assert_no_selector "h2"
    assert_selector "h3", text: "Jane Doe"
  end
end

# 40. TerminalComponent
class TerminalComponentTest < ViewComponent::TestCase
  test "renders terminal with title" do
    render_inline(HotwireBits::TerminalComponent.new(title: "bash"))

    assert_selector "span", text: "bash"
  end

  test "renders terminal with command lines" do
    lines = [
      {command: "ls -la", output: "total 42"},
      {prompt: "~", command: "echo hello"}
    ]
    render_inline(HotwireBits::TerminalComponent.new(lines: lines))

    assert_text "ls -la"
    assert_text "total 42"
    assert_text "echo hello"
  end
end

# 41. TestimonialsSectionComponent
class TestimonialsSectionComponentTest < ViewComponent::TestCase
  test "renders testimonials with title" do
    testimonials = [
      {quote: "Amazing product!", author: "John Doe", role: "Manager"}
    ]
    render_inline(HotwireBits::TestimonialsSectionComponent.new(
      title: "What People Say", testimonials: testimonials
    ))

    assert_selector "section"
    assert_selector "h2", text: "What People Say"
    assert_text "Amazing product!"
    assert_selector "p", text: "John Doe"
    assert_selector "p", text: "Manager"
  end

  test "renders empty testimonials" do
    render_inline(HotwireBits::TestimonialsSectionComponent.new)

    assert_selector "section"
  end
end

# 42. TextGradientComponent
class TextGradientComponentTest < ViewComponent::TestCase
  test "renders gradient text" do
    render_inline(HotwireBits::TextGradientComponent.new(
      from_color: "blue-500", to_color: "purple-500"
    )) { "Hello World" }

    assert_selector "span.bg-clip-text.text-transparent", text: "Hello World"
  end
end

# 43. TextRotateComponent
class TextRotateComponentTest < ViewComponent::TestCase
  test "renders rotating texts" do
    render_inline(HotwireBits::TextRotateComponent.new(texts: ["Hello", "World", "Ruby"]))

    assert_selector "span[data-controller='text-rotate']"
    assert_selector "span[data-text-rotate-target='item']", count: 3
    assert_text "Hello"
    assert_text "World"
    assert_text "Ruby"
  end

  test "renders empty when no texts" do
    render_inline(HotwireBits::TextRotateComponent.new(texts: []))

    assert_selector "span[data-controller='text-rotate']"
  end
end

# 44. ThemeControllerComponent
class ThemeControllerComponentTest < ViewComponent::TestCase
  test "renders theme toggle button" do
    render_inline(HotwireBits::ThemeControllerComponent.new)

    assert_selector "div[data-controller='hw-theme']"
    assert_selector "button[data-action='click->hw-theme#toggle']"
    assert_selector "span", text: "Light"
  end

  test "renders with custom labels" do
    render_inline(HotwireBits::ThemeControllerComponent.new(
      light_label: "Claro", dark_label: "Oscuro"
    ))

    assert_selector "span", text: "Claro"
  end
end

# 45. ThemeIconComponent
class ThemeIconComponentTest < ViewComponent::TestCase
  test "renders theme icon wrapper" do
    render_inline(HotwireBits::ThemeIconComponent.new) { "<svg></svg>".html_safe }

    assert_selector "span.inline-flex"
  end
end

# 46. ThemeSelectorComponent
class ThemeSelectorComponentTest < ViewComponent::TestCase
  test "renders theme selector dropdown" do
    themes = [
      {name: "light", preview_color: "#fff"},
      {name: "dark", preview_color: "#000"}
    ]
    render_inline(HotwireBits::ThemeSelectorComponent.new(themes: themes))

    assert_selector "div[data-controller='hw-theme-selector']"
    assert_selector "button", text: "Theme"
    assert_selector "button[data-theme='light']", text: "Light"
    assert_selector "button[data-theme='dark']", text: "Dark"
  end

  test "renders with current theme" do
    themes = [{name: "dark"}]
    render_inline(HotwireBits::ThemeSelectorComponent.new(themes: themes, current_theme: "dark"))

    assert_selector "span", text: "Dark"
  end
end

# 47. TimePickerComponent
class TimePickerComponentTest < ViewComponent::TestCase
  test "renders 24-hour time input by default" do
    render_inline(HotwireBits::TimePickerComponent.new)

    assert_selector "div[data-controller='hw-time-picker']"
    assert_selector "input[type='time']"
  end

  test "renders 12-hour time input with AM/PM" do
    render_inline(HotwireBits::TimePickerComponent.new(time_format: :twelve))

    assert_selector "input[type='text']"
    assert_selector "select"
    assert_selector "option[value='AM']"
    assert_selector "option[value='PM']"
  end
end

# 48. ToggleButtonComponent
class ToggleButtonComponentTest < ViewComponent::TestCase
  test "renders toggle button" do
    render_inline(HotwireBits::ToggleButtonComponent.new(label: "Bold"))

    assert_selector "button[type='button'][data-controller='hw-toggle-button']"
    assert_selector "button[aria-pressed='false']"
    assert_selector "span", text: "Bold"
  end

  test "renders pressed toggle button" do
    render_inline(HotwireBits::ToggleButtonComponent.new(label: "Italic", pressed: true))

    assert_selector "button[aria-pressed='true']"
  end
end

# 49. ToggleButtonGroupComponent
class ToggleButtonGroupComponentTest < ViewComponent::TestCase
  test "renders toggle group with options" do
    options = [
      {label: "Left", value: "left"},
      {label: "Center", value: "center"},
      {label: "Right", value: "right"}
    ]
    render_inline(HotwireBits::ToggleButtonGroupComponent.new(options: options))

    assert_selector "div[role='group']"
    assert_selector "button", count: 3
    assert_selector "span", text: "Left"
    assert_selector "span", text: "Center"
    assert_selector "span", text: "Right"
  end

  test "renders with selected option" do
    options = [{label: "A", value: "a"}, {label: "B", value: "b"}]
    render_inline(HotwireBits::ToggleButtonGroupComponent.new(options: options, selected: "a"))

    assert_selector "button[aria-pressed='true']", count: 1
    assert_selector "button[aria-pressed='false']", count: 1
  end
end

# 50. ToolbarComponent
class ToolbarComponentTest < ViewComponent::TestCase
  test "renders toolbar" do
    render_inline(HotwireBits::ToolbarComponent.new)

    assert_selector "div[role='toolbar']"
  end

  test "renders toolbar with items" do
    items = [{label: "Cut"}, {label: "Copy"}, {label: "Paste"}]
    render_inline(HotwireBits::ToolbarComponent.new(items: items))

    assert_selector "button", count: 3
    assert_selector "span", text: "Cut"
    assert_selector "span", text: "Copy"
    assert_selector "span", text: "Paste"
  end

  test "renders with separators" do
    items = [{label: "A"}, {label: "B"}]
    render_inline(HotwireBits::ToolbarComponent.new(items: items, with_separator: true))

    assert_selector "div[role='separator']", count: 1
  end
end

# 51. TwoFactorComponent
class TwoFactorComponentTest < ViewComponent::TestCase
  test "renders 2FA input with default 6 digits" do
    render_inline(HotwireBits::TwoFactorComponent.new)

    assert_selector "div[data-controller='hw-two-factor']"
    assert_selector "input[type='text'][maxlength='1']", count: 6
  end

  test "renders with custom length" do
    render_inline(HotwireBits::TwoFactorComponent.new(length: 4))

    assert_selector "input[type='text'][maxlength='1']", count: 4
  end

  test "renders hidden input with name" do
    render_inline(HotwireBits::TwoFactorComponent.new(name: "otp_code"))

    assert_selector "input[type='hidden'][name='otp_code']", visible: :all
  end
end

# 52. TypingIndicatorComponent
class TypingIndicatorComponentTest < ViewComponent::TestCase
  test "renders three bouncing dots" do
    render_inline(HotwireBits::TypingIndicatorComponent.new)

    assert_selector "span.animate-bounce", count: 3
  end

  test "renders with custom size" do
    render_inline(HotwireBits::TypingIndicatorComponent.new(size: :lg))

    assert_selector "div.flex"
    assert_selector "span.animate-bounce", count: 3
  end
end

# 53. ValidatorComponent
class ValidatorComponentTest < ViewComponent::TestCase
  test "renders validator for a field" do
    render_inline(HotwireBits::ValidatorComponent.new(field: "email"))

    assert_selector "div[data-controller='hw-validator']"
    assert_selector "div[data-hw-validator-field-value='email']"
  end

  test "renders with rules" do
    rules = ["required", "min_length"]
    render_inline(HotwireBits::ValidatorComponent.new(field: "password", rules: rules))

    assert_selector "li", count: 2
  end
end

# 54. VersionDiffComponent
class VersionDiffComponentTest < ViewComponent::TestCase
  test "renders side-by-side diff" do
    render_inline(HotwireBits::VersionDiffComponent.new(old_text: "hello\n", new_text: "world\n"))

    assert_selector "div.grid.grid-cols-2"
    assert_text "Old"
    assert_text "New"
  end

  test "renders unified diff" do
    render_inline(HotwireBits::VersionDiffComponent.new(
      old_text: "line1\n", new_text: "line2\n", view: :unified
    ))

    assert_text "Unified Diff"
  end
end

# 55. VideoPlayerComponent
class VideoPlayerComponentTest < ViewComponent::TestCase
  test "renders video player" do
    render_inline(HotwireBits::VideoPlayerComponent.new(src: "/video.mp4"))

    assert_selector "video[src='/video.mp4']"
    assert_selector "video[controls]"
  end

  test "renders without controls" do
    render_inline(HotwireBits::VideoPlayerComponent.new(src: "/video.mp4", controls: false))

    assert_selector "video[src='/video.mp4']"
    assert_no_selector "video[controls]"
  end
end

# 56. VoiceRecorderComponent
class VoiceRecorderComponentTest < ViewComponent::TestCase
  test "renders voice recorder" do
    render_inline(HotwireBits::VoiceRecorderComponent.new(name: "audio"))

    assert_selector "div[data-controller='hw-voice-recorder']"
    assert_selector "button[aria-label='Record']"
    assert_selector "input[type='hidden'][name='audio']", visible: :all
    assert_text "Click to record"
  end

  test "renders with custom max duration" do
    render_inline(HotwireBits::VoiceRecorderComponent.new(name: "voice", max_duration: 30))

    assert_selector "div[data-hw-voice-recorder-max-duration-value='30']"
  end
end

# 57. WindowMockupComponent
class WindowMockupComponentTest < ViewComponent::TestCase
  test "renders window mockup with content" do
    render_inline(HotwireBits::WindowMockupComponent.new) { "Window content" }

    assert_text "Window content"
    assert_selector "div.rounded-full", minimum: 3
  end

  test "renders with title" do
    render_inline(HotwireBits::WindowMockupComponent.new(title: "Preview")) { "Content" }

    assert_selector "span", text: "Preview"
  end

  test "renders resizable window" do
    render_inline(HotwireBits::WindowMockupComponent.new(resizable: true)) { "Resizable" }

    assert_selector "div.resize"
  end
end
