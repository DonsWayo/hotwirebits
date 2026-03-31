# frozen_string_literal: true

require "test_helper"

class ErbPartialsRenderingTest < ActionView::TestCase
  include HotwirebitsHelper

  # Helper to get the rendered HTML string for text assertions.
  # ActionView::TestCase stores rendered output in `rendered` (Rails 7.1+)
  # or `@rendered` / `@response.body` depending on version.
  private def rendered_html
    rendered.to_s
  end

  # === Primitives ===

  test "_button partial renders" do
    render partial: "hotwirebits/button", locals: {label: "Click", variant: :default, size: :md}

    assert_includes rendered_html, "Click"
  end

  test "_badge partial renders" do
    render partial: "hotwirebits/badge", locals: {label: "New", variant: :default}

    assert_includes rendered_html, "New"
  end

  test "_alert partial renders" do
    render partial: "hotwirebits/alert", locals: {type: :info, title: "Note", message: "Hello"}

    assert_includes rendered_html, "Note"
    assert_includes rendered_html, "Hello"
  end

  test "_card partial renders" do
    render partial: "hotwirebits/card", locals: {title: "Card Title", description: "Description"}

    assert_includes rendered_html, "Card Title"
    assert_includes rendered_html, "Description"
  end

  test "_avatar partial renders" do
    render partial: "hotwirebits/avatar", locals: {initials: "JD", size: :md}

    assert_includes rendered_html, "JD"
  end

  test "_separator partial renders" do
    render partial: "hotwirebits/separator", locals: {orientation: :horizontal}

    assert_select "div"
  end

  test "_skeleton partial renders" do
    render partial: "hotwirebits/skeleton", locals: {shape: :rectangle}

    assert_select "div.animate-pulse"
  end

  test "_spinner partial renders" do
    render partial: "hotwirebits/spinner", locals: {size: :md}

    assert_select "svg"
  end

  test "_toggle partial renders" do
    render partial: "hotwirebits/toggle", locals: {label: "Bold", pressed: false}

    assert_includes rendered_html, "Bold"
  end

  test "_kbd partial renders" do
    render partial: "hotwirebits/kbd", locals: {key: "Ctrl", size: :md}

    assert_includes rendered_html, "Ctrl"
  end

  test "_tag partial renders" do
    render partial: "hotwirebits/tag", locals: {label: "Feature", color: :default}

    assert_includes rendered_html, "Feature"
  end

  test "_chip partial renders" do
    render partial: "hotwirebits/chip", locals: {label: "React", size: :md}

    assert_includes rendered_html, "React"
  end

  # === Forms ===

  test "_input partial renders" do
    render partial: "hotwirebits/input", locals: {name: "email", placeholder: "Email", type: :text}

    assert_select "input[name='email']"
  end

  test "_checkbox partial renders" do
    render partial: "hotwirebits/checkbox", locals: {name: "agree", label: "I agree", checked: false}

    assert_select "input[type='checkbox']"
  end

  test "_switch partial renders" do
    render partial: "hotwirebits/switch", locals: {name: "dark", label: "Dark", checked: false}

    assert_select "label[data-controller='hw-switch']"
    assert_includes rendered_html, "Dark"
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
    render partial: "hotwirebits/slider", locals: {name: "volume", min: 0, max: 100, value: 50, step: 1, disabled: false}

    assert_select "input[type='range']"
  end

  test "_form_group partial renders" do
    # render layout: supports blocks, unlike render partial:
    render layout: "hotwirebits/form_group", locals: {label: "Email", hint: "Enter email", error: nil, horizontal: false} do
      "<input name='email'>".html_safe
    end

    assert_includes rendered_html, "Email"
  end

  # === Navigation ===

  test "_navbar partial renders" do
    render partial: "hotwirebits/navbar", locals: {brand: "MyApp", items: [], class: nil}

    assert_includes rendered_html, "MyApp"
  end

  test "_breadcrumb partial renders" do
    render partial: "hotwirebits/breadcrumb", locals: {
      items: [{label: "Home", href: "/"}, {label: "Page"}],
      separator: :slash, class: nil
    }

    assert_includes rendered_html, "Home"
    assert_includes rendered_html, "Page"
  end

  test "_tabs partial renders" do
    render partial: "hotwirebits/tabs", locals: {
      tabs: [{label: "Tab 1"}, {label: "Tab 2"}],
      active: 0, class: nil
    }

    assert_includes rendered_html, "Tab 1"
    assert_includes rendered_html, "Tab 2"
  end

  test "_dropdown partial renders" do
    render partial: "hotwirebits/dropdown", locals: {
      trigger_label: "Menu",
      items: [{label: "Item 1", href: "/1"}],
      align: :start, class: nil
    }

    assert_includes rendered_html, "Menu"
    assert_includes rendered_html, "Item 1"
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

    assert_includes rendered_html, "Confirm"
    assert_includes rendered_html, "Are you sure?"
  end

  test "_toast partial renders" do
    render partial: "hotwirebits/toast", locals: {
      type: :success, title: "Saved", message: "OK", dismissible: true
    }

    assert_includes rendered_html, "Saved"
  end

  test "_tooltip partial renders" do
    # render layout: supports blocks, unlike render partial:
    render layout: "hotwirebits/tooltip", locals: {tip: "Help"} do
      "?"
    end

    assert_includes rendered_html, "Help"
  end

  # === Feedback ===

  test "_banner partial renders" do
    render partial: "hotwirebits/banner", locals: {type: :info, message: "Notice", dismissible: true, class: nil}

    assert_includes rendered_html, "Notice"
    assert_select "div[data-controller='hw-banner']"
  end

  test "_empty_state partial renders" do
    render partial: "hotwirebits/empty_state", locals: {
      title: "Nothing here", description: "Create something",
      action_label: "Create", action_href: "/new", class: nil
    }

    assert_includes rendered_html, "Nothing here"
    assert_includes rendered_html, "Create something"
  end

  # === Layout ===

  test "_container partial renders" do
    # render layout: supports blocks, unlike render partial:
    render layout: "hotwirebits/container", locals: {size: :lg, class: nil} do
      "Container content"
    end

    assert_includes rendered_html, "Container content"
  end

  test "_grid partial renders" do
    render layout: "hotwirebits/grid", locals: {columns: 3, gap: 4, class: nil} do
      "Grid content"
    end

    assert_includes rendered_html, "Grid content"
  end

  test "_stack partial renders" do
    render layout: "hotwirebits/stack", locals: {gap: 4, align: nil, class: nil} do
      "Stack content"
    end

    assert_includes rendered_html, "Stack content"
  end

  test "_divider partial renders" do
    render partial: "hotwirebits/divider", locals: {orientation: :horizontal, label: nil, class: nil}

    assert_select "div"
  end
end
