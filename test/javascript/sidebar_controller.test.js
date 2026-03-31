import { describe, it, expect, afterEach } from "vitest"
import { setupController, teardownController, sleep } from "./setup.js"
import SidebarController from "../../app/javascript/controllers/hotwirebits/rb_sidebar_controller.js"

describe("SidebarController", () => {
  let app

  const html = `
    <div data-controller="hw-sidebar">
      <div data-hw-sidebar-target="sidebar">Sidebar</div>
      <div data-hw-sidebar-target="overlay" class="hidden">Overlay</div>
      <div data-hw-sidebar-target="main">Main</div>
      <button data-action="hw-sidebar#toggle">Toggle</button>
    </div>
  `

  afterEach(() => {
    teardownController(app)
    app = null
  })

  it("toggles sidebar on click", async () => {
    const { application, container } = await setupController("hw-sidebar", SidebarController, html)
    app = application

    const sidebar = container.querySelector('[data-hw-sidebar-target="sidebar"]')
    const btn = container.querySelector("button")

    btn.click()
    await sleep(10)
    expect(sidebar.classList.contains("sidebar-open")).toBe(true)

    btn.click()
    await sleep(10)
    expect(sidebar.classList.contains("sidebar-closed")).toBe(true)
  })

  it("closes on Escape key when not desktop", async () => {
    // Use a very high breakpoint so innerWidth (1024) < breakpoint => isDesktop = false
    const mobileHtml = `
      <div data-controller="hw-sidebar" data-hw-sidebar-breakpoint-value="2000">
        <div data-hw-sidebar-target="sidebar">Sidebar</div>
        <div data-hw-sidebar-target="overlay" class="hidden">Overlay</div>
        <div data-hw-sidebar-target="main">Main</div>
        <button data-action="hw-sidebar#toggle">Toggle</button>
      </div>
    `

    const { application, container } = await setupController("hw-sidebar", SidebarController, mobileHtml)
    app = application

    const sidebar = container.querySelector('[data-hw-sidebar-target="sidebar"]')
    const btn = container.querySelector("button")

    btn.click()
    await sleep(10)
    expect(sidebar.classList.contains("sidebar-open")).toBe(true)

    document.dispatchEvent(new KeyboardEvent("keydown", { key: "Escape", bubbles: true }))
    await sleep(10)

    expect(sidebar.classList.contains("sidebar-open")).toBe(false)
    expect(sidebar.classList.contains("sidebar-closed")).toBe(true)
  })

  it("does not close on Escape when on desktop", async () => {
    // Default breakpoint 768 < innerWidth 1024, so isDesktop = true
    const { application, container } = await setupController("hw-sidebar", SidebarController, html)
    app = application

    const sidebar = container.querySelector('[data-hw-sidebar-target="sidebar"]')
    const btn = container.querySelector("button")

    btn.click()
    await sleep(10)
    expect(sidebar.classList.contains("sidebar-open")).toBe(true)

    document.dispatchEvent(new KeyboardEvent("keydown", { key: "Escape", bubbles: true }))
    await sleep(10)

    // Should stay open because isDesktop is true
    expect(sidebar.classList.contains("sidebar-open")).toBe(true)
  })
})
