import { describe, it, expect, afterEach } from "vitest"
import { setupController, teardownController, sleep } from "./setup.js"
import DropdownController from "../../app/javascript/controllers/hotwirebits/rb_dropdown_controller.js"

describe("DropdownController", () => {
  let app

  const html = `
    <div data-controller="hw-dropdown">
      <button data-hw-dropdown-target="trigger" data-action="click->hw-dropdown#toggle">Open</button>
      <div data-hw-dropdown-target="menu" class="hidden">
        <a role="menuitem" href="#">Item 1</a>
        <a role="menuitem" href="#">Item 2</a>
      </div>
    </div>
  `

  afterEach(() => teardownController(app))

  it("starts with menu hidden", async () => {
    const { application, container } = await setupController("hw-dropdown", DropdownController, html)
    app = application

    const menu = container.querySelector('[data-hw-dropdown-target="menu"]')
    expect(menu.classList.contains("hidden")).toBe(true)
  })

  it("opens menu on toggle", async () => {
    const { application, container } = await setupController("hw-dropdown", DropdownController, html)
    app = application

    const trigger = container.querySelector("button")
    const menu = container.querySelector('[data-hw-dropdown-target="menu"]')

    trigger.click()
    await sleep(10)

    expect(menu.classList.contains("hidden")).toBe(false)
    expect(trigger.getAttribute("aria-expanded")).toBe("true")
  })

  it("closes menu on second toggle", async () => {
    const { application, container } = await setupController("hw-dropdown", DropdownController, html)
    app = application

    const trigger = container.querySelector("button")
    const menu = container.querySelector('[data-hw-dropdown-target="menu"]')

    trigger.click()
    await sleep(10)
    trigger.click()
    await sleep(10)

    expect(menu.classList.contains("hidden")).toBe(true)
    expect(trigger.getAttribute("aria-expanded")).toBe("false")
  })

  it("closes on Escape key", async () => {
    const { application, container } = await setupController("hw-dropdown", DropdownController, html)
    app = application

    const trigger = container.querySelector("button")
    const menu = container.querySelector('[data-hw-dropdown-target="menu"]')

    trigger.click()
    await sleep(10)
    expect(menu.classList.contains("hidden")).toBe(false)

    document.dispatchEvent(new KeyboardEvent("keydown", { key: "Escape", bubbles: true }))
    await sleep(10)

    expect(menu.classList.contains("hidden")).toBe(true)
  })

  it("closes on outside click", async () => {
    const { application, container } = await setupController("hw-dropdown", DropdownController, html)
    app = application

    const trigger = container.querySelector("button")
    const menu = container.querySelector('[data-hw-dropdown-target="menu"]')

    trigger.click()
    await sleep(10)
    expect(menu.classList.contains("hidden")).toBe(false)

    // Click outside the dropdown
    document.body.click()
    await sleep(10)

    expect(menu.classList.contains("hidden")).toBe(true)
  })
})
