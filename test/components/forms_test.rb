# frozen_string_literal: true

require "test_helper"

class InputComponentTest < ViewComponent::TestCase
  test "renders text input" do
    render_inline(HotwireBits::InputComponent.new(name: "email", placeholder: "Enter email"))

    assert_selector "input[name='email'][placeholder='Enter email']"
  end

  test "renders input with value" do
    render_inline(HotwireBits::InputComponent.new(name: "name", value: "John"))

    assert_selector "input[name='name'][value='John']"
  end

  test "renders disabled input" do
    render_inline(HotwireBits::InputComponent.new(name: "field", disabled: true))

    assert_selector "input[name='field'][disabled]"
  end

  test "renders required input" do
    render_inline(HotwireBits::InputComponent.new(name: "field", required: true))

    assert_selector "input[name='field'][required]"
  end

  test "renders input with left icon" do
    icon = '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24"><circle cx="12" cy="12" r="10"/></svg>'
    render_inline(HotwireBits::InputComponent.new(name: "search", icon: icon, icon_position: :left))

    assert_selector "input[name='search']"
    assert_selector "svg"
  end

  test "renders input with error state" do
    render_inline(HotwireBits::InputComponent.new(name: "field", error: true))

    assert_selector "input[name='field']"
  end

  test "renders small input" do
    render_inline(HotwireBits::InputComponent.new(name: "field", size: :sm))

    assert_selector "input[name='field']"
  end
end

class CheckboxComponentTest < ViewComponent::TestCase
  test "renders checkbox" do
    render_inline(HotwireBits::CheckboxComponent.new(name: "agree"))

    assert_selector "input[type='checkbox'][name='agree']"
  end

  test "renders checked checkbox" do
    render_inline(HotwireBits::CheckboxComponent.new(name: "agree", checked: true))

    assert_selector "input[type='checkbox'][name='agree'][checked]"
  end

  test "renders checkbox with label" do
    render_inline(HotwireBits::CheckboxComponent.new(name: "agree", label: "I agree"))

    assert_text "I agree"
  end

  test "renders disabled checkbox" do
    render_inline(HotwireBits::CheckboxComponent.new(name: "agree", disabled: true))

    assert_selector "input[type='checkbox'][disabled]"
  end
end

class SwitchComponentTest < ViewComponent::TestCase
  test "renders unchecked switch" do
    render_inline(HotwireBits::SwitchComponent.new(name: "notifications"))

    assert_selector "button[role='switch'][aria-checked='false']"
  end

  test "renders checked switch" do
    render_inline(HotwireBits::SwitchComponent.new(name: "notifications", checked: true))

    assert_selector "button[role='switch'][aria-checked='true']"
  end

  test "renders switch with label" do
    render_inline(HotwireBits::SwitchComponent.new(name: "dark", label: "Dark mode"))

    assert_text "Dark mode"
  end

  test "renders disabled switch" do
    render_inline(HotwireBits::SwitchComponent.new(name: "feature", disabled: true))

    assert_selector "button[disabled]"
  end

  test "includes hw-switch controller" do
    render_inline(HotwireBits::SwitchComponent.new(name: "toggle"))

    assert_selector "label[data-controller='hw-switch']"
  end
end

class SelectComponentTest < ViewComponent::TestCase
  test "renders select with options" do
    render_inline(HotwireBits::SelectComponent.new(
      name: "country",
      options: [["USA", "us"], ["Canada", "ca"]]
    ))

    assert_selector "select[name='country']"
    assert_selector "option[value='us']", text: "USA"
    assert_selector "option[value='ca']", text: "Canada"
  end

  test "renders select with placeholder" do
    render_inline(HotwireBits::SelectComponent.new(
      name: "color",
      options: [["Red", "red"]],
      placeholder: "Choose color"
    ))

    assert_selector "option[disabled]", text: "Choose color"
  end

  test "renders disabled select" do
    render_inline(HotwireBits::SelectComponent.new(
      name: "field",
      options: [["A", "a"]],
      disabled: true
    ))

    assert_selector "select[disabled]"
  end

  test "renders with selected value" do
    render_inline(HotwireBits::SelectComponent.new(
      name: "size",
      options: [["Small", "sm"], ["Large", "lg"]],
      selected: "lg"
    ))

    assert_selector "option[value='lg'][selected]"
  end
end

class TextareaComponentTest < ViewComponent::TestCase
  test "renders textarea" do
    render_inline(HotwireBits::TextareaComponent.new(name: "bio", placeholder: "Your bio"))

    assert_selector "textarea[name='bio'][placeholder='Your bio']"
  end

  test "renders textarea with value" do
    render_inline(HotwireBits::TextareaComponent.new(name: "notes", value: "Some notes"))

    assert_selector "textarea[name='notes']", text: "Some notes"
  end

  test "renders textarea with rows" do
    render_inline(HotwireBits::TextareaComponent.new(name: "bio", rows: 5))

    assert_selector "textarea[name='bio'][rows='5']"
  end

  test "renders disabled textarea" do
    render_inline(HotwireBits::TextareaComponent.new(name: "field", disabled: true))

    assert_selector "textarea[disabled]"
  end
end

class SliderComponentTest < ViewComponent::TestCase
  test "renders slider" do
    render_inline(HotwireBits::SliderComponent.new(name: "volume", min: 0, max: 100, value: 50))

    assert_selector "input[type='range'][name='volume']"
  end

  test "renders slider with step" do
    render_inline(HotwireBits::SliderComponent.new(name: "step", min: 0, max: 10, step: 2))

    assert_selector "input[type='range'][step='2']"
  end
end

class RatingComponentTest < ViewComponent::TestCase
  test "renders rating" do
    render_inline(HotwireBits::RatingComponent.new(name: "stars", value: 3, max: 5))

    assert_selector "div[data-controller='hw-rating']"
    assert_selector "button", count: 5
  end

  test "renders readonly rating" do
    render_inline(HotwireBits::RatingComponent.new(name: "stars", value: 4, readonly: true))

    assert_selector "button[disabled]", count: 5
  end

  test "includes @extra_attrs" do
    render_inline(HotwireBits::RatingComponent.new(name: "stars", value: 2, data: { testid: "rating" }))

    assert_selector "div[data-testid='rating']"
  end
end

class FormFieldsetComponentTest < ViewComponent::TestCase
  test "renders fieldset with legend" do
    render_inline(HotwireBits::FormFieldsetComponent.new(legend: "Personal Info")) { "Fields here" }

    assert_selector "fieldset"
    assert_text "Personal Info"
    assert_text "Fields here"
  end
end

class ColorPickerComponentTest < ViewComponent::TestCase
  test "renders color picker" do
    render_inline(HotwireBits::ColorPickerComponent.new(name: "color", value: "#ff0000"))

    assert_selector "div[data-controller='hw-color-picker']"
  end
end

class InputOtpComponentTest < ViewComponent::TestCase
  test "renders OTP input" do
    render_inline(HotwireBits::InputOtpComponent.new(name: "code", length: 6))

    assert_selector "div[data-controller='hw-otp']"
    assert_selector "input", count: 6
  end
end
