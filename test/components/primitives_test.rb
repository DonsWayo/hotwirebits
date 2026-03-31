# frozen_string_literal: true

require "test_helper"

class ButtonComponentTest < ActionView::TestCase
  test "renders default button" do
    render_inline(HotwireBits::ButtonComponent.new(label: "Click me"))

    assert_selector "button", text: "Click me"
    assert_selector "button[data-controller='hw-button']"
  end

  test "renders primary variant" do
    render_inline(HotwireBits::ButtonComponent.new(label: "Save", variant: :primary))

    assert_selector "button", text: "Save"
  end

  test "renders destructive variant" do
    render_inline(HotwireBits::ButtonComponent.new(label: "Delete", variant: :destructive))

    assert_selector "button", text: "Delete"
  end

  test "renders outline variant" do
    render_inline(HotwireBits::ButtonComponent.new(label: "Cancel", variant: :outline))

    assert_selector "button", text: "Cancel"
  end

  test "renders ghost variant" do
    render_inline(HotwireBits::ButtonComponent.new(label: "Ghost", variant: :ghost))

    assert_selector "button", text: "Ghost"
  end

  test "renders link variant" do
    render_inline(HotwireBits::ButtonComponent.new(label: "Link", variant: :link))

    assert_selector "a", text: "Link"
  end

  test "renders small size" do
    render_inline(HotwireBits::ButtonComponent.new(label: "Small", size: :sm))

    assert_selector "button", text: "Small"
  end

  test "renders large size" do
    render_inline(HotwireBits::ButtonComponent.new(label: "Large", size: :lg))

    assert_selector "button", text: "Large"
  end

  test "renders disabled button" do
    render_inline(HotwireBits::ButtonComponent.new(label: "Disabled", disabled: true))

    assert_selector "button[disabled]", text: "Disabled"
  end

  test "renders with icon" do
    icon = '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24"><circle cx="12" cy="12" r="10"/></svg>'
    render_inline(HotwireBits::ButtonComponent.new(label: "With Icon", icon: icon))

    assert_selector "button", text: "With Icon"
    assert_selector "svg"
  end

  test "renders with loading state" do
    render_inline(HotwireBits::ButtonComponent.new(label: "Loading", loading: true))

    assert_selector "button", text: "Loading"
  end

  test "renders as block with content" do
    render_inline(HotwireBits::ButtonComponent.new(label: "Label")) { "Custom content" }

    assert_text "Custom content"
  end

  test "accepts extra HTML attributes" do
    render_inline(HotwireBits::ButtonComponent.new(label: "Attrs", data: { testid: "my-button" }))

    assert_selector "button[data-testid='my-button']"
  end
end

class BadgeComponentTest < ActionView::TestCase
  test "renders default badge" do
    render_inline(HotwireBits::BadgeComponent.new(label: "New"))

    assert_selector "div", text: "New"
  end

  test "renders with dot indicator" do
    render_inline(HotwireBits::BadgeComponent.new(label: "Active", dot: true))

    assert_selector "span.rounded-full"
  end

  test "renders removable badge" do
    render_inline(HotwireBits::BadgeComponent.new(label: "Tag", removable: true))

    assert_selector "button[data-action='click->hw-badge#dismiss']"
    assert_selector "div[data-controller='hw-badge']"
  end

  test "renders secondary variant" do
    render_inline(HotwireBits::BadgeComponent.new(label: "Secondary", variant: :secondary))

    assert_selector "div", text: "Secondary"
  end

  test "renders destructive variant" do
    render_inline(HotwireBits::BadgeComponent.new(label: "Error", variant: :destructive))

    assert_selector "div", text: "Error"
  end

  test "renders outline variant" do
    render_inline(HotwireBits::BadgeComponent.new(label: "Outline", variant: :outline))

    assert_selector "div", text: "Outline"
  end
end

class AlertComponentTest < ActionView::TestCase
  test "renders info alert" do
    render_inline(HotwireBits::AlertComponent.new(type: :info, title: "Info", message: "This is info"))

    assert_selector "div", text: "Info"
    assert_text "This is info"
  end

  test "renders success alert" do
    render_inline(HotwireBits::AlertComponent.new(type: :success, title: "Success", message: "Done"))

    assert_text "Success"
    assert_text "Done"
  end

  test "renders warning alert" do
    render_inline(HotwireBits::AlertComponent.new(type: :warning, title: "Warning"))

    assert_text "Warning"
  end

  test "renders error alert" do
    render_inline(HotwireBits::AlertComponent.new(type: :error, title: "Error"))

    assert_text "Error"
  end

  test "renders dismissible alert" do
    render_inline(HotwireBits::AlertComponent.new(type: :info, title: "Dismiss", dismissible: true))

    assert_selector "button[data-action='click->hw-alert#dismiss']"
  end
end

class CardComponentTest < ActionView::TestCase
  test "renders card with title" do
    render_inline(HotwireBits::CardComponent.new(title: "Card Title"))

    assert_text "Card Title"
  end

  test "renders card with description" do
    render_inline(HotwireBits::CardComponent.new(title: "Title", description: "Description text"))

    assert_text "Description text"
  end

  test "renders card with content block" do
    render_inline(HotwireBits::CardComponent.new(title: "Title")) { "Card body content" }

    assert_text "Card body content"
  end

  test "renders card with header slot" do
    component = HotwireBits::CardComponent.new(title: "Title")
    render_inline(component) do |c|
      c.with_header { "Custom Header" }
      "Body"
    end

    assert_text "Custom Header"
  end

  test "renders card with footer slot" do
    component = HotwireBits::CardComponent.new(title: "Title")
    render_inline(component) do |c|
      c.with_footer { "Footer Content" }
      "Body"
    end

    assert_text "Footer Content"
  end
end

class AvatarComponentTest < ActionView::TestCase
  test "renders avatar with initials" do
    render_inline(HotwireBits::AvatarComponent.new(initials: "JD"))

    assert_text "JD"
  end

  test "renders avatar with image" do
    render_inline(HotwireBits::AvatarComponent.new(src: "/avatar.jpg", alt: "John"))

    assert_selector "img[src='/avatar.jpg']"
  end

  test "renders small avatar" do
    render_inline(HotwireBits::AvatarComponent.new(initials: "SM", size: :sm))

    assert_text "SM"
  end

  test "renders large avatar" do
    render_inline(HotwireBits::AvatarComponent.new(initials: "LG", size: :lg))

    assert_text "LG"
  end

  test "renders avatar with status indicator" do
    render_inline(HotwireBits::AvatarComponent.new(initials: "ON", status: :online))

    assert_selector "span"
  end
end

class TypographyComponentTest < ActionView::TestCase
  test "renders heading" do
    render_inline(HotwireBits::TypographyComponent.new(as: :h1)) { "Heading" }

    assert_selector "h1", text: "Heading"
  end

  test "renders paragraph by default" do
    render_inline(HotwireBits::TypographyComponent.new) { "Paragraph" }

    assert_selector "p", text: "Paragraph"
  end

  test "renders lead text" do
    render_inline(HotwireBits::TypographyComponent.new(as: :lead)) { "Lead text" }

    assert_selector "p", text: "Lead text"
  end

  test "renders muted text" do
    render_inline(HotwireBits::TypographyComponent.new(as: :muted)) { "Muted" }

    assert_selector "p", text: "Muted"
  end

  test "renders blockquote" do
    render_inline(HotwireBits::TypographyComponent.new(as: :blockquote)) { "Quote" }

    assert_selector "blockquote", text: "Quote"
  end

  test "renders inline code" do
    render_inline(HotwireBits::TypographyComponent.new(as: :code)) { "code" }

    assert_selector "code", text: "code"
  end
end

class SeparatorComponentTest < ActionView::TestCase
  test "renders horizontal separator" do
    render_inline(HotwireBits::SeparatorComponent.new)

    assert_selector "div"
  end

  test "renders vertical separator" do
    render_inline(HotwireBits::SeparatorComponent.new(orientation: :vertical))

    assert_selector "div"
  end
end

class SkeletonComponentTest < ActionView::TestCase
  test "renders default skeleton" do
    render_inline(HotwireBits::SkeletonComponent.new)

    assert_selector "div.animate-pulse"
  end

  test "renders circle skeleton" do
    render_inline(HotwireBits::SkeletonComponent.new(shape: :circle))

    assert_selector "div.rounded-full"
  end

  test "renders text skeleton" do
    render_inline(HotwireBits::SkeletonComponent.new(shape: :text))

    assert_selector "div.h-4"
  end
end

class SpinnerComponentTest < ActionView::TestCase
  test "renders spinner" do
    render_inline(HotwireBits::SpinnerComponent.new)

    assert_selector "svg"
  end

  test "renders small spinner" do
    render_inline(HotwireBits::SpinnerComponent.new(size: :sm))

    assert_selector "svg"
  end
end

class LabelComponentTest < ActionView::TestCase
  test "renders label" do
    render_inline(HotwireBits::LabelComponent.new(label: "Email"))

    assert_text "Email"
  end

  test "renders required label" do
    render_inline(HotwireBits::LabelComponent.new(label: "Name", required: true))

    assert_text "Name"
    assert_text "*"
  end
end

class IndicatorComponentTest < ActionView::TestCase
  test "renders indicator" do
    render_inline(HotwireBits::IndicatorComponent.new) { "Badge content" }

    assert_text "Badge content"
  end

  test "renders indicator with dot" do
    render_inline(HotwireBits::IndicatorComponent.new(content: "3")) { "Inbox" }

    assert_text "3"
    assert_text "Inbox"
  end
end

class StatusComponentTest < ActionView::TestCase
  test "renders online status" do
    render_inline(HotwireBits::StatusComponent.new(status: :online))

    assert_selector "span"
  end

  test "renders offline status" do
    render_inline(HotwireBits::StatusComponent.new(status: :offline))

    assert_selector "span"
  end

  test "renders with label" do
    render_inline(HotwireBits::StatusComponent.new(status: :online, label: "Active"))

    assert_text "Active"
  end
end

class CloseButtonComponentTest < ActionView::TestCase
  test "renders close button" do
    render_inline(HotwireBits::CloseButtonComponent.new)

    assert_selector "button"
    assert_selector "svg"
  end
end

class ToggleComponentTest < ActionView::TestCase
  test "renders unpressed toggle" do
    render_inline(HotwireBits::ToggleComponent.new(label: "Bold"))

    assert_selector "button[aria-pressed='false']", text: "Bold"
  end

  test "renders pressed toggle" do
    render_inline(HotwireBits::ToggleComponent.new(label: "Bold", pressed: true))

    assert_selector "button[aria-pressed='true']", text: "Bold"
  end
end

class ProgressComponentTest < ActionView::TestCase
  test "renders progress bar" do
    render_inline(HotwireBits::ProgressComponent.new(value: 50, max: 100))

    assert_selector "div"
  end

  test "renders with label" do
    render_inline(HotwireBits::ProgressComponent.new(value: 75, max: 100, label: "75%"))

    assert_text "75%"
  end
end

class KbdComponentTest < ActionView::TestCase
  test "renders keyboard key" do
    render_inline(HotwireBits::KbdComponent.new(key: "Ctrl"))

    assert_selector "kbd", text: "Ctrl"
  end

  test "renders small kbd" do
    render_inline(HotwireBits::KbdComponent.new(key: "Esc", size: :sm))

    assert_selector "kbd", text: "Esc"
  end
end

class ChipComponentTest < ActionView::TestCase
  test "renders chip with label" do
    render_inline(HotwireBits::ChipComponent.new(label: "React"))

    assert_text "React"
  end

  test "renders removable chip" do
    render_inline(HotwireBits::ChipComponent.new(label: "Tag", removable: true))

    assert_selector "button"
  end
end

class TagComponentTest < ActionView::TestCase
  test "renders tag" do
    render_inline(HotwireBits::TagComponent.new(label: "Feature"))

    assert_text "Feature"
  end

  test "renders colored tag" do
    render_inline(HotwireBits::TagComponent.new(label: "Bug", color: :red))

    assert_text "Bug"
  end
end
