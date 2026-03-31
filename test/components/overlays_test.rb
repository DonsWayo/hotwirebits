# frozen_string_literal: true

require "test_helper"

class DialogComponentTest < ViewComponent::TestCase
  test "renders dialog" do
    render_inline(HotwireBits::DialogComponent.new(title: "Confirm")) { "Are you sure?" }

    assert_selector "div[data-controller='hw-dialog']"
    assert_text "Confirm"
    assert_text "Are you sure?"
  end

  test "renders dialog with header slot" do
    component = HotwireBits::DialogComponent.new(title: "Title")
    render_inline(component) do |c|
      c.with_header { "Custom Header" }
      "Body"
    end

    assert_text "Custom Header"
  end

  test "renders dialog with footer slot" do
    component = HotwireBits::DialogComponent.new(title: "Title")
    render_inline(component) do |c|
      c.with_footer { "Footer Actions" }
      "Body"
    end

    assert_text "Footer Actions"
  end

  test "renders closable dialog" do
    render_inline(HotwireBits::DialogComponent.new(title: "Close Me", closable: true)) { "Content" }

    assert_selector "button[data-action='click->hw-dialog#close']"
  end

  test "includes @extra_attrs" do
    render_inline(HotwireBits::DialogComponent.new(title: "T", data: { testid: "dialog" })) { "C" }

    assert_selector "div[data-testid='dialog']"
  end
end

class AlertDialogComponentTest < ViewComponent::TestCase
  test "renders alert dialog" do
    render_inline(HotwireBits::AlertDialogComponent.new(
      title: "Delete?",
      description: "This cannot be undone",
      confirm_label: "Delete",
      cancel_label: "Cancel"
    ))

    assert_text "Delete?"
    assert_text "This cannot be undone"
    assert_text "Delete"
    assert_text "Cancel"
  end

  test "renders alert dialog with custom actions" do
    component = HotwireBits::AlertDialogComponent.new(title: "Confirm")
    render_inline(component) do |c|
      c.with_confirm_action { "Yes" }
      c.with_cancel_action { "No" }
    end

    assert_text "Yes"
    assert_text "No"
  end
end

class SheetComponentTest < ViewComponent::TestCase
  test "renders sheet" do
    render_inline(HotwireBits::SheetComponent.new(title: "Details")) { "Sheet content" }

    assert_text "Details"
    assert_text "Sheet content"
  end

  test "renders sheet from right side" do
    render_inline(HotwireBits::SheetComponent.new(title: "Panel", side: :right)) { "Content" }

    assert_text "Panel"
  end

  test "renders sheet with header slot" do
    component = HotwireBits::SheetComponent.new(title: "Title")
    render_inline(component) do |c|
      c.with_header { "Custom Header" }
      "Body"
    end

    assert_text "Custom Header"
  end
end

class DrawerComponentTest < ViewComponent::TestCase
  test "renders drawer" do
    render_inline(HotwireBits::DrawerComponent.new(title: "Nav")) { "Drawer content" }

    assert_text "Nav"
    assert_selector "div[data-controller='hw-drawer']"
  end
end

class PopoverComponentTest < ViewComponent::TestCase
  test "renders popover" do
    render_inline(HotwireBits::PopoverComponent.new(trigger_label: "Info")) { "Popover content" }

    assert_text "Info"
    assert_text "Popover content"
    assert_selector "div[data-controller='hw-popover']"
  end
end

class ToastComponentTest < ViewComponent::TestCase
  test "renders toast" do
    render_inline(HotwireBits::ToastComponent.new(type: :success, title: "Saved!", description: "Changes saved"))

    assert_text "Saved!"
    assert_text "Changes saved"
  end

  test "renders error toast" do
    render_inline(HotwireBits::ToastComponent.new(type: :error, title: "Error"))

    assert_text "Error"
  end

  test "renders toast with action" do
    render_inline(HotwireBits::ToastComponent.new(
      type: :info,
      title: "Undo",
      action: { label: "Undo", url: "/undo" }
    ))

    assert_text "Undo"
    assert_selector "a[href='/undo']"
  end
end

class LoadingOverlayComponentTest < ViewComponent::TestCase
  test "renders loading overlay" do
    render_inline(HotwireBits::LoadingOverlayComponent.new) { "Content behind overlay" }

    assert_text "Content behind overlay"
    assert_selector "svg"
  end

  test "renders with custom message" do
    render_inline(HotwireBits::LoadingOverlayComponent.new(message: "Saving..."))

    assert_text "Saving..."
  end
end

class TooltipComponentTest < ViewComponent::TestCase
  test "renders tooltip" do
    render_inline(HotwireBits::TooltipComponent.new(tip: "Help text")) { "?" }

    assert_text "?"
    assert_text "Help text"
    assert_selector "div[data-controller='hw-tooltip']"
  end
end
