# frozen_string_literal: true

require "test_helper"

class ErbPartialsRenderingTest < ActionView::TestCase
  include HotwirebitsHelper

  # === Primitives ===

  test "_button partial renders" do
    render partial: "hotwirebits/button", locals: { label: "Click", variant: :default, size: :md }

    assert_text "Click"
  end

  test "_badge partial renders" do
    render partial: "hotwirebits/badge", locals: { label: "New", variant: :default }

    assert_text "New"
  end

  test "_alert partial renders" do
    render partial: "hotwirebits/alert", locals: { type: :info, title: "Note", message: "Hello" }

    assert_text "Note"
    assert_text "Hello"
  end

  test "_card partial renders" do
    render partial: "hotwirebits/card", locals: { title: "Card Title", description: "Description" }

    assert_text "Card Title"
    assert_text "Description"
  end

  test "_avatar partial renders" do
    render partial: "hotwirebits/avatar", locals: { initials: "JD", size: :md }

    assert_text "JD"
  end

  test "_separator partial renders" do
    render partial: "hotwirebits/separator", locals: { orientation: :horizontal }

    assert_select "div"
  end

  test "_skeleton partial renders" do
    render partial: "hotwirebits/skeleton", locals: { shape: :rectangle }

    assert_select "div.animate-pulse"
  end

  test "_spinner partial renders" do
    render partial: "hotwirebits/spinner", locals: { size: :md }

    assert_select "svg"
  end

  test "_toggle partial renders" do
    render partial: "hotwirebits/toggle", locals: { label: "Bold", pressed: false }

    assert_text "Bold"
  end

  test "_kbd partial renders" do
    render partial: "hotwirebits/kbd", locals: { key: "Ctrl", size: :md }

    assert_text "Ctrl"
  end

  test "_tag partial renders" do
    render partial: "hotwirebits/tag", locals: { label: "Feature", color: :default }

    assert_text "Feature"
  end

  test "_chip partial renders" do
    render partial: "hotwirebits/chip", locals: { label: "React", size: :md }

    assert_text "React"
  end

  # === Forms ===

  test "_input partial renders" do
    render partial: "hotwirebits/input", locals: { name: "email", placeholder: "Email", type: :text }

    assert_select "input[name='email']"
  end

  test "_checkbox partial renders" do
    render partial: "hotwirebits/checkbox", locals: { name: "agree", label: "I agree", checked: false }

    assert_select "input[type='checkbox']"
  end

  test "_switch partial renders" do
    render partial: "hotwirebits/switch", locals: { name: "dark", label: "Dark", checked: false }

    assert_select "label[data-controller='hw-switch']"
    assert_text "Dark"
  end

  test "_select partial renders" do
    render partial: "hotwirebits/select", locals: {
      name: "country",
      options: [["US", "us"], ["CA", "ca"]],
      placeholder: "Choose",
      selected: nil,
      disabled: false
    }

    assert_select "select[name='country']"
  end

  test "_textarea partial renders" do
    render partial: "hotwirebits/textarea", locals: {
      name: "bio", placeholder: "Bio", value: "", rows: 4,
      disabled: false, readonly: false, required: false, max_length: nil
    }

    assert_select "textarea[name='bio']"
  end

  test "_slider partial renders" do
    render partial: "hotwirebits/slider", locals: { name: "volume", min: 0, max: 100, value: 50, step: 1, disabled: false }

    assert_select "input[type='range']"
  end

  test "_form_group partial renders" do
    render partial: "hotwirebits/form_group", locals: { label: "Email", hint: "Enter email", error: nil, horizontal: false } do
      "<input name='email'>".html_safe
    end

    assert_text "Email"
  end

  # === Navigation ===

  test "_navbar partial renders" do
    render partial: "hotwirebits/navbar", locals: { brand: "MyApp", items: [], class: nil }

    assert_text "MyApp"
  end

  test "_breadcrumb partial renders" do
    render partial: "hotwirebits/breadcrumb", locals: {
      items: [{ label: "Home", href: "/" }, { label: "Page" }],
      separator: :slash, class: nil
    }

    assert_text "Home"
    assert_text "Page"
  end

  test "_tabs partial renders" do
    render partial: "hotwirebits/tabs", locals: {
      tabs: [{ label: "Tab 1" }, { label: "Tab 2" }],
      active: 0, class: nil
    }

    assert_text "Tab 1"
    assert_text "Tab 2"
  end

  test "_dropdown partial renders" do
    render partial: "hotwirebits/dropdown", locals: {
      trigger_label: "Menu",
      items: [{ label: "Item 1", href: "/1" }],
      align: :start, class: nil
    }

    assert_text "Menu"
    assert_text "Item 1"
  end

  test "_pagination partial renders" do
    render partial: "hotwirebits/pagination", locals: {
      current_page: 2, total_pages: 10, page_url: ->(p) { "/page/#{p}" },
      sibling_count: 1, class: nil
    }

    assert_select "nav[aria-label='Pagination']"
  end

  # === Overlays ===

  test "_dialog partial renders" do
    render partial: "hotwirebits/dialog", locals: {
      title: "Confirm", description: "Are you sure?", size: :md,
      closable: true, open: false, class: nil
    }

    assert_text "Confirm"
    assert_text "Are you sure?"
  end

  test "_toast partial renders" do
    render partial: "hotwirebits/toast", locals: {
      type: :success, title: "Saved", message: "OK", dismissible: true
    }

    assert_text "Saved"
  end

  test "_tooltip partial renders" do
    render partial: "hotwirebits/tooltip", locals: { tip: "Help" } do
      "?"
    end

    assert_text "Help"
  end

  # === Feedback ===

  test "_banner partial renders" do
    render partial: "hotwirebits/banner", locals: { type: :info, message: "Notice", dismissible: true, class: nil }

    assert_text "Notice"
    assert_select "div[data-controller='hw-banner']"
  end

  test "_empty_state partial renders" do
    render partial: "hotwirebits/empty_state", locals: {
      title: "Nothing here", description: "Create something",
      action_label: "Create", action_href: "/new", class: nil
    }

    assert_text "Nothing here"
    assert_text "Create something"
  end

  # === Layout ===

  test "_container partial renders" do
    render partial: "hotwirebits/container", locals: { size: :lg, class: nil } do
      "Container content"
    end

    assert_text "Container content"
  end

  test "_grid partial renders" do
    render partial: "hotwirebits/grid", locals: { columns: 3, gap: 4, class: nil } do
      "Grid content"
    end

    assert_text "Grid content"
  end

  test "_stack partial renders" do
    render partial: "hotwirebits/stack", locals: { gap: 4, align: nil, class: nil } do
      "Stack content"
    end

    assert_text "Stack content"
  end

  test "_divider partial renders" do
    render partial: "hotwirebits/divider", locals: { orientation: :horizontal, label: nil, class: nil }

    assert_select "div"
  end
end
