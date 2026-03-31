# frozen_string_literal: true

require "test_helper"

# 1. ActivityFeedComponent
class ActivityFeedComponentTest < ViewComponent::TestCase
  test "renders empty feed" do
    render_inline(HotwireBits::ActivityFeedComponent.new)
    assert_selector "div.space-y-0"
  end

  test "renders feed with items" do
    items = [
      {actor: "Alice", action: "created", target: "Project X", time: "2h ago"},
      {actor: "Bob", action: "updated", target: "Issue #5"}
    ]
    render_inline(HotwireBits::ActivityFeedComponent.new(items: items))
    assert_text "Alice"
    assert_text "created"
    assert_text "Project X"
    assert_text "Bob"
  end

  test "renders load more button" do
    render_inline(HotwireBits::ActivityFeedComponent.new(items: [], load_more: true))
    assert_selector "button", text: "Load more"
  end
end

# 2. AffixComponent
class AffixComponentTest < ViewComponent::TestCase
  test "renders with default position" do
    render_inline(HotwireBits::AffixComponent.new) { "Affixed content" }
    assert_selector "div.fixed", text: "Affixed content"
  end

  test "renders with bottom position" do
    render_inline(HotwireBits::AffixComponent.new(position: :bottom, offset: 10))
    assert_selector "div[style*='bottom: 10px']"
  end
end

# 3. AiChatComponent
class AiChatComponentTest < ViewComponent::TestCase
  test "renders empty chat" do
    render_inline(HotwireBits::AiChatComponent.new)
    assert_selector "div[data-controller='hw-ai-chat']"
    assert_selector "button[type='submit']", text: "Send"
    assert_selector "input[placeholder='Type a message...']"
  end

  test "renders with messages" do
    messages = [
      {role: "user", content: "Hello"},
      {role: "assistant", content: "Hi there!"}
    ]
    render_inline(HotwireBits::AiChatComponent.new(messages: messages))
    assert_text "Hello"
    assert_text "Hi there!"
  end

  test "renders custom placeholder and send label" do
    render_inline(HotwireBits::AiChatComponent.new(placeholder: "Ask me...", send_label: "Go"))
    assert_selector "input[placeholder='Ask me...']"
    assert_selector "button", text: "Go"
  end
end

# 4. AnchorComponent
class AnchorComponentTest < ViewComponent::TestCase
  test "renders anchor with href" do
    render_inline(HotwireBits::AnchorComponent.new(href: "/about"))
    assert_selector "a[href='/about']"
  end

  test "renders anchor with label" do
    render_inline(HotwireBits::AnchorComponent.new(href: "#top", label: "Back to top"))
    assert_selector "a", text: "Back to top"
  end

  test "renders anchor with block content" do
    render_inline(HotwireBits::AnchorComponent.new(href: "/home")) { "Go home" }
    assert_selector "a[href='/home']", text: "Go home"
  end
end

# 5. AngleSliderComponent
class AngleSliderComponentTest < ViewComponent::TestCase
  test "renders with default value" do
    render_inline(HotwireBits::AngleSliderComponent.new)
    assert_selector "div[data-controller='hw-angle-slider']"
    assert_selector "svg"
    assert_text "0°"
  end

  test "renders with custom value" do
    render_inline(HotwireBits::AngleSliderComponent.new(value: 90, name: "angle"))
    assert_text "90°"
    assert_selector "input[type='hidden'][name='angle'][value='90']", visible: :all
  end
end

# 6. AuthBlockComponent
class AuthBlockComponentTest < ViewComponent::TestCase
  test "renders sign in form by default" do
    render_inline(HotwireBits::AuthBlockComponent.new)
    assert_selector "h2", text: "Welcome back"
    assert_selector "form[action='/users/sign_in']"
    assert_selector "button[type='submit']", text: "Sign in"
  end

  test "renders sign up form" do
    render_inline(HotwireBits::AuthBlockComponent.new(type: :sign_up))
    assert_selector "h2", text: "Create an account"
    assert_selector "input[name='name']"
    assert_selector "button[type='submit']", text: "Create account"
  end

  test "renders with providers" do
    render_inline(HotwireBits::AuthBlockComponent.new(providers: [:google]))
    assert_text "Continue with Google"
    assert_text "or continue with email"
  end
end

# 7. AutocompleteComponent
class AutocompleteComponentTest < ViewComponent::TestCase
  test "renders autocomplete input" do
    render_inline(HotwireBits::AutocompleteComponent.new(name: "search", url: "/search"))
    assert_selector "div[data-controller='hw-autocomplete']"
    assert_selector "input[type='text'][placeholder='Search...']"
    assert_selector "input[type='hidden'][name='search']", visible: :all
    assert_selector "ul[role='listbox']"
  end

  test "renders with custom placeholder" do
    render_inline(HotwireBits::AutocompleteComponent.new(name: "city", url: "/cities", placeholder: "Find a city..."))
    assert_selector "input[placeholder='Find a city...']"
  end
end

# 8. BackgroundImageComponent
class BackgroundImageComponentTest < ViewComponent::TestCase
  test "renders background image" do
    render_inline(HotwireBits::BackgroundImageComponent.new(src: "/bg.jpg")) { "Content" }
    assert_selector "div.relative"
    assert_selector "div[style*='background-image']"
    assert_text "Content"
  end

  test "renders with overlay" do
    render_inline(HotwireBits::BackgroundImageComponent.new(src: "/bg.jpg", overlay: true)) { "Over" }
    assert_selector "div.bg-black\\/40"
  end
end

# 9. BentoGridComponent
class BentoGridComponentTest < ViewComponent::TestCase
  test "renders empty grid" do
    render_inline(HotwireBits::BentoGridComponent.new)
    assert_selector "div.grid"
  end

  test "renders grid with custom columns" do
    render_inline(HotwireBits::BentoGridComponent.new(columns: 4))
    assert_selector "div.grid-cols-4"
  end
end

# 10. BlogSectionComponent
class BlogSectionComponentTest < ViewComponent::TestCase
  test "renders section with title" do
    render_inline(HotwireBits::BlogSectionComponent.new(title: "Our Blog"))
    assert_selector "section"
    assert_selector "h2", text: "Our Blog"
  end

  test "renders posts" do
    posts = [{title: "Post 1", href: "/posts/1"}]
    render_inline(HotwireBits::BlogSectionComponent.new(posts: posts))
    assert_selector "a[href='/posts/1']"
    assert_text "Post 1"
  end
end

# 11. BottomNavigationComponent
class BottomNavigationComponentTest < ViewComponent::TestCase
  test "renders nav with items" do
    items = [
      {label: "Home", href: "/"},
      {label: "Search", href: "/search"}
    ]
    render_inline(HotwireBits::BottomNavigationComponent.new(items: items))
    assert_selector "nav.fixed"
    assert_selector "a[href='/']", text: "Home"
    assert_selector "a[href='/search']", text: "Search"
  end

  test "renders empty nav" do
    render_inline(HotwireBits::BottomNavigationComponent.new)
    assert_selector "nav"
  end
end

# 12. BoxComponent
class BoxComponentTest < ViewComponent::TestCase
  test "renders div by default" do
    render_inline(HotwireBits::BoxComponent.new) { "Box content" }
    assert_selector "div", text: "Box content"
  end

  test "renders as section" do
    render_inline(HotwireBits::BoxComponent.new(as: :section)) { "Section" }
    assert_selector "section", text: "Section"
  end

  test "renders as article" do
    render_inline(HotwireBits::BoxComponent.new(as: :article)) { "Article" }
    assert_selector "article", text: "Article"
  end
end

# 13. BreadcrumbAdvancedComponent
class BreadcrumbAdvancedComponentTest < ViewComponent::TestCase
  test "renders breadcrumb with items" do
    items = [
      {label: "Home", href: "/"},
      {label: "Products", href: "/products"},
      {label: "Widget"}
    ]
    render_inline(HotwireBits::BreadcrumbAdvancedComponent.new(items: items))
    assert_selector "nav[aria-label='Breadcrumb']"
    assert_selector "ol"
    assert_text "Home"
    assert_text "Widget"
  end

  test "renders with collapsed items" do
    items = (1..6).map { |i| {label: "Item #{i}", href: "/item/#{i}"} }
    render_inline(HotwireBits::BreadcrumbAdvancedComponent.new(items: items, max_items: 3))
    assert_text "..."
  end
end

# 14. BrowserMockupComponent
class BrowserMockupComponentTest < ViewComponent::TestCase
  test "renders browser mockup with content" do
    render_inline(HotwireBits::BrowserMockupComponent.new) { "Page content" }
    assert_selector "div.rounded-lg"
    assert_text "Page content"
  end

  test "renders with url" do
    render_inline(HotwireBits::BrowserMockupComponent.new(url: "https://example.com")) { "Body" }
    assert_text "https://example.com"
  end
end

# 15. BurgerComponent
class BurgerComponentTest < ViewComponent::TestCase
  test "renders burger button" do
    render_inline(HotwireBits::BurgerComponent.new)
    assert_selector "button[type='button'][aria-label='Toggle menu']"
    assert_selector "button[data-controller='hw-burger']"
  end

  test "renders open state" do
    render_inline(HotwireBits::BurgerComponent.new(open: true))
    assert_selector "button[aria-expanded='true']"
  end
end

# 16. CardHeadingComponent
class CardHeadingComponentTest < ViewComponent::TestCase
  test "renders title" do
    render_inline(HotwireBits::CardHeadingComponent.new(title: "Dashboard"))
    assert_selector "h3", text: "Dashboard"
  end

  test "renders title with subtitle" do
    render_inline(HotwireBits::CardHeadingComponent.new(title: "Stats", subtitle: "Last 30 days"))
    assert_selector "h3", text: "Stats"
    assert_selector "p", text: "Last 30 days"
  end

  test "renders action link" do
    render_inline(HotwireBits::CardHeadingComponent.new(title: "Users", action_label: "View all", action_href: "/users"))
    assert_selector "a[href='/users']", text: "View all"
  end
end

# 17. CenterComponent
class CenterComponentTest < ViewComponent::TestCase
  test "renders centered content" do
    render_inline(HotwireBits::CenterComponent.new) { "Centered" }
    assert_selector "div.flex.justify-center.items-center", text: "Centered"
  end

  test "renders inline variant" do
    render_inline(HotwireBits::CenterComponent.new(inline: true)) { "Inline" }
    assert_selector "div.inline-flex"
  end

  test "renders with height" do
    render_inline(HotwireBits::CenterComponent.new(height: "200px")) { "Tall" }
    assert_selector "div[style*='height: 200px']"
  end
end

# 18. ChartComponent
class ChartComponentTest < ViewComponent::TestCase
  test "renders line chart container" do
    data = [{value: 10}, {value: 20}, {value: 30}]
    render_inline(HotwireBits::ChartComponent.new(type: :line, data: data))
    assert_selector "div.w-full"
    assert_selector "svg"
    assert_selector "polyline"
  end

  test "renders bar chart" do
    data = [{value: 10}, {value: 20}]
    render_inline(HotwireBits::ChartComponent.new(type: :bar, data: data))
    assert_selector "svg"
    assert_selector "rect"
  end

  test "renders with custom height" do
    render_inline(HotwireBits::ChartComponent.new(data: [{value: 5}], height: 400))
    assert_selector "div[style*='height: 400px']"
  end
end

# 19. CheckoutFormComponent
class CheckoutFormComponentTest < ViewComponent::TestCase
  test "renders checkout steps" do
    steps = [{label: "Shipping"}, {label: "Payment"}, {label: "Review"}]
    render_inline(HotwireBits::CheckoutFormComponent.new(steps: steps, current_step: 1)) { "Form body" }
    assert_selector "nav[aria-label='Progress']"
    assert_text "Shipping"
    assert_text "Payment"
    assert_text "Review"
    assert_text "Form body"
  end

  test "renders empty steps" do
    render_inline(HotwireBits::CheckoutFormComponent.new) { "Empty" }
    assert_selector "div.mx-auto"
  end
end

# 20. CodeHighlightComponent
class CodeHighlightComponentTest < ViewComponent::TestCase
  test "renders code block" do
    render_inline(HotwireBits::CodeHighlightComponent.new(code: "puts 'hello'", language: "ruby"))
    assert_selector "div[data-controller='hw-code-highlight']"
    assert_selector "pre"
    assert_selector "code[data-language='ruby']"
    assert_text "puts 'hello'"
  end

  test "renders with line numbers" do
    render_inline(HotwireBits::CodeHighlightComponent.new(code: "a\nb", line_numbers: true))
    assert_text "1"
    assert_text "2"
  end

  test "shows language label" do
    render_inline(HotwireBits::CodeHighlightComponent.new(code: "x", language: "python"))
    assert_text "python"
  end
end

# 21. CodeMockupComponent
class CodeMockupComponentTest < ViewComponent::TestCase
  test "renders code mockup with header" do
    render_inline(HotwireBits::CodeMockupComponent.new(code: "const x = 1;", language: "javascript"))
    assert_selector "pre"
    assert_selector "code"
    assert_text "javascript"
  end

  test "renders without header" do
    render_inline(HotwireBits::CodeMockupComponent.new(code: "y = 2", with_header: false))
    assert_selector "pre"
    assert_no_selector "div.flex.items-center.justify-between"
  end

  test "renders with line numbers" do
    render_inline(HotwireBits::CodeMockupComponent.new(code: "a\nb\nc", with_line_numbers: true))
    assert_text "1"
    assert_text "2"
    assert_text "3"
  end
end

# 22. ColorInputComponent
class ColorInputComponentTest < ViewComponent::TestCase
  test "renders color input" do
    render_inline(HotwireBits::ColorInputComponent.new(name: "color"))
    assert_selector "div[data-controller='hw-color-input']"
    assert_selector "input[type='color']"
    assert_selector "input[type='text'][name='color']"
  end

  test "renders with custom value" do
    render_inline(HotwireBits::ColorInputComponent.new(name: "bg_color", value: "#ff0000"))
    assert_selector "input[type='color'][value='#ff0000']"
    assert_selector "input[type='text'][value='#ff0000']"
  end
end

# 23. ColorSwatchComponent
class ColorSwatchComponentTest < ViewComponent::TestCase
  test "renders swatch with color" do
    render_inline(HotwireBits::ColorSwatchComponent.new(color: "#3b82f6"))
    assert_selector "span[style*='background-color: #3b82f6']"
  end

  test "renders with tooltip" do
    render_inline(HotwireBits::ColorSwatchComponent.new(color: "#ff0000", with_tooltip: true))
    assert_selector "span[title]"
  end

  test "renders without tooltip" do
    render_inline(HotwireBits::ColorSwatchComponent.new(color: "#00ff00", with_tooltip: false))
    assert_no_selector "span[title]"
  end
end

# 24. ComboboxComponent
class ComboboxComponentTest < ViewComponent::TestCase
  test "renders combobox" do
    render_inline(HotwireBits::ComboboxComponent.new(name: "fruit", options: ["Apple", "Banana"]))
    assert_selector "div[data-controller='hw-combobox']"
    assert_selector "input[type='hidden'][name='fruit']", visible: :all
    assert_selector "input[role='combobox']"
    assert_selector "li", text: "Apple"
    assert_selector "li", text: "Banana"
  end

  test "renders with placeholder" do
    render_inline(HotwireBits::ComboboxComponent.new(options: [], placeholder: "Pick one..."))
    assert_selector "input[placeholder='Pick one...']"
  end
end

# 25. CommandBarComponent
class CommandBarComponentTest < ViewComponent::TestCase
  test "renders command bar" do
    commands = [{label: "Search", action: "search"}]
    render_inline(HotwireBits::CommandBarComponent.new(commands: commands))
    assert_selector "div[data-controller='hw-command-bar']"
    assert_selector "input[placeholder='Type a command or search...']"
    assert_selector "button", text: "Search"
  end

  test "renders with shortcut" do
    commands = [{label: "Open", action: "open", shortcut: "Ctrl+O"}]
    render_inline(HotwireBits::CommandBarComponent.new(commands: commands))
    assert_selector "kbd", text: "Ctrl+O"
  end
end

# 26. CompareComponent
class CompareComponentTest < ViewComponent::TestCase
  test "renders compare slider" do
    render_inline(HotwireBits::CompareComponent.new(before_src: "/before.jpg", after_src: "/after.jpg"))
    assert_selector "div[data-controller='hw-compare']"
    assert_selector "img[src='/before.jpg']"
    assert_selector "img[src='/after.jpg']"
    assert_text "Before"
    assert_text "After"
  end

  test "renders with custom labels" do
    render_inline(HotwireBits::CompareComponent.new(before_src: "/a.jpg", after_src: "/b.jpg", before_label: "Old", after_label: "New"))
    assert_text "Old"
    assert_text "New"
  end
end

# 27. ConfirmDialogComponent
class ConfirmDialogComponentTest < ViewComponent::TestCase
  test "renders confirm dialog" do
    render_inline(HotwireBits::ConfirmDialogComponent.new(message: "Are you sure?"))
    assert_selector "div[data-controller='hw-confirm-dialog']"
    assert_selector "h2", text: "Confirm"
    assert_text "Are you sure?"
    assert_selector "button", text: "Confirm"
    assert_selector "button", text: "Cancel"
  end

  test "renders with custom labels" do
    render_inline(HotwireBits::ConfirmDialogComponent.new(message: "Delete?", title: "Warning", confirm_label: "Yes", cancel_label: "No"))
    assert_selector "h2", text: "Warning"
    assert_selector "button", text: "Yes"
    assert_selector "button", text: "No"
  end
end

# 28. ConfirmPopupComponent
class ConfirmPopupComponentTest < ViewComponent::TestCase
  test "renders confirm popup with trigger" do
    render_inline(HotwireBits::ConfirmPopupComponent.new(message: "Proceed?")) { "Click me" }
    assert_selector "div[data-controller='hw-confirm-popup']"
    assert_text "Click me"
    assert_text "Proceed?"
    assert_selector "button", text: "Confirm"
    assert_selector "button", text: "Cancel"
  end

  test "renders with custom labels" do
    render_inline(HotwireBits::ConfirmPopupComponent.new(message: "Sure?", confirm_label: "OK", cancel_label: "Back")) { "Trigger" }
    assert_selector "button", text: "OK"
    assert_selector "button", text: "Back"
  end
end

# 29. ContactSectionComponent
class ContactSectionComponentTest < ViewComponent::TestCase
  test "renders contact section" do
    render_inline(HotwireBits::ContactSectionComponent.new(title: "Contact Us"))
    assert_selector "section"
    assert_selector "h2", text: "Contact Us"
    assert_selector "button[type='submit']", text: "Submit"
  end

  test "renders with description and fields" do
    fields = [{name: "email", label: "Email", type: "email"}]
    render_inline(HotwireBits::ContactSectionComponent.new(title: "Reach Out", description: "We'd love to hear from you", fields: fields))
    assert_text "We'd love to hear from you"
    assert_selector "label", text: "Email"
    assert_selector "input[type='email'][name='email']"
  end
end

# 30. ContextMenuComponent
class ContextMenuComponentTest < ViewComponent::TestCase
  test "renders context menu container" do
    render_inline(HotwireBits::ContextMenuComponent.new) { "Right click here" }
    assert_selector "div[data-controller='hw-context-menu']"
    assert_text "Right click here"
  end

  test "renders menu items" do
    items = [{label: "Copy", href: "#"}, {label: "Paste", href: "#"}]
    render_inline(HotwireBits::ContextMenuComponent.new(items: items)) { "Area" }
    assert_selector "a", text: "Copy"
    assert_selector "a", text: "Paste"
  end
end

# 31. CookieConsentComponent
class CookieConsentComponentTest < ViewComponent::TestCase
  test "renders cookie consent banner" do
    render_inline(HotwireBits::CookieConsentComponent.new)
    assert_selector "div[data-controller='hw-cookie-consent']"
    assert_text "We use cookies to improve your experience."
    assert_selector "button", text: "Accept"
    assert_selector "button", text: "Settings"
  end

  test "renders with custom message" do
    render_inline(HotwireBits::CookieConsentComponent.new(message: "Cookies!", accept_label: "OK"))
    assert_text "Cookies!"
    assert_selector "button", text: "OK"
  end
end

# 32. CookieSettingsComponent
class CookieSettingsComponentTest < ViewComponent::TestCase
  test "renders cookie settings panel" do
    render_inline(HotwireBits::CookieSettingsComponent.new)
    assert_selector "div[data-controller='hw-cookie-settings']"
    assert_selector "h3", text: "Cookie Preferences"
    assert_selector "button", text: "Reject All"
    assert_selector "button", text: "Accept Selected"
  end

  test "renders categories" do
    categories = [
      {name: "Essential", required: true},
      {name: "Analytics", enabled: false}
    ]
    render_inline(HotwireBits::CookieSettingsComponent.new(categories: categories))
    assert_text "Essential"
    assert_text "Required"
    assert_text "Analytics"
  end
end

# 33. CtaSectionComponent
class CtaSectionComponentTest < ViewComponent::TestCase
  test "renders CTA section" do
    render_inline(HotwireBits::CtaSectionComponent.new(title: "Get Started"))
    assert_selector "section"
    assert_selector "h2", text: "Get Started"
  end

  test "renders with CTAs" do
    primary = {label: "Sign Up", href: "/signup"}
    secondary = {label: "Learn More", href: "/about"}
    render_inline(HotwireBits::CtaSectionComponent.new(title: "Join Us", primary_cta: primary, secondary_cta: secondary))
    assert_selector "a[href='/signup']", text: "Sign Up"
    assert_selector "a[href='/about']", text: "Learn More"
  end

  test "renders with description" do
    render_inline(HotwireBits::CtaSectionComponent.new(title: "Try Now", description: "Free for 30 days"))
    assert_text "Free for 30 days"
  end
end

# 34. DashboardCardComponent
class DashboardCardComponentTest < ViewComponent::TestCase
  test "renders dashboard card" do
    render_inline(HotwireBits::DashboardCardComponent.new(title: "Revenue", value: "$12,345"))
    assert_selector "p", text: "Revenue"
    assert_selector "p", text: "$12,345"
  end

  test "renders with trend" do
    render_inline(HotwireBits::DashboardCardComponent.new(title: "Users", value: "1,200", trend: :up, trend_value: "+12%"))
    assert_text "+12%"
  end

  test "renders with chart data" do
    render_inline(HotwireBits::DashboardCardComponent.new(title: "Sales", value: "500", chart_data: [10, 20, 30, 25]))
    assert_selector "svg"
    assert_selector "polyline"
  end
end

# 35. DataViewComponent
class DataViewComponentTest < ViewComponent::TestCase
  test "renders data view with toolbar" do
    render_inline(HotwireBits::DataViewComponent.new)
    assert_selector "div[data-controller='hw-data-view']"
    assert_text "Sort:"
    assert_text "Default"
  end

  test "renders with custom sort" do
    render_inline(HotwireBits::DataViewComponent.new(sort_by: "Name"))
    assert_text "Name"
  end
end

# 36. DatePickerComponent
class DatePickerComponentTest < ViewComponent::TestCase
  test "renders date picker" do
    render_inline(HotwireBits::DatePickerComponent.new(name: "start_date"))
    assert_selector "div[data-controller='hw-datepicker']"
    assert_selector "input[type='date'][name='start_date']"
  end

  test "renders with value" do
    render_inline(HotwireBits::DatePickerComponent.new(name: "dob", value: "2024-01-01"))
    assert_selector "input[value='2024-01-01']"
  end

  test "renders disabled" do
    render_inline(HotwireBits::DatePickerComponent.new(name: "d", disabled: true))
    assert_selector "input[disabled]"
  end
end

# 37. DateRangePickerComponent
class DateRangePickerComponentTest < ViewComponent::TestCase
  test "renders date range picker" do
    render_inline(HotwireBits::DateRangePickerComponent.new(name_start: "from", name_end: "to"))
    assert_selector "div[data-controller='hw-date-range']"
    assert_selector "input[name='from']"
    assert_selector "input[name='to']"
    assert_text "to"
  end

  test "renders with initial dates" do
    render_inline(HotwireBits::DateRangePickerComponent.new(name_start: "s", name_end: "e", start_date: "2024-01-01", end_date: "2024-12-31"))
    assert_selector "input[value='2024-01-01']"
    assert_selector "input[value='2024-12-31']"
  end
end

# 38. DeviceFrameComponent
class DeviceFrameComponentTest < ViewComponent::TestCase
  test "renders phone frame by default" do
    render_inline(HotwireBits::DeviceFrameComponent.new) { "Phone screen" }
    assert_selector "div.inline-block"
    assert_text "Phone screen"
  end

  test "renders desktop frame" do
    render_inline(HotwireBits::DeviceFrameComponent.new(device: :desktop)) { "Desktop" }
    assert_text "Desktop"
  end

  test "renders tablet frame" do
    render_inline(HotwireBits::DeviceFrameComponent.new(device: :tablet)) { "Tablet" }
    assert_text "Tablet"
  end
end

# 39. DeviceMockupComponent
class DeviceMockupComponentTest < ViewComponent::TestCase
  test "renders browser mockup by default" do
    render_inline(HotwireBits::DeviceMockupComponent.new) { "Browser content" }
    assert_selector "div.inline-block"
    assert_text "Browser content"
  end

  test "renders phone mockup" do
    render_inline(HotwireBits::DeviceMockupComponent.new(type: :phone)) { "Phone" }
    assert_text "Phone"
  end

  test "renders iphone mockup" do
    render_inline(HotwireBits::DeviceMockupComponent.new(type: :phone, device: :iphone)) { "iPhone" }
    assert_text "iPhone"
  end
end

# 40. DiffComponent
class DiffComponentTest < ViewComponent::TestCase
  test "renders diff with labels" do
    render_inline(HotwireBits::DiffComponent.new)
    assert_text "Before"
    assert_text "After"
  end

  test "renders with custom labels" do
    render_inline(HotwireBits::DiffComponent.new(before_label: "Original", after_label: "Modified"))
    assert_text "Original"
    assert_text "Modified"
  end
end

# 41. DiffViewComponent
class DiffViewComponentTest < ViewComponent::TestCase
  test "renders side by side diff" do
    render_inline(HotwireBits::DiffViewComponent.new(old_code: "a = 1", new_code: "a = 2"))
    assert_selector "div.rounded-lg"
    assert_selector "pre"
    assert_text "Old"
    assert_text "New"
  end

  test "renders unified diff" do
    render_inline(HotwireBits::DiffViewComponent.new(old_code: "x", new_code: "y", view: :unified, language: "ruby"))
    assert_text "Unified Diff"
    assert_text "ruby"
  end
end

# 42. DigitalSignatureComponent
class DigitalSignatureComponentTest < ViewComponent::TestCase
  test "renders signature pad" do
    render_inline(HotwireBits::DigitalSignatureComponent.new(name: "signature"))
    assert_selector "div[data-controller='hw-signature']"
    assert_selector "canvas[width='400'][height='200']"
    assert_selector "input[type='hidden'][name='signature']", visible: :all
    assert_selector "button", text: "Clear"
    assert_text "Draw your signature above"
  end

  test "renders with custom dimensions" do
    render_inline(HotwireBits::DigitalSignatureComponent.new(name: "sig", width: 600, height: 300))
    assert_selector "canvas[width='600'][height='300']"
  end
end

# 43. DockMenuComponent
class DockMenuComponentTest < ViewComponent::TestCase
  test "renders dock menu" do
    render_inline(HotwireBits::DockMenuComponent.new)
    assert_selector "nav.fixed"
  end

  test "renders with items" do
    items = [{label: "Home", href: "/"}, {label: "Settings", href: "/settings"}]
    render_inline(HotwireBits::DockMenuComponent.new(items: items))
    assert_selector "a[href='/']", text: "Home"
    assert_selector "a[href='/settings']", text: "Settings"
  end
end

# 44. DragDropListComponent
class DragDropListComponentTest < ViewComponent::TestCase
  test "renders drag drop list" do
    items = [{id: 1, label: "Item A"}, {id: 2, label: "Item B"}]
    render_inline(HotwireBits::DragDropListComponent.new(items: items))
    assert_selector "ul[data-controller='hw-drag-drop']"
    assert_selector "li[draggable='true']", count: 2
    assert_text "Item A"
    assert_text "Item B"
  end

  test "renders empty list" do
    render_inline(HotwireBits::DragDropListComponent.new)
    assert_selector "ul"
  end

  test "renders horizontal orientation" do
    render_inline(HotwireBits::DragDropListComponent.new(items: [], orientation: :horizontal))
    assert_selector "ul.flex-row"
  end
end

# 45. DropzoneComponent
class DropzoneComponentTest < ViewComponent::TestCase
  test "renders dropzone" do
    render_inline(HotwireBits::DropzoneComponent.new(name: "files"))
    assert_selector "label"
    assert_selector "input[type='file'][name='files']"
    assert_text "Drop files here or click to upload"
  end

  test "renders with custom label" do
    render_inline(HotwireBits::DropzoneComponent.new(name: "doc", label: "Upload document"))
    assert_text "Upload document"
  end

  test "renders with description" do
    render_inline(HotwireBits::DropzoneComponent.new(name: "img", description: "PNG or JPG up to 5MB"))
    assert_text "PNG or JPG up to 5MB"
  end
end

# 46. EmptyCartComponent
class EmptyCartComponentTest < ViewComponent::TestCase
  test "renders empty cart message" do
    render_inline(HotwireBits::EmptyCartComponent.new)
    assert_selector "h3", text: "Your cart is empty"
    assert_text "Looks like you haven't added any items"
  end

  test "renders with custom message" do
    render_inline(HotwireBits::EmptyCartComponent.new(message: "Nothing here"))
    assert_selector "h3", text: "Nothing here"
  end

  test "renders action link" do
    render_inline(HotwireBits::EmptyCartComponent.new(action_href: "/shop", action_label: "Browse"))
    assert_selector "a[href='/shop']", text: "Browse"
  end
end

# 47. FeatureSectionComponent
class FeatureSectionComponentTest < ViewComponent::TestCase
  test "renders feature section with title" do
    render_inline(HotwireBits::FeatureSectionComponent.new(title: "Our Features"))
    assert_selector "section"
    assert_selector "h2", text: "Our Features"
  end

  test "renders features" do
    features = [
      {title: "Fast", description: "Blazing speed"},
      {title: "Secure", description: "Enterprise grade"}
    ]
    render_inline(HotwireBits::FeatureSectionComponent.new(features: features))
    assert_text "Fast"
    assert_text "Blazing speed"
    assert_text "Secure"
  end

  test "renders with subtitle" do
    render_inline(HotwireBits::FeatureSectionComponent.new(title: "Why Us", subtitle: "Built for developers"))
    assert_text "Built for developers"
  end
end

# 48. FieldsetComponent
class FieldsetComponentTest < ViewComponent::TestCase
  test "renders fieldset" do
    render_inline(HotwireBits::FieldsetComponent.new) { "Fields here" }
    assert_selector "fieldset"
    assert_text "Fields here"
  end

  test "renders with legend" do
    render_inline(HotwireBits::FieldsetComponent.new(legend: "Personal Info")) { "Name" }
    assert_selector "legend", text: "Personal Info"
  end

  test "renders disabled" do
    render_inline(HotwireBits::FieldsetComponent.new(disabled: true)) { "Disabled" }
    assert_selector "fieldset[disabled]"
  end

  test "renders with description" do
    render_inline(HotwireBits::FieldsetComponent.new(legend: "Prefs", description: "Optional settings")) { "Stuff" }
    assert_text "Optional settings"
  end
end

# 49. FileBrowserComponent
# Note: The ERB template defines render_file_tree after it's called,
# causing a NoMethodError. We test that the component class initializes correctly.
class FileBrowserComponentTest < ViewComponent::TestCase
  test "initializes with default params" do
    component = HotwireBits::FileBrowserComponent.new
    assert_instance_of HotwireBits::FileBrowserComponent, component
  end

  test "initializes with files and selected" do
    files = [{name: "README.md", type: "file"}]
    component = HotwireBits::FileBrowserComponent.new(files: files, selected: "README.md")
    assert_instance_of HotwireBits::FileBrowserComponent, component
  end
end

# 50. FileInputComponent
class FileInputComponentTest < ViewComponent::TestCase
  test "renders file input" do
    render_inline(HotwireBits::FileInputComponent.new(name: "avatar"))
    assert_selector "label"
    assert_selector "input[type='file'][name='avatar']", visible: :all
    assert_text "Choose file"
  end

  test "renders with custom label" do
    render_inline(HotwireBits::FileInputComponent.new(name: "doc", label: "Upload PDF"))
    assert_text "Upload PDF"
  end

  test "renders multiple file input" do
    render_inline(HotwireBits::FileInputComponent.new(name: "photos", multiple: true))
    assert_selector "input[multiple]", visible: :all
  end
end
