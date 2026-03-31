import { describe, it, expect, beforeEach, afterEach } from "vitest"
import { setupController, teardownController, sleep } from "./setup.js"
import TabsController from "../../app/javascript/controllers/hotwirebits/rb_tabs_controller.js"

describe("TabsController", () => {
  let app

  const html = `
    <div data-controller="hw-tabs" data-hw-tabs-active-value="0">
      <div data-hw-tabs-target="tab" data-action="click->hw-tabs#select" tabindex="0">Tab 1</div>
      <div data-hw-tabs-target="tab" data-action="click->hw-tabs#select" tabindex="-1">Tab 2</div>
      <div data-hw-tabs-target="tab" data-action="click->hw-tabs#select" tabindex="-1">Tab 3</div>
      <div data-hw-tabs-target="panel">Panel 1</div>
      <div data-hw-tabs-target="panel" class="hidden">Panel 2</div>
      <div data-hw-tabs-target="panel" class="hidden">Panel 3</div>
    </div>
  `

  afterEach(() => teardownController(app))

  it("activates first tab on connect", async () => {
    const { application, container } = await setupController("hw-tabs", TabsController, html)
    app = application

    const tabs = container.querySelectorAll('[data-hw-tabs-target="tab"]')
    const panels = container.querySelectorAll('[data-hw-tabs-target="panel"]')

    expect(tabs[0].getAttribute("aria-selected")).toBe("true")
    expect(tabs[1].getAttribute("aria-selected")).toBe("false")
    expect(panels[0].classList.contains("hidden")).toBe(false)
    expect(panels[1].classList.contains("hidden")).toBe(true)
  })

  it("switches tabs on click", async () => {
    const { application, container } = await setupController("hw-tabs", TabsController, html)
    app = application

    const tabs = container.querySelectorAll('[data-hw-tabs-target="tab"]')
    const panels = container.querySelectorAll('[data-hw-tabs-target="panel"]')

    tabs[1].click()
    await sleep(10)

    expect(tabs[0].getAttribute("aria-selected")).toBe("false")
    expect(tabs[1].getAttribute("aria-selected")).toBe("true")
    expect(panels[0].classList.contains("hidden")).toBe(true)
    expect(panels[1].classList.contains("hidden")).toBe(false)
  })

  it("sets tabindex correctly", async () => {
    const { application, container } = await setupController("hw-tabs", TabsController, html)
    app = application

    const tabs = container.querySelectorAll('[data-hw-tabs-target="tab"]')

    expect(tabs[0].getAttribute("tabindex")).toBe("0")
    expect(tabs[1].getAttribute("tabindex")).toBe("-1")

    tabs[2].click()
    await sleep(10)

    expect(tabs[0].getAttribute("tabindex")).toBe("-1")
    expect(tabs[2].getAttribute("tabindex")).toBe("0")
  })
})
