# frozen_string_literal: true

require "test_helper"

class FileUploadProgressComponentTest < ViewComponent::TestCase
  test "renders uploading state with file name and progress" do
    render_inline(HotwireBits::FileUploadProgressComponent.new(file_name: "report.pdf", progress: 45))

    assert_selector "p", text: "report.pdf"
    assert_text "Uploading... 45%"
  end

  test "renders complete state" do
    render_inline(HotwireBits::FileUploadProgressComponent.new(file_name: "report.pdf", progress: 100, status: :complete))

    assert_selector "p", text: "report.pdf"
    assert_text "Upload complete"
    assert_selector "button[aria-label='Dismiss']"
  end

  test "renders error state" do
    render_inline(HotwireBits::FileUploadProgressComponent.new(file_name: "report.pdf", status: :error))

    assert_text "Upload failed"
    assert_selector "button[aria-label='Dismiss']"
  end
end

class FloatLabelComponentTest < ViewComponent::TestCase
  test "renders label with content block" do
    render_inline(HotwireBits::FloatLabelComponent.new(label: "Email", name: "email")) { '<input type="text" id="email">'.html_safe }

    assert_selector "div.relative"
    assert_selector "label[for='email']", text: "Email"
  end

  test "renders without name" do
    render_inline(HotwireBits::FloatLabelComponent.new(label: "Name")) { "input" }

    assert_selector "label", text: "Name"
  end
end

class FluidComponentTest < ViewComponent::TestCase
  test "renders with w-full class and block content" do
    render_inline(HotwireBits::FluidComponent.new) { "Full width content" }

    assert_selector "div.w-full", text: "Full width content"
  end
end

class FlyoutMenuComponentTest < ViewComponent::TestCase
  test "renders trigger label" do
    render_inline(HotwireBits::FlyoutMenuComponent.new(trigger_label: "Products"))

    assert_selector "button", text: "Products"
  end

  test "renders with items" do
    items = [{label: "Analytics", href: "/analytics", description: "Track your data"}]
    render_inline(HotwireBits::FlyoutMenuComponent.new(trigger_label: "Menu", items: items))

    assert_selector "button", text: "Menu"
    assert_selector "a[href='/analytics']"
    assert_selector "p", text: "Analytics"
  end
end

class FormGroupComponentTest < ViewComponent::TestCase
  test "renders vertical form group with label" do
    render_inline(HotwireBits::FormGroupComponent.new(label: "Username", name: "username")) { '<input type="text">'.html_safe }

    assert_selector "label[for='username']", text: "Username"
  end

  test "renders with error message" do
    render_inline(HotwireBits::FormGroupComponent.new(label: "Email", error: "is required")) { "input" }

    assert_selector "p", text: "is required"
  end

  test "renders required indicator" do
    render_inline(HotwireBits::FormGroupComponent.new(label: "Name", required: true)) { "input" }

    assert_selector "label", text: /Name/
    assert_selector "span", text: "*"
  end
end

class GalleryComponentTest < ViewComponent::TestCase
  test "renders empty gallery" do
    render_inline(HotwireBits::GalleryComponent.new(images: [], with_lightbox: false))

    assert_selector "div"
  end

  test "renders gallery with images" do
    images = [{src: "/img1.jpg", alt: "Image 1"}, {src: "/img2.jpg", alt: "Image 2"}]
    render_inline(HotwireBits::GalleryComponent.new(images: images, with_lightbox: false))

    assert_selector "img[src='/img1.jpg']"
    assert_selector "img[src='/img2.jpg']"
    assert_selector "figure", count: 2
  end
end

class GroupComponentTest < ViewComponent::TestCase
  test "renders with default flex classes" do
    render_inline(HotwireBits::GroupComponent.new) { "items" }

    assert_selector "div", text: "items"
  end

  test "renders with gap and wrap" do
    render_inline(HotwireBits::GroupComponent.new(gap: 4, wrap: true)) { "content" }

    assert_selector "div", text: "content"
  end
end

class HeaderComponentTest < ViewComponent::TestCase
  test "renders header element" do
    render_inline(HotwireBits::HeaderComponent.new)

    assert_selector "header"
  end

  test "renders with brand" do
    render_inline(HotwireBits::HeaderComponent.new(brand: "MySite"))

    assert_selector "header"
    assert_selector "a[href='/']", text: "MySite"
  end

  test "renders nav items" do
    items = [{label: "Home", href: "/", active: true}, {label: "About", href: "/about"}]
    render_inline(HotwireBits::HeaderComponent.new(nav_items: items))

    assert_selector "nav"
    assert_selector "a[href='/']", text: "Home"
    assert_selector "a[href='/about']", text: "About"
  end
end

class HeaderSectionComponentTest < ViewComponent::TestCase
  test "renders title" do
    render_inline(HotwireBits::HeaderSectionComponent.new(title: "Dashboard"))

    assert_selector "header"
    assert_selector "h1", text: "Dashboard"
  end

  test "renders with subtitle" do
    render_inline(HotwireBits::HeaderSectionComponent.new(title: "Settings", subtitle: "Manage your account"))

    assert_selector "h1", text: "Settings"
    assert_selector "p", text: "Manage your account"
  end

  test "renders breadcrumbs" do
    crumbs = [{label: "Home", href: "/"}, {label: "Settings"}]
    render_inline(HotwireBits::HeaderSectionComponent.new(title: "Settings", breadcrumbs: crumbs))

    assert_selector "nav[aria-label='Breadcrumb']"
    assert_selector "a[href='/']", text: "Home"
    assert_selector "span", text: "Settings"
  end
end

class Hover3dCardComponentTest < ViewComponent::TestCase
  test "renders card with block content" do
    render_inline(HotwireBits::Hover3dCardComponent.new) { "Card content" }

    assert_selector "div[data-controller='hover-3d']"
    assert_text "Card content"
  end

  test "renders with custom intensity" do
    render_inline(HotwireBits::Hover3dCardComponent.new(intensity: 20)) { "content" }

    assert_selector "div[data-hover-3d-intensity-value='20']"
  end
end

class HoverCardComponentTest < ViewComponent::TestCase
  test "renders hover card with default trigger" do
    render_inline(HotwireBits::HoverCardComponent.new) { "Card body" }

    assert_selector "div[data-controller='hw-hover-card']"
    assert_selector "a", text: "Hover"
    assert_text "Card body"
  end

  test "renders with content block" do
    render_inline(HotwireBits::HoverCardComponent.new) { "User profile info" }

    assert_text "User profile info"
  end
end

class HoverGalleryComponentTest < ViewComponent::TestCase
  test "renders empty gallery" do
    render_inline(HotwireBits::HoverGalleryComponent.new(images: []))

    assert_selector "div.relative"
  end

  test "renders with images and custom height" do
    images = [{src: "/a.jpg", alt: "A"}, {src: "/b.jpg", alt: "B"}]
    render_inline(HotwireBits::HoverGalleryComponent.new(images: images, height: 400))

    assert_selector "div[style*='height: 400px']"
    assert_selector "img[src='/a.jpg']"
    assert_selector "img[src='/b.jpg']"
  end
end

class IconFieldComponentTest < ViewComponent::TestCase
  test "renders icon on the left by default" do
    icon_svg = '<svg class="h-4 w-4"><path d="M10 10"/></svg>'
    render_inline(HotwireBits::IconFieldComponent.new(icon: icon_svg)) { '<input type="text">'.html_safe }

    assert_selector "div.relative"
    assert_selector "div.left-3"
  end

  test "renders icon on the right" do
    icon_svg = '<svg class="h-4 w-4"><path d="M10 10"/></svg>'
    render_inline(HotwireBits::IconFieldComponent.new(icon: icon_svg, position: :right)) { '<input type="text">'.html_safe }

    assert_selector "div.right-3"
  end
end

class IftaLabelComponentTest < ViewComponent::TestCase
  test "renders label above content" do
    render_inline(HotwireBits::IftaLabelComponent.new(label: "Email", name: "email")) { '<input type="text">'.html_safe }

    assert_selector "div.relative"
    assert_selector "label[for='email']", text: "Email"
  end
end

class ImageCompareComponentTest < ViewComponent::TestCase
  test "renders before and after images" do
    render_inline(HotwireBits::ImageCompareComponent.new(before_src: "/before.jpg", after_src: "/after.jpg"))

    assert_selector "div[data-controller='hw-image-compare']"
    assert_selector "img[src='/before.jpg']"
    assert_selector "img[src='/after.jpg']"
    assert_selector "span", text: "Before"
    assert_selector "span", text: "After"
  end

  test "renders with custom labels" do
    render_inline(HotwireBits::ImageCompareComponent.new(
      before_src: "/a.jpg", after_src: "/b.jpg",
      before_label: "Original", after_label: "Edited"
    ))

    assert_selector "span", text: "Original"
    assert_selector "span", text: "Edited"
  end
end

class ImageComponentTest < ViewComponent::TestCase
  test "renders image with src and alt" do
    render_inline(HotwireBits::ImageComponent.new(src: "/photo.jpg", alt: "A photo"))

    assert_selector "figure"
    assert_selector "img[src='/photo.jpg'][alt='A photo']"
  end

  test "renders with caption" do
    render_inline(HotwireBits::ImageComponent.new(src: "/photo.jpg", alt: "Photo", caption: "Nice view"))

    assert_selector "figcaption", text: "Nice view"
  end

  test "renders with width and height" do
    render_inline(HotwireBits::ImageComponent.new(src: "/photo.jpg", alt: "Photo", width: 300, height: 200))

    assert_selector "img[width='300'][height='200']"
  end
end

class ImageZoomComponentTest < ViewComponent::TestCase
  test "renders zoomable image" do
    render_inline(HotwireBits::ImageZoomComponent.new(src: "/zoom.jpg", alt: "Zoomable"))

    assert_selector "div[data-controller='hw-image-zoom']"
    assert_selector "img[src='/zoom.jpg']"
  end

  test "renders with custom zoom level" do
    render_inline(HotwireBits::ImageZoomComponent.new(src: "/zoom.jpg", zoom_level: 3))

    assert_selector "div[data-hw-image-zoom-zoom-level-value='3']"
  end
end

class IncentiveComponentTest < ViewComponent::TestCase
  test "renders icon and title" do
    render_inline(HotwireBits::IncentiveComponent.new(icon: "M12 2L2 7l10 5 10-5-10-5z", title: "Free Shipping"))

    assert_selector "h3", text: "Free Shipping"
    assert_selector "svg"
  end

  test "renders with description" do
    render_inline(HotwireBits::IncentiveComponent.new(
      icon: "M12 2L2 7l10 5 10-5-10-5z",
      title: "Returns",
      description: "30 day returns"
    ))

    assert_selector "h3", text: "Returns"
    assert_selector "p", text: "30 day returns"
  end
end

class IndicatorBadgeComponentTest < ViewComponent::TestCase
  test "renders badge with content" do
    render_inline(HotwireBits::IndicatorBadgeComponent.new(badge_content: "5")) { "<button>Inbox</button>".html_safe }

    assert_selector "span", text: "5"
    assert_text "Inbox"
  end

  test "renders dot badge" do
    render_inline(HotwireBits::IndicatorBadgeComponent.new(dot: true)) { "icon" }

    assert_selector "span"
    assert_no_text "5"
  end
end

class InlineEditComponentTest < ViewComponent::TestCase
  test "renders display value" do
    render_inline(HotwireBits::InlineEditComponent.new(name: "title", value: "Hello World"))

    assert_selector "span", text: "Hello World"
    assert_selector "button[aria-label='Edit']"
  end

  test "renders placeholder when no value" do
    render_inline(HotwireBits::InlineEditComponent.new(name: "title", placeholder: "Enter title"))

    assert_selector "span", text: "Enter title"
  end

  test "renders text input for editing" do
    render_inline(HotwireBits::InlineEditComponent.new(name: "field", value: "test"))

    assert_selector "input[name='field'][value='test']"
  end
end

class InplaceComponentTest < ViewComponent::TestCase
  test "renders display value" do
    render_inline(HotwireBits::InplaceComponent.new(value: "Current text"))

    assert_selector "div[data-controller='hw-inplace']"
    assert_text "Current text"
  end

  test "renders placeholder when no value" do
    render_inline(HotwireBits::InplaceComponent.new)

    assert_selector "span", text: "Click to edit"
  end

  test "renders hidden text input" do
    render_inline(HotwireBits::InplaceComponent.new(name: "note", value: "abc"))

    assert_selector "input[name='note'][value='abc']", visible: false
  end
end

class InputGroupComponentTest < ViewComponent::TestCase
  test "renders with addon before" do
    render_inline(HotwireBits::InputGroupComponent.new(addon_before: "https://")) { '<input type="text">'.html_safe }

    assert_selector "span", text: "https://"
  end

  test "renders with addon after" do
    render_inline(HotwireBits::InputGroupComponent.new(addon_after: ".com")) { '<input type="text">'.html_safe }

    assert_selector "span", text: ".com"
  end

  test "renders with both addons" do
    render_inline(HotwireBits::InputGroupComponent.new(addon_before: "https://", addon_after: ".com")) { '<input type="text">'.html_safe }

    assert_selector "span", text: "https://"
    assert_selector "span", text: ".com"
  end
end

class InputNumberComponentTest < ViewComponent::TestCase
  test "renders number input with increment and decrement buttons" do
    render_inline(HotwireBits::InputNumberComponent.new(name: "qty", value: 5))

    assert_selector "input[type='number'][value='5']"
    assert_selector "button", count: 2
  end

  test "renders with currency prefix" do
    render_inline(HotwireBits::InputNumberComponent.new(name: "price", value: 10, currency: "$"))

    assert_selector "span", text: "$"
    assert_selector "input[type='number']"
  end
end

class InputTagsComponentTest < ViewComponent::TestCase
  test "renders empty tags input" do
    render_inline(HotwireBits::InputTagsComponent.new)

    assert_selector "input[type='text'][placeholder='Add tag...']"
  end

  test "renders with existing tags" do
    render_inline(HotwireBits::InputTagsComponent.new(name: "tags", value: ["ruby", "rails"]))

    assert_selector "span", text: "ruby"
    assert_selector "span", text: "rails"
    assert_selector "input[type='hidden'][value='ruby']", visible: :all
    assert_selector "input[type='hidden'][value='rails']", visible: :all
  end
end

class JoinComponentTest < ViewComponent::TestCase
  test "renders horizontal join by default" do
    render_inline(HotwireBits::JoinComponent.new) { "joined items" }

    assert_selector "div.join.join-horizontal", text: "joined items"
  end

  test "renders vertical join" do
    render_inline(HotwireBits::JoinComponent.new(direction: :vertical)) { "items" }

    assert_selector "div.join.join-vertical"
  end
end

class JsonInputComponentTest < ViewComponent::TestCase
  test "renders textarea for JSON input" do
    render_inline(HotwireBits::JsonInputComponent.new(name: "config"))

    assert_selector "textarea[name='config']"
    assert_selector "div[data-controller='hw-json-input']"
  end

  test "renders with string value" do
    render_inline(HotwireBits::JsonInputComponent.new(name: "data", value: '{"key": "val"}'))

    assert_selector "textarea", text: '{"key": "val"}'
  end
end

class KnobComponentTest < ViewComponent::TestCase
  test "renders knob with default value" do
    render_inline(HotwireBits::KnobComponent.new)

    assert_selector "div[data-controller='hw-knob']"
    assert_selector "svg"
    assert_selector "input[type='range']"
    assert_selector "span", text: "0"
  end

  test "renders with custom value and range" do
    render_inline(HotwireBits::KnobComponent.new(value: 75, min: 0, max: 100))

    assert_selector "span", text: "75"
    assert_selector "input[type='range'][value='75'][min='0'][max='100']"
  end
end

class LightboxComponentTest < ViewComponent::TestCase
  test "renders lightbox overlay" do
    render_inline(HotwireBits::LightboxComponent.new(images: [{src: "/img.jpg", alt: "Test"}]))

    assert_selector "div[data-controller='hw-lightbox']"
    assert_selector "button", minimum: 3
    assert_selector "img"
  end
end

class LikeButtonComponentTest < ViewComponent::TestCase
  test "renders unliked state with count" do
    render_inline(HotwireBits::LikeButtonComponent.new(count: 42))

    assert_selector "button[aria-pressed='false']"
    assert_selector "span", text: "42"
  end

  test "renders liked state" do
    render_inline(HotwireBits::LikeButtonComponent.new(liked: true, count: 10))

    assert_selector "button[aria-pressed='true']"
    assert_selector "span", text: "10"
  end

  test "renders hidden input when name is provided" do
    render_inline(HotwireBits::LikeButtonComponent.new(name: "liked", liked: true))

    assert_selector "input[type='hidden'][name='liked']", visible: false
  end
end

class ListComponentTest < ViewComponent::TestCase
  test "renders list element" do
    render_inline(HotwireBits::ListComponent.new) { "<li>Item 1</li>".html_safe }

    assert_selector "ul[role='list']"
    assert_selector "li", text: "Item 1"
  end

  test "renders divided list by default" do
    render_inline(HotwireBits::ListComponent.new) { "items" }

    assert_selector "ul.divide-y"
  end
end

class ListboxComponentTest < ViewComponent::TestCase
  test "renders listbox with options" do
    options = [{label: "Apple", value: "apple"}, {label: "Banana", value: "banana"}]
    render_inline(HotwireBits::ListboxComponent.new(options: options))

    assert_selector "div[role='listbox']"
    assert_selector "div[role='option']", count: 2
    assert_selector "span", text: "Apple"
    assert_selector "span", text: "Banana"
  end

  test "renders with selected option" do
    options = [{label: "Apple", value: "apple"}, {label: "Banana", value: "banana"}]
    render_inline(HotwireBits::ListboxComponent.new(options: options, selected: "apple", name: "fruit"))

    assert_selector "div[role='option'][aria-selected='true']", count: 1
    assert_selector "input[type='hidden'][value='apple']", visible: false
  end
end

class LogoCloudComponentTest < ViewComponent::TestCase
  test "renders section element" do
    render_inline(HotwireBits::LogoCloudComponent.new)

    assert_selector "section"
  end

  test "renders with title" do
    render_inline(HotwireBits::LogoCloudComponent.new(title: "Trusted by"))

    assert_selector "p", text: "Trusted by"
  end

  test "renders logos" do
    logos = [{name: "Acme", url: "https://acme.com"}]
    render_inline(HotwireBits::LogoCloudComponent.new(logos: logos))

    assert_selector "a[href='https://acme.com']"
    assert_selector "span", text: "Acme"
  end
end

class LogoItemComponentTest < ViewComponent::TestCase
  test "renders logo with name as text" do
    render_inline(HotwireBits::LogoItemComponent.new(name: "Acme Corp"))

    assert_selector "a", text: "Acme Corp"
  end

  test "renders logo with image" do
    render_inline(HotwireBits::LogoItemComponent.new(name: "Acme", image_url: "/logo.png"))

    assert_selector "img[src='/logo.png'][alt='Acme']"
  end

  test "renders with url" do
    render_inline(HotwireBits::LogoItemComponent.new(name: "Acme", url: "https://acme.com"))

    assert_selector "a[href='https://acme.com']"
  end
end

class MarkComponentTest < ViewComponent::TestCase
  test "renders mark element with content" do
    render_inline(HotwireBits::MarkComponent.new) { "highlighted" }

    assert_selector "mark", text: "highlighted"
  end

  test "renders with custom color class" do
    render_inline(HotwireBits::MarkComponent.new(color: "bg-blue-200")) { "blue" }

    assert_selector "mark.bg-blue-200", text: "blue"
  end
end

class MaskComponentTest < ViewComponent::TestCase
  test "renders mask with default circle shape" do
    render_inline(HotwireBits::MaskComponent.new) { '<img src="/photo.jpg">'.html_safe }

    assert_selector "div.mask-circle"
  end

  test "renders hexagon shape" do
    render_inline(HotwireBits::MaskComponent.new(shape: :hexagon)) { "content" }

    assert_selector "div.mask-hexagon"
  end
end

class MegaMenuComponentTest < ViewComponent::TestCase
  test "renders trigger button" do
    render_inline(HotwireBits::MegaMenuComponent.new(trigger_label: "Products"))

    assert_selector "button", text: "Products"
    assert_selector "div[data-controller='hw-dropdown']"
  end

  test "renders with columns and links" do
    columns = [{
      title: "Features",
      links: [{label: "Analytics", href: "/analytics"}]
    }]
    render_inline(HotwireBits::MegaMenuComponent.new(trigger_label: "Menu", columns: columns))

    assert_selector "p", text: "Features"
    assert_selector "a[href='/analytics']", text: "Analytics"
  end
end

class MenubarComponentTest < ViewComponent::TestCase
  test "renders empty menubar" do
    render_inline(HotwireBits::MenubarComponent.new)

    assert_selector "div[data-controller='hw-menubar']"
  end

  test "renders with menu items" do
    items = [{label: "File", children: [{label: "New", href: "#"}]}]
    render_inline(HotwireBits::MenubarComponent.new(items: items))

    assert_selector "button", text: "File"
    assert_selector "a", text: "New"
  end
end

class MonthPickerComponentTest < ViewComponent::TestCase
  test "renders month picker grid" do
    render_inline(HotwireBits::MonthPickerComponent.new)

    assert_selector "div[data-controller='hw-month-picker']"
    assert_selector "button", text: "Jan"
    assert_selector "button", text: "Dec"
  end

  test "renders with hidden input and name" do
    render_inline(HotwireBits::MonthPickerComponent.new(name: "month"))

    assert_selector "input[type='hidden'][name='month']", visible: false
  end
end

class MonthPickerInputComponentTest < ViewComponent::TestCase
  test "renders month picker input with placeholder" do
    render_inline(HotwireBits::MonthPickerInputComponent.new)

    assert_selector "input[placeholder='Select month'][readonly]"
    assert_selector "div[data-controller='hw-month-picker-input']"
  end

  test "renders with hidden input for form submission" do
    render_inline(HotwireBits::MonthPickerInputComponent.new(name: "start_month"))

    assert_selector "input[type='hidden'][name='start_month']", visible: false
  end
end

class MultiselectComponentTest < ViewComponent::TestCase
  test "renders trigger with placeholder" do
    render_inline(HotwireBits::MultiselectComponent.new(placeholder: "Choose options"))

    assert_selector "button", text: "Choose options"
  end

  test "renders with options" do
    options = [["Apple", "apple"], ["Banana", "banana"]]
    render_inline(HotwireBits::MultiselectComponent.new(name: "fruits", options: options))

    assert_selector "input[type='checkbox'][value='apple']", visible: false
    assert_selector "input[type='checkbox'][value='banana']", visible: false
    assert_selector "span", text: "Apple"
    assert_selector "span", text: "Banana"
  end

  test "renders selected count" do
    options = [["Apple", "apple"], ["Banana", "banana"]]
    render_inline(HotwireBits::MultiselectComponent.new(options: options, selected: ["apple"]))

    assert_selector "span", text: "1 selected"
  end
end

class NativeSelectComponentTest < ViewComponent::TestCase
  test "renders select with placeholder" do
    render_inline(HotwireBits::NativeSelectComponent.new(name: "color"))

    assert_selector "select[name='color']"
    assert_selector "option", text: "Select..."
  end

  test "renders with options" do
    options = [["Red", "red"], ["Blue", "blue"]]
    render_inline(HotwireBits::NativeSelectComponent.new(name: "color", options: options))

    assert_selector "option[value='red']", text: "Red"
    assert_selector "option[value='blue']", text: "Blue"
  end

  test "renders with selected value" do
    options = [["Red", "red"], ["Blue", "blue"]]
    render_inline(HotwireBits::NativeSelectComponent.new(name: "color", options: options, selected: "blue"))

    assert_selector "option[value='blue'][selected]"
  end
end

class NavigationMenuComponentTest < ViewComponent::TestCase
  test "renders nav element" do
    render_inline(HotwireBits::NavigationMenuComponent.new)

    assert_selector "nav[data-controller='hw-nav-menu']"
  end

  test "renders with menu items" do
    items = [{label: "Home", href: "/"}, {label: "About", href: "/about"}]
    render_inline(HotwireBits::NavigationMenuComponent.new(items: items))

    assert_selector "a", text: "Home"
    assert_selector "a", text: "About"
  end
end

class NewsletterSectionComponentTest < ViewComponent::TestCase
  test "renders default title" do
    render_inline(HotwireBits::NewsletterSectionComponent.new)

    assert_selector "section"
    assert_selector "h2", text: "Subscribe to our newsletter"
    assert_selector "input[type='email']"
    assert_selector "button[type='submit']", text: "Subscribe"
  end

  test "renders with custom title and description" do
    render_inline(HotwireBits::NewsletterSectionComponent.new(
      title: "Stay updated",
      description: "Weekly digest"
    ))

    assert_selector "h2", text: "Stay updated"
    assert_selector "p", text: "Weekly digest"
  end

  test "renders privacy note" do
    render_inline(HotwireBits::NewsletterSectionComponent.new(privacy_note: "We respect your privacy"))

    assert_selector "p", text: "We respect your privacy"
  end
end

class NotificationBellComponentTest < ViewComponent::TestCase
  test "renders bell icon without count" do
    render_inline(HotwireBits::NotificationBellComponent.new)

    assert_selector "svg"
    assert_no_selector "span"
  end

  test "renders with notification count" do
    render_inline(HotwireBits::NotificationBellComponent.new(count: 5))

    assert_selector "span", text: "5"
  end

  test "renders as link when href provided" do
    render_inline(HotwireBits::NotificationBellComponent.new(href: "/notifications", count: 3))

    assert_selector "a[href='/notifications']"
    assert_selector "span", text: "3"
  end
end

class NotificationComponentTest < ViewComponent::TestCase
  test "renders notification with title and message" do
    render_inline(HotwireBits::NotificationComponent.new(title: "New message", message: "You have a new message"))

    assert_selector "div[data-controller='hw-notification']"
    assert_text "New message"
    assert_text "You have a new message"
  end

  test "renders with time" do
    render_inline(HotwireBits::NotificationComponent.new(title: "Alert", time: "5 min ago"))

    assert_selector "time", text: "5 min ago"
  end

  test "renders close button when closable" do
    render_inline(HotwireBits::NotificationComponent.new(title: "Info", closable: true))

    assert_selector "button"
    assert_selector "span.sr-only", text: "Dismiss", visible: false
  end
end

class NumberFormatterComponentTest < ViewComponent::TestCase
  test "renders formatted number" do
    render_inline(HotwireBits::NumberFormatterComponent.new(value: 1234567))

    assert_selector "span", text: /1.*234.*567/
  end
end

class NumberInputComponentTest < ViewComponent::TestCase
  test "renders number input" do
    render_inline(HotwireBits::NumberInputComponent.new(name: "amount"))

    assert_selector "input[type='number'][name='amount']"
  end

  test "renders with value and constraints" do
    render_inline(HotwireBits::NumberInputComponent.new(name: "qty", value: 10, min: 1, max: 100))

    assert_selector "input[type='number'][value='10'][min='1'][max='100']"
  end
end

class OrderSummaryComponentTest < ViewComponent::TestCase
  test "renders order summary heading" do
    render_inline(HotwireBits::OrderSummaryComponent.new)

    assert_selector "h3", text: "Order Summary"
  end

  test "renders with items" do
    items = [{name: "T-Shirt", quantity: 2, price: "$25.00"}]
    render_inline(HotwireBits::OrderSummaryComponent.new(items: items, subtotal: "$50.00", tax: "$4.00"))

    assert_selector "p", text: "T-Shirt"
    assert_text "Qty: 2"
    assert_text "$25.00"
    assert_text "Subtotal"
    assert_text "Tax"
  end
end

class OrgChartComponentTest < ViewComponent::TestCase
  test "renders empty org chart" do
    render_inline(HotwireBits::OrgChartComponent.new)

    assert_selector "div"
  end

  test "renders with nodes" do
    nodes = [{name: "Jane Doe", title: "CEO"}]
    render_inline(HotwireBits::OrgChartComponent.new(nodes: nodes))

    assert_selector "p", text: "Jane Doe"
    assert_selector "p", text: "CEO"
  end
end

class PageHeadingComponentTest < ViewComponent::TestCase
  test "renders title" do
    render_inline(HotwireBits::PageHeadingComponent.new(title: "Users"))

    assert_selector "h1", text: "Users"
  end

  test "renders with description" do
    render_inline(HotwireBits::PageHeadingComponent.new(title: "Users", description: "Manage all users"))

    assert_selector "h1", text: "Users"
    assert_selector "p", text: "Manage all users"
  end

  test "renders with tabs" do
    tabs = [{label: "All", href: "/users", active: true}, {label: "Active", href: "/users?active=true"}]
    render_inline(HotwireBits::PageHeadingComponent.new(title: "Users", tabs: tabs))

    assert_selector "nav"
    assert_selector "a", text: "All"
    assert_selector "a", text: "Active"
  end
end
