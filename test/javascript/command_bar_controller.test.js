import { describe, it, expect, afterEach } from "vitest"
import { setupController, teardownController, sleep } from "./setup.js"
import CommandBarController from "../../app/javascript/controllers/hotwirebits/rb_command_bar_controller.js"

describe("CommandBarController", () => {
  let app

  const html = `
    <div data-controller="hw-command-bar">
      <div data-hw-command-bar-target="overlay" class="hidden">
        <input data-hw-command-bar-target="input" data-action="input->hw-command-bar#search" type="text" />
        <ul data-hw-command-bar-target="list">
          <li data-action="click->hw-command-bar#select" data-value="item1">Item 1</li>
          <li data-action="click->hw-command-bar#select" data-value="item2">Item 2</li>
        </ul>
      </div>
    </div>
  `

  afterEach(() => teardownController(app))

  it("opens on Cmd+K", async () => {
    const { application, container } = await setupController("hw-command-bar", CommandBarController, html)
    app = application

    const overlay = container.querySelector('[data-hw-command-bar-target="overlay"]')
    expect(overlay.classList.contains("hidden")).toBe(true)

    document.dispatchEvent(new KeyboardEvent("keydown", { key: "k", metaKey: true, bubbles: true }))
    await sleep(50)

    expect(overlay.classList.contains("hidden")).toBe(false)
    expect(container.querySelector('[data-controller="hw-command-bar"]').classList.contains("open")).toBe(true)
  })

  it("closes on Escape", async () => {
    const { application, container } = await setupController("hw-command-bar", CommandBarController, html)
    app = application

    const overlay = container.querySelector('[data-hw-command-bar-target="overlay"]')

    // Open first
    document.dispatchEvent(new KeyboardEvent("keydown", { key: "k", metaKey: true, bubbles: true }))
    await sleep(50)
    expect(overlay.classList.contains("hidden")).toBe(false)

    // Close
    document.dispatchEvent(new KeyboardEvent("keydown", { key: "Escape", bubbles: true }))
    await sleep(50)

    expect(overlay.classList.contains("hidden")).toBe(true)
  })

  it("closes on select", async () => {
    const { application, container } = await setupController("hw-command-bar", CommandBarController, html)
    app = application

    // Open first
    document.dispatchEvent(new KeyboardEvent("keydown", { key: "k", metaKey: true, bubbles: true }))
    await sleep(50)

    const item = container.querySelector('[data-value="item1"]')
    item.click()
    await sleep(50)

    const overlay = container.querySelector('[data-hw-command-bar-target="overlay"]')
    expect(overlay.classList.contains("hidden")).toBe(true)
  })

  it("toggles on repeated Cmd+K (bug fix: openValueChanged callback)", async () => {
    const { application, container } = await setupController("hw-command-bar", CommandBarController, html)
    app = application

    const overlay = container.querySelector('[data-hw-command-bar-target="overlay"]')

    // Open
    document.dispatchEvent(new KeyboardEvent("keydown", { key: "k", metaKey: true, bubbles: true }))
    await sleep(50)
    expect(overlay.classList.contains("hidden")).toBe(false)

    // Close with another Cmd+K
    document.dispatchEvent(new KeyboardEvent("keydown", { key: "k", metaKey: true, bubbles: true }))
    await sleep(50)
    expect(overlay.classList.contains("hidden")).toBe(true)
  })
})
