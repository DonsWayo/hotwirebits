import { describe, it, expect, afterEach, beforeEach, vi } from "vitest"
import { setupController, teardownController, sleep } from "./setup.js"
import BurgerController from "../../app/javascript/controllers/hotwirebits/rb_burger_controller.js"
import BannerController from "../../app/javascript/controllers/hotwirebits/rb_banner_controller.js"
import HoverCardController from "../../app/javascript/controllers/hotwirebits/rb_hover_card_controller.js"
import SwitchController from "../../app/javascript/controllers/hotwirebits/rb_switch_controller.js"
import SpoilerController from "../../app/javascript/controllers/hotwirebits/rb_spoiler_controller.js"
import SplitterController from "../../app/javascript/controllers/hotwirebits/rb_splitter_controller.js"
import SheetController from "../../app/javascript/controllers/hotwirebits/rb_sheet_controller.js"
import AutocompleteController from "../../app/javascript/controllers/hotwirebits/rb_autocomplete_controller.js"
import ClipboardController from "../../app/javascript/controllers/hotwirebits/rb_clipboard_controller.js"
import PasswordController from "../../app/javascript/controllers/hotwirebits/rb_password_controller.js"

describe("BurgerController", () => {
  let app
  afterEach(() => teardownController(app))

  it("toggles open state and aria-expanded", async () => {
    const { application, container } = await setupController("hw-burger", BurgerController,
      `<button data-controller="hw-burger" data-action="click->hw-burger#toggle" aria-expanded="false">
        <span data-hw-burger-target="line1"></span>
        <span data-hw-burger-target="line2"></span>
        <span data-hw-burger-target="line3"></span>
      </button>`)
    app = application
    const btn = container.querySelector("[data-controller]")
    btn.click()
    await sleep(10)
    expect(btn.getAttribute("aria-expanded")).toBe("true")
    expect(btn.classList.contains("is-open")).toBe(true)
    btn.click()
    await sleep(10)
    expect(btn.getAttribute("aria-expanded")).toBe("false")
    expect(btn.classList.contains("is-closed")).toBe(true)
  })

  it("handles keyboard Enter", async () => {
    const { application, container } = await setupController("hw-burger", BurgerController,
      `<button data-controller="hw-burger" data-action="keydown->hw-burger#handleKeydown">
      </button>`)
    app = application
    const btn = container.querySelector("[data-controller]")
    btn.dispatchEvent(new KeyboardEvent("keydown", { key: "Enter", bubbles: true }))
    await sleep(10)
    expect(btn.getAttribute("aria-expanded")).toBe("true")
  })
})

describe("BannerController", () => {
  let app
  beforeEach(() => { localStorage.clear() })
  afterEach(() => { teardownController(app); localStorage.clear() })

  it("hides banner if previously dismissed", async () => {
    localStorage.setItem("banner_dismissed", "true")
    const { application, container } = await setupController("hw-banner", BannerController,
      `<div data-controller="hw-banner" data-hw-banner-key-value="banner_dismissed">Banner</div>`)
    app = application
    expect(container.querySelector("[data-controller]").classList.contains("hidden")).toBe(true)
  })

  it("dismiss adds animation class", async () => {
    const { application, container } = await setupController("hw-banner", BannerController,
      `<div data-controller="hw-banner" data-hw-banner-key-value="test_banner">
        <button data-action="click->hw-banner#dismiss">X</button>
      </div>`)
    app = application
    container.querySelector("button").click()
    await sleep(10)
    expect(container.querySelector("[data-controller]").classList.contains("animate-slide-up-out")).toBe(true)
  })
})

describe("HoverCardController", () => {
  let app
  afterEach(() => teardownController(app))

  it("shows card on mouseenter and hides on mouseleave", async () => {
    const { application, container } = await setupController("hw-hover-card", HoverCardController,
      `<div data-controller="hw-hover-card" data-hw-hover-card-delay-value="0">
        <div data-hw-hover-card-target="card" class="hidden">Card content</div>
      </div>`)
    app = application
    const el = container.querySelector("[data-controller]")
    const card = container.querySelector("[data-hw-hover-card-target='card']")
    el.dispatchEvent(new MouseEvent("mouseenter", { bubbles: true }))
    await sleep(50)
    expect(card.classList.contains("hidden")).toBe(false)
    el.dispatchEvent(new MouseEvent("mouseleave", { bubbles: true }))
    await sleep(10)
    expect(card.classList.contains("hidden")).toBe(true)
  })
})

describe("SwitchController", () => {
  let app
  afterEach(() => teardownController(app))

  it("toggles on/off and updates aria-checked", async () => {
    const { application, container } = await setupController("hw-switch", SwitchController,
      `<div data-controller="hw-switch" data-hw-switch-on-value="false" data-action="click->hw-switch#toggle">
        <input data-hw-switch-target="input" type="checkbox">
      </div>`)
    app = application
    const el = container.querySelector("[data-controller]")
    expect(el.getAttribute("aria-checked")).toBe("false")
    expect(el.classList.contains("is-off")).toBe(true)
    el.click()
    await sleep(10)
    expect(el.getAttribute("aria-checked")).toBe("true")
    expect(el.classList.contains("is-on")).toBe(true)
    expect(container.querySelector("input").checked).toBe(true)
  })
})

describe("SpoilerController", () => {
  let app
  afterEach(() => teardownController(app))

  it("toggles between preview and full text", async () => {
    const { application, container } = await setupController("hw-spoiler", SpoilerController,
      `<div data-controller="hw-spoiler" data-hw-spoiler-open-value="false">
        <div data-hw-spoiler-target="preview">Short...</div>
        <div data-hw-spoiler-target="full" class="hidden">Full long text here</div>
        <button data-hw-spoiler-target="toggle" data-action="click->hw-spoiler#toggle">Show more</button>
      </div>`)
    app = application
    const preview = container.querySelector("[data-hw-spoiler-target='preview']")
    const full = container.querySelector("[data-hw-spoiler-target='full']")
    const toggle = container.querySelector("button")
    expect(full.classList.contains("hidden")).toBe(true)
    expect(preview.classList.contains("hidden")).toBe(false)
    toggle.click()
    await sleep(10)
    expect(full.classList.contains("hidden")).toBe(false)
    expect(preview.classList.contains("hidden")).toBe(true)
    expect(toggle.textContent).toBe("Show less")
  })
})

describe("SplitterController", () => {
  let app
  afterEach(() => teardownController(app))

  it("connects without error", async () => {
    const { application, container } = await setupController("hw-splitter", SplitterController,
      `<div data-controller="hw-splitter" data-hw-splitter-min-size-value="100" data-hw-splitter-max-size-value="800">
        <div data-hw-splitter-target="panel" style="width:200px;">Panel</div>
        <div data-hw-splitter-target="handle">||</div>
      </div>`)
    app = application
    expect(container.querySelector("[data-controller]")).toBeTruthy()
  })
})

describe("SheetController", () => {
  let app
  afterEach(() => teardownController(app))

  it("opens and closes sheet", async () => {
    const { application, container } = await setupController("hw-sheet", SheetController,
      `<div data-controller="hw-sheet" data-hw-sheet-side-value="right">
        <button data-action="click->hw-sheet#open">Open</button>
        <div data-hw-sheet-target="sheet" class="translate-x-full">Sheet Content</div>
      </div>`)
    app = application
    const sheet = container.querySelector("[data-hw-sheet-target='sheet']")
    container.querySelector("button").click()
    await sleep(10)
    expect(sheet.classList.contains("translate-x-0")).toBe(true)
    expect(sheet.classList.contains("translate-x-full")).toBe(false)
    // Close with Escape
    document.dispatchEvent(new KeyboardEvent("keydown", { key: "Escape", bubbles: true }))
    await sleep(10)
    expect(sheet.classList.contains("translate-x-full")).toBe(true)
  })
})

describe("AutocompleteController", () => {
  let app
  afterEach(() => teardownController(app))

  it("opens dropdown on search and selects option", async () => {
    const { application, container } = await setupController("hw-autocomplete", AutocompleteController,
      `<div data-controller="hw-autocomplete" data-hw-autocomplete-min-length-value="1">
        <input data-hw-autocomplete-target="input" data-action="input->hw-autocomplete#search" value="te">
        <div data-hw-autocomplete-target="dropdown" class="hidden">
          <div data-action="click->hw-autocomplete#select" data-value="1">Test Item</div>
        </div>
        <input data-hw-autocomplete-target="hidden" type="hidden">
      </div>`)
    app = application
    const input = container.querySelector("[data-hw-autocomplete-target='input']")
    const dropdown = container.querySelector("[data-hw-autocomplete-target='dropdown']")
    input.dispatchEvent(new Event("input", { bubbles: true }))
    await sleep(10)
    expect(dropdown.classList.contains("hidden")).toBe(false)
    // Select an option
    container.querySelector("[data-action*='select']").click()
    await sleep(10)
    expect(input.value).toBe("Test Item")
    expect(container.querySelector("[data-hw-autocomplete-target='hidden']").value).toBe("1")
    expect(dropdown.classList.contains("hidden")).toBe(true)
  })
})

describe("ClipboardController", () => {
  let app
  afterEach(() => teardownController(app))

  it("copies text value and shows feedback", async () => {
    // Mock clipboard API
    const original = navigator.clipboard
    Object.defineProperty(navigator, "clipboard", {
      value: { writeText: vi.fn().mockResolvedValue(undefined) },
      writable: true, configurable: true
    })
    const { application, container } = await setupController("hw-clipboard", ClipboardController,
      `<div data-controller="hw-clipboard" data-hw-clipboard-text-value="Hello">
        <span data-hw-clipboard-target="source">Hello</span>
        <span data-hw-clipboard-target="feedback" class="hidden"></span>
        <button data-action="click->hw-clipboard#copy">Copy</button>
      </div>`)
    app = application
    container.querySelector("button").click()
    await sleep(50)
    expect(navigator.clipboard.writeText).toHaveBeenCalledWith("Hello")
    const feedback = container.querySelector("[data-hw-clipboard-target='feedback']")
    expect(feedback.textContent).toBe("Copied!")
    expect(feedback.classList.contains("hidden")).toBe(false)
    // Restore
    Object.defineProperty(navigator, "clipboard", { value: original, writable: true, configurable: true })
  })
})

describe("PasswordController", () => {
  let app
  afterEach(() => teardownController(app))

  it("toggles password visibility", async () => {
    const { application, container } = await setupController("hw-password", PasswordController,
      `<div data-controller="hw-password">
        <input data-hw-password-target="input" type="password" value="secret">
        <button data-hw-password-target="toggle" data-action="click->hw-password#toggle" aria-pressed="false">Show</button>
      </div>`)
    app = application
    const input = container.querySelector("input")
    const toggle = container.querySelector("button")
    expect(input.type).toBe("password")
    toggle.click()
    await sleep(10)
    expect(input.type).toBe("text")
    expect(toggle.getAttribute("aria-pressed")).toBe("true")
    toggle.click()
    await sleep(10)
    expect(input.type).toBe("password")
  })

  it("checks password strength", async () => {
    const { application, container } = await setupController("hw-password", PasswordController,
      `<div data-controller="hw-password">
        <input data-hw-password-target="input" type="password" data-action="input->hw-password#checkStrength" value="">
        <div data-hw-password-target="meter" class="strength-meter"></div>
        <span data-hw-password-target="label"></span>
      </div>`)
    app = application
    const input = container.querySelector("input")
    const label = container.querySelector("[data-hw-password-target='label']")
    input.value = "Str0ng!Pass"
    input.dispatchEvent(new Event("input", { bubbles: true }))
    await sleep(10)
    expect(label.textContent).toBe("strong")
  })
})
