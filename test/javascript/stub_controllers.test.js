import { describe, it, expect } from "vitest"
import { setupController, teardownController } from "./setup.js"

// Import all stub controllers (they only set data-hw-ready="true" on connect)
import AnimatedNumberController from "../../app/javascript/controllers/hotwirebits/rb_animated_number_controller.js"
import CodeHighlightController from "../../app/javascript/controllers/hotwirebits/rb_code_highlight_controller.js"
import ColorInputController from "../../app/javascript/controllers/hotwirebits/rb_color_input_controller.js"
import ColorPickerController from "../../app/javascript/controllers/hotwirebits/rb_color_picker_controller.js"
import Hover3dController from "../../app/javascript/controllers/hotwirebits/rb_hover_3d_controller.js"
import HoverGalleryController from "../../app/javascript/controllers/hotwirebits/rb_hover_gallery_controller.js"
import ImageCompareController from "../../app/javascript/controllers/hotwirebits/rb_image_compare_controller.js"
import ImageController from "../../app/javascript/controllers/hotwirebits/rb_image_controller.js"
import ImageZoomController from "../../app/javascript/controllers/hotwirebits/rb_image_zoom_controller.js"
import InlineEditController from "../../app/javascript/controllers/hotwirebits/rb_inline_edit_controller.js"
import InplaceController from "../../app/javascript/controllers/hotwirebits/rb_inplace_controller.js"
import JsonInputController from "../../app/javascript/controllers/hotwirebits/rb_json_input_controller.js"
import KnobController from "../../app/javascript/controllers/hotwirebits/rb_knob_controller.js"
import LikeController from "../../app/javascript/controllers/hotwirebits/rb_like_controller.js"
import ListboxController from "../../app/javascript/controllers/hotwirebits/rb_listbox_controller.js"
import MonthPickerController from "../../app/javascript/controllers/hotwirebits/rb_month_picker_controller.js"
import MonthPickerInputController from "../../app/javascript/controllers/hotwirebits/rb_month_picker_input_controller.js"
import NavMenuController from "../../app/javascript/controllers/hotwirebits/rb_nav_menu_controller.js"
import NewsletterController from "../../app/javascript/controllers/hotwirebits/rb_newsletter_controller.js"
import NotificationController from "../../app/javascript/controllers/hotwirebits/rb_notification_controller.js"
import PasswordStrengthController from "../../app/javascript/controllers/hotwirebits/rb_password_strength_controller.js"
import PasswordToggleController from "../../app/javascript/controllers/hotwirebits/rb_password_toggle_controller.js"
import PortalController from "../../app/javascript/controllers/hotwirebits/rb_portal_controller.js"
import QuickviewController from "../../app/javascript/controllers/hotwirebits/rb_quickview_controller.js"
import RangeSliderController from "../../app/javascript/controllers/hotwirebits/rb_range_slider_controller.js"
import RichTextEditorController from "../../app/javascript/controllers/hotwirebits/rb_rich_text_editor_controller.js"
import SignatureController from "../../app/javascript/controllers/hotwirebits/rb_signature_controller.js"
import TextRotateController from "../../app/javascript/controllers/hotwirebits/rb_text_rotate_controller.js"
import ThemeSelectorController from "../../app/javascript/controllers/hotwirebits/rb_theme_selector_controller.js"
import TimePickerController from "../../app/javascript/controllers/hotwirebits/rb_time_picker_controller.js"
import TooltipController from "../../app/javascript/controllers/hotwirebits/rb_tooltip_controller.js"
import TwoFactorController from "../../app/javascript/controllers/hotwirebits/rb_two_factor_controller.js"
import ValidatorController from "../../app/javascript/controllers/hotwirebits/rb_validator_controller.js"
import VoiceRecorderController from "../../app/javascript/controllers/hotwirebits/rb_voice_recorder_controller.js"

const stubs = [
  ["hw-animated-number", AnimatedNumberController],
  ["hw-code-highlight", CodeHighlightController],
  ["hw-color-input", ColorInputController],
  ["hw-color-picker", ColorPickerController],
  ["hw-hover-3d", Hover3dController],
  ["hw-hover-gallery", HoverGalleryController],
  ["hw-image-compare", ImageCompareController],
  ["hw-image", ImageController],
  ["hw-image-zoom", ImageZoomController],
  ["hw-inline-edit", InlineEditController],
  ["hw-inplace", InplaceController],
  ["hw-json-input", JsonInputController],
  ["hw-knob", KnobController],
  ["hw-like", LikeController],
  ["hw-listbox", ListboxController],
  ["hw-month-picker", MonthPickerController],
  ["hw-month-picker-input", MonthPickerInputController],
  ["hw-nav-menu", NavMenuController],
  ["hw-newsletter", NewsletterController],
  ["hw-notification", NotificationController],
  ["hw-password-strength", PasswordStrengthController],
  ["hw-password-toggle", PasswordToggleController],
  ["hw-portal", PortalController],
  ["hw-quickview", QuickviewController],
  ["hw-range-slider", RangeSliderController],
  ["hw-rich-text-editor", RichTextEditorController],
  ["hw-signature", SignatureController],
  ["hw-text-rotate", TextRotateController],
  ["hw-theme-selector", ThemeSelectorController],
  ["hw-time-picker", TimePickerController],
  ["hw-tooltip", TooltipController],
  ["hw-two-factor", TwoFactorController],
  ["hw-validator", ValidatorController],
  ["hw-voice-recorder", VoiceRecorderController],
]

describe("Stub controllers (data-hw-ready)", () => {
  stubs.forEach(([identifier, controllerClass]) => {
    it(`${identifier} sets data-hw-ready on connect`, async () => {
      const html = `<div data-controller="${identifier}">content</div>`
      const { application, container } = await setupController(identifier, controllerClass, html)

      const el = container.querySelector(`[data-controller="${identifier}"]`)
      expect(el.getAttribute("data-hw-ready")).toBe("true")

      teardownController(application)
    })
  })
})
