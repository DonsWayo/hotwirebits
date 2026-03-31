# frozen_string_literal: true

require "test_helper"

class BannerComponentTest < ViewComponent::TestCase
  test "renders banner" do
    render_inline(HotwireBits::BannerComponent.new(type: :info, message: "Announcement"))

    assert_text "Announcement"
    assert_selector "div[data-controller='hw-banner']"
  end

  test "renders dismissible banner" do
    render_inline(HotwireBits::BannerComponent.new(type: :warning, message: "Warning", dismissible: true))

    assert_selector "button[data-action='click->hw-banner#dismiss']"
  end
end

class EmptyStateComponentTest < ViewComponent::TestCase
  test "renders empty state" do
    render_inline(HotwireBits::EmptyStateComponent.new(
      title: "No items",
      description: "Create your first item"
    ))

    assert_text "No items"
    assert_text "Create your first item"
  end

  test "renders with action button" do
    render_inline(HotwireBits::EmptyStateComponent.new(
      title: "Empty",
      action_label: "Create",
      action_href: "/new"
    ))

    assert_text "Empty"
    assert_selector "a[href='/new']", text: "Create"
  end
end

class CountdownComponentTest < ViewComponent::TestCase
  test "renders countdown" do
    render_inline(HotwireBits::CountdownComponent.new(value: 100, target: 0))

    assert_selector "span[data-controller='hw-countdown']"
    assert_text "100"
  end

  test "renders with prefix and suffix" do
    render_inline(HotwireBits::CountdownComponent.new(
      value: 60,
      target: 0,
      prefix: "T-",
      suffix: "s"
    ))

    assert_text "T-"
    assert_text "60"
    assert_text "s"
  end
end

class AnimatedNumberComponentTest < ViewComponent::TestCase
  test "renders animated number" do
    render_inline(HotwireBits::AnimatedNumberComponent.new(value: 1234))

    assert_text "1,234"
  end

  test "renders with prefix" do
    render_inline(HotwireBits::AnimatedNumberComponent.new(value: 99, prefix: "$"))

    assert_text "$"
    assert_text "99"
  end

  test "renders with suffix" do
    render_inline(HotwireBits::AnimatedNumberComponent.new(value: 85, suffix: "%"))

    assert_text "85"
    assert_text "%"
  end
end

class StatusDotComponentTest < ViewComponent::TestCase
  test "renders status dot" do
    render_inline(HotwireBits::StatusDotComponent.new(status: :online))

    assert_selector "span"
  end

  test "renders with label" do
    render_inline(HotwireBits::StatusDotComponent.new(status: :online, label: "Active"))

    assert_text "Active"
  end
end

class FeedbackComponentTest < ViewComponent::TestCase
  test "renders feedback form" do
    render_inline(HotwireBits::FeedbackComponent.new)

    assert_selector "div[data-controller='hw-feedback']"
  end
end

class SwapComponentTest < ViewComponent::TestCase
  test "renders swap" do
    on_content = '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24"><circle cx="12" cy="12" r="10"/></svg>'
    off_content = '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24"><rect x="3" y="3" width="18" height="18"/></svg>'

    render_inline(HotwireBits::SwapComponent.new(on_content: on_content, off_content: off_content))

    assert_selector "label[data-controller='hw-swap']"
  end

  test "renders swap with on state" do
    render_inline(HotwireBits::SwapComponent.new(
      on_content: "On",
      off_content: "Off",
      active: :on
    ))

    assert_text "On"
    assert_text "Off"
  end
end

class CollapsibleComponentTest < ViewComponent::TestCase
  test "renders collapsible" do
    render_inline(HotwireBits::CollapsibleComponent.new(trigger_label: "Details")) { "Hidden content" }

    assert_text "Details"
    assert_text "Hidden content"
    assert_selector "div[data-controller='hw-collapsible']"
  end
end

class SpoilerComponentTest < ViewComponent::TestCase
  test "renders spoiler" do
    render_inline(HotwireBits::SpoilerComponent.new(max_lines: 3)) { "Long text content that will be truncated" }

    assert_selector "div[data-controller='hw-spoiler']"
  end
end
