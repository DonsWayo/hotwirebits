import { describe, it, expect, afterEach } from "vitest"
import { setupController, teardownController, sleep } from "./setup.js"
import ContextMenuController from "../../app/javascript/controllers/hotwirebits/rb_context_menu_controller.js"

describe("ContextMenuController", () => {
  let app

  const html = `
    <div data-controller="hw-context-menu" style="position:relative;width:400px;height:400px;">
      <div data-hw-context-menu-target="menu" class="hidden" style="position:absolute;">
        <button data-action="hw-context-menu#select" data-value="edit">Edit</button>
        <button data-action="hw-context-menu#select" data-value="delete">Delete</button>
      </div>
    </div>
  `

  afterEach(() => teardownController(app))

  it("shows menu on right-click", async () => {
    const { application, container } = await setupController("hw-context-menu", ContextMenuController, html)
    app = application

    const element = container.querySelector('[data-controller="hw-context-menu"]')
    const menu = container.querySelector('[data-hw-context-menu-target="menu"]')

    element.dispatchEvent(new MouseEvent("contextmenu", {
      bubbles: true,
      clientX: 100,
      clientY: 100
    }))
    await sleep(10)

    expect(menu.classList.contains("hidden")).toBe(false)
  })

  it("positions menu at cursor position relative to container (bug fix)", async () => {
    const { application, container } = await setupController("hw-context-menu", ContextMenuController, html)
    app = application

    const element = container.querySelector('[data-controller="hw-context-menu"]')
    const menu = container.querySelector('[data-hw-context-menu-target="menu"]')

    // Mock getBoundingClientRect for the element
    element.getBoundingClientRect = () => ({
      left: 50, top: 50, right: 450, bottom: 450, width: 400, height: 400, x: 50, y: 50
    })

    element.dispatchEvent(new MouseEvent("contextmenu", {
      bubbles: true,
      clientX: 150,
      clientY: 200
    }))
    await sleep(10)

    // Should be clientX - rect.left = 150 - 50 = 100
    expect(menu.style.left).toBe("100px")
    // Should be clientY - rect.top = 200 - 50 = 150
    expect(menu.style.top).toBe("150px")
  })

  it("hides menu on click elsewhere", async () => {
    const { application, container } = await setupController("hw-context-menu", ContextMenuController, html)
    app = application

    const element = container.querySelector('[data-controller="hw-context-menu"]')
    const menu = container.querySelector('[data-hw-context-menu-target="menu"]')

    element.dispatchEvent(new MouseEvent("contextmenu", { bubbles: true, clientX: 100, clientY: 100 }))
    await sleep(10)
    expect(menu.classList.contains("hidden")).toBe(false)

    document.body.click()
    await sleep(10)
    expect(menu.classList.contains("hidden")).toBe(true)
  })

  it("hides menu on select", async () => {
    const { application, container } = await setupController("hw-context-menu", ContextMenuController, html)
    app = application

    const element = container.querySelector('[data-controller="hw-context-menu"]')
    const menu = container.querySelector('[data-hw-context-menu-target="menu"]')

    element.dispatchEvent(new MouseEvent("contextmenu", { bubbles: true, clientX: 100, clientY: 100 }))
    await sleep(10)

    const btn = container.querySelector('[data-value="edit"]')
    btn.click()
    await sleep(10)

    expect(menu.classList.contains("hidden")).toBe(true)
  })
})
