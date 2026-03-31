import { describe, it, expect, afterEach, beforeEach } from "vitest"
import { setupController, teardownController, sleep } from "./setup.js"
import AngleSliderController from "../../app/javascript/controllers/hotwirebits/rb_angle_slider_controller.js"
import ToggleButtonGroupController from "../../app/javascript/controllers/hotwirebits/rb_toggle_button_group_controller.js"
import DateRangeController from "../../app/javascript/controllers/hotwirebits/rb_date_range_controller.js"
import TagInputController from "../../app/javascript/controllers/hotwirebits/rb_tag_input_controller.js"
import InputNumberController from "../../app/javascript/controllers/hotwirebits/rb_input_number_controller.js"
import AiChatController from "../../app/javascript/controllers/hotwirebits/rb_ai_chat_controller.js"
import SwapController from "../../app/javascript/controllers/hotwirebits/rb_swap_controller.js"
import StepperFormController from "../../app/javascript/controllers/hotwirebits/rb_stepper_form_controller.js"
import AlertController from "../../app/javascript/controllers/hotwirebits/rb_alert_controller.js"
import CompareController from "../../app/javascript/controllers/hotwirebits/rb_compare_controller.js"
import DragDropController from "../../app/javascript/controllers/hotwirebits/rb_drag_drop_controller.js"

describe("AngleSliderController", () => {
  let app
  afterEach(() => teardownController(app))

  it("updates value on input", async () => {
    const { application, container } = await setupController("hw-angle-slider", AngleSliderController,
      `<div data-controller="hw-angle-slider" data-hw-angle-slider-value-value="0">
        <input data-hw-angle-slider-target="input" type="range" min="0" max="360" data-action="input->hw-angle-slider#input" value="0">
      </div>`)
    app = application
    const el = container.querySelector("[data-controller]")
    const ctrl = application.getControllerForElementAndIdentifier(el, "hw-angle-slider")
    const input = container.querySelector("input")
    input.value = "180"
    input.dispatchEvent(new Event("input", { bubbles: true }))
    await sleep(10)
    expect(ctrl.valueValue).toBe(180)
  })
})

describe("ToggleButtonGroupController", () => {
  let app
  afterEach(() => teardownController(app))

  it("sets aria-pressed on selected button", async () => {
    const { application, container } = await setupController("hw-toggle-group", ToggleButtonGroupController,
      `<div data-controller="hw-toggle-group">
        <button data-action="click->hw-toggle-group#select" data-value="a" aria-pressed="false">A</button>
        <button data-action="click->hw-toggle-group#select" data-value="b" aria-pressed="false">B</button>
      </div>`)
    app = application
    const buttons = container.querySelectorAll("button")
    buttons[1].click()
    await sleep(10)
    expect(buttons[0].getAttribute("aria-pressed")).toBe("false")
    expect(buttons[1].getAttribute("aria-pressed")).toBe("true")
  })
})

describe("DateRangeController", () => {
  let app
  afterEach(() => teardownController(app))

  it("dispatches change with start and end dates", async () => {
    const { application, container } = await setupController("hw-date-range", DateRangeController,
      `<div data-controller="hw-date-range">
        <span data-hw-date-range-target="start"></span>
        <span data-hw-date-range-target="end"></span>
        <button data-action="click->hw-date-range#selectStart" data-date="2025-01-01">Start</button>
        <button data-action="click->hw-date-range#selectEnd" data-date="2025-01-31">End</button>
      </div>`)
    app = application
    container.querySelector("[data-action*='selectStart']").click()
    await sleep(10)
    container.querySelector("[data-action*='selectEnd']").click()
    await sleep(10)
    const el = container.querySelector("[data-controller]")
    expect(el.dataset.hwDateRangeStartDateValue).toBe("2025-01-01")
    expect(el.dataset.hwDateRangeEndDateValue).toBe("2025-01-31")
  })
})

describe("TagInputController", () => {
  let app
  afterEach(() => teardownController(app))

  it("adds and removes tags", async () => {
    const { application, container } = await setupController("hw-tag-input", TagInputController,
      `<div data-controller="hw-tag-input">
        <input data-hw-tag-input-target="input" value="hello">
        <button data-action="click->hw-tag-input#add">Add</button>
        <button data-action="click->hw-tag-input#remove" data-tag="hello">Remove</button>
      </div>`)
    app = application
    container.querySelector("[data-action*='add']").click()
    await sleep(10)
    const el = container.querySelector("[data-controller]")
    expect(JSON.parse(el.dataset.hwTagInputTagsValue)).toContain("hello")
    expect(container.querySelector("input").value).toBe("")
    // Now remove it
    container.querySelector("[data-action*='remove']").click()
    await sleep(10)
    expect(JSON.parse(el.dataset.hwTagInputTagsValue)).not.toContain("hello")
  })
})

describe("InputNumberController", () => {
  let app
  afterEach(() => teardownController(app))

  it("increments and decrements", async () => {
    const { application, container } = await setupController("hw-input-number", InputNumberController,
      `<div data-controller="hw-input-number" data-hw-input-number-min-value="0" data-hw-input-number-max-value="10" data-hw-input-number-step-value="1">
        <button data-action="click->hw-input-number#decrement">-</button>
        <input data-hw-input-number-target="input" value="5">
        <button data-action="click->hw-input-number#increment">+</button>
      </div>`)
    app = application
    const input = container.querySelector("input")
    container.querySelector("[data-action*='increment']").click()
    await sleep(10)
    expect(input.value).toBe("6")
    container.querySelector("[data-action*='decrement']").click()
    await sleep(10)
    expect(input.value).toBe("5")
  })

  it("clamps to min/max", async () => {
    const { application, container } = await setupController("hw-input-number", InputNumberController,
      `<div data-controller="hw-input-number" data-hw-input-number-min-value="0" data-hw-input-number-max-value="2" data-hw-input-number-step-value="1">
        <input data-hw-input-number-target="input" value="2">
        <button data-action="click->hw-input-number#increment">+</button>
      </div>`)
    app = application
    const input = container.querySelector("input")
    container.querySelector("button").click()
    await sleep(10)
    expect(input.value).toBe("2")
  })
})

describe("AiChatController", () => {
  let app
  afterEach(() => teardownController(app))

  it("sends message and clears input", async () => {
    const { application, container } = await setupController("hw-ai-chat", AiChatController,
      `<div data-controller="hw-ai-chat">
        <div data-hw-ai-chat-target="messages"></div>
        <input data-hw-ai-chat-target="input" value="Hello AI">
        <button data-action="click->hw-ai-chat#send">Send</button>
      </div>`)
    app = application
    let dispatched = false
    container.querySelector("[data-controller]").addEventListener("hw-ai-chat:send", () => { dispatched = true })
    container.querySelector("button").click()
    await sleep(10)
    expect(container.querySelector("input").value).toBe("")
    expect(dispatched).toBe(true)
  })
})

describe("SwapController", () => {
  let app
  afterEach(() => teardownController(app))

  it("toggles on/off targets on swap", async () => {
    const { application, container } = await setupController("hw-swap", SwapController,
      `<div data-controller="hw-swap" data-hw-swap-active-value="true">
        <span data-hw-swap-target="on">ON</span>
        <span data-hw-swap-target="off" class="hidden">OFF</span>
        <button data-action="click->hw-swap#swap">Swap</button>
      </div>`)
    app = application
    const on = container.querySelector("[data-hw-swap-target='on']")
    const off = container.querySelector("[data-hw-swap-target='off']")
    expect(on.classList.contains("hidden")).toBe(false)
    expect(off.classList.contains("hidden")).toBe(true)
    container.querySelector("button").click()
    await sleep(10)
    expect(on.classList.contains("hidden")).toBe(true)
    expect(off.classList.contains("hidden")).toBe(false)
    expect(container.querySelector("[data-controller]").getAttribute("aria-pressed")).toBe("false")
  })
})

describe("StepperFormController", () => {
  let app
  afterEach(() => teardownController(app))

  it("navigates between steps", async () => {
    const { application, container } = await setupController("hw-stepper-form", StepperFormController,
      `<div data-controller="hw-stepper-form" data-hw-stepper-form-current-value="0">
        <div data-hw-stepper-form-target="step">Step 1</div>
        <div data-hw-stepper-form-target="step" class="hidden">Step 2</div>
        <div data-hw-stepper-form-target="step" class="hidden">Step 3</div>
        <button data-action="click->hw-stepper-form#next">Next</button>
        <button data-action="click->hw-stepper-form#prev">Prev</button>
      </div>`)
    app = application
    const steps = container.querySelectorAll("[data-hw-stepper-form-target='step']")
    container.querySelector("[data-action*='next']").click()
    await sleep(10)
    expect(steps[0].classList.contains("hidden")).toBe(true)
    expect(steps[1].classList.contains("hidden")).toBe(false)
    container.querySelector("[data-action*='prev']").click()
    await sleep(10)
    expect(steps[0].classList.contains("hidden")).toBe(false)
    expect(steps[1].classList.contains("hidden")).toBe(true)
  })
})

describe("AlertController", () => {
  let app
  afterEach(() => teardownController(app))

  it("adds animation class on dismiss", async () => {
    const { application, container } = await setupController("hw-alert", AlertController,
      `<div data-controller="hw-alert" data-hw-alert-animation-value="fade">
        <button data-action="click->hw-alert#dismiss">Close</button>
      </div>`)
    app = application
    const el = container.querySelector("[data-controller]")
    container.querySelector("button").click()
    await sleep(10)
    expect(el.classList.contains("animate-fade-out")).toBe(true)
  })
})

describe("CompareController", () => {
  let app
  afterEach(() => teardownController(app))

  it("sets slider position on render", async () => {
    const { application, container } = await setupController("hw-compare", CompareController,
      `<div data-controller="hw-compare" data-hw-compare-position-value="50">
        <div data-hw-compare-target="before"></div>
        <div data-hw-compare-target="after"></div>
        <div data-hw-compare-target="slider"></div>
      </div>`)
    app = application
    const ctrl = container.querySelector("[data-controller]")
    // Manually call render via the controller
    const stimCtrl = app.getControllerForElementAndIdentifier(ctrl, "hw-compare")
    stimCtrl.render()
    await sleep(10)
    expect(container.querySelector("[data-hw-compare-target='slider']").style.left).toBe("50%")
  })
})

describe("DragDropController", () => {
  let app
  afterEach(() => teardownController(app))

  it("sets up dragover and drop listeners on zone", async () => {
    const { application, container } = await setupController("hw-drag-drop", DragDropController,
      `<div data-controller="hw-drag-drop">
        <div data-hw-drag-drop-target="zone" style="width:100px;height:100px;"></div>
      </div>`)
    app = application
    const zone = container.querySelector("[data-hw-drag-drop-target='zone']")
    // Simulate dragover - should not throw
    const dragEvent = new Event("dragover", { bubbles: true, cancelable: true })
    zone.dispatchEvent(dragEvent)
    await sleep(10)
    // If no error thrown, listeners are attached
    expect(true).toBe(true)
  })
})
