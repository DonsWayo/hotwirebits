import { describe, it, expect, beforeEach, afterEach, vi } from "vitest"
import { setupController, teardownController, sleep } from "./setup.js"
import ThemeController from "../../app/javascript/controllers/hotwirebits/rb_theme_controller.js"

describe("ThemeController", () => {
  let app
  let originalMatchMedia

  function mockMatchMedia(prefersDark = false) {
    return vi.fn((query) => ({
      matches: prefersDark,
      media: query,
      addEventListener: vi.fn(),
      removeEventListener: vi.fn(),
      addListener: vi.fn(),
      removeListener: vi.fn(),
      onchange: null,
      dispatchEvent: vi.fn(),
    }))
  }

  beforeEach(() => {
    originalMatchMedia = window.matchMedia
    // Default mock — prefers light
    window.matchMedia = mockMatchMedia(false)
  })

  afterEach(() => {
    teardownController(app)
    app = null
    localStorage.clear()
    document.documentElement.removeAttribute("data-theme")
    document.documentElement.classList.remove("dark", "light")
    window.matchMedia = originalMatchMedia
  })

  const html = `
    <div data-controller="hw-theme">
      <button data-hw-theme-target="toggle" data-action="click->hw-theme#toggle">Toggle Theme</button>
    </div>
  `

  it("applies theme from localStorage on connect", async () => {
    localStorage.setItem("hw-theme", "dark")
    const { application } = await setupController("hw-theme", ThemeController, html)
    app = application

    expect(document.documentElement.getAttribute("data-theme")).toBe("dark")
    expect(document.documentElement.classList.contains("dark")).toBe(true)
  })

  it("applies light theme when no preference stored", async () => {
    const { application } = await setupController("hw-theme", ThemeController, html)
    app = application

    expect(document.documentElement.getAttribute("data-theme")).toBe("light")
    expect(document.documentElement.classList.contains("light")).toBe(true)
  })

  it("toggles from light to dark on click", async () => {
    const { application, container } = await setupController("hw-theme", ThemeController, html)
    app = application

    expect(document.documentElement.getAttribute("data-theme")).toBe("light")

    const button = container.querySelector("button")
    button.click()
    await sleep(10)

    expect(document.documentElement.getAttribute("data-theme")).toBe("dark")
    expect(localStorage.getItem("hw-theme")).toBe("dark")
  })

  it("toggles from dark to light", async () => {
    localStorage.setItem("hw-theme", "dark")
    const { application, container } = await setupController("hw-theme", ThemeController, html)
    app = application

    expect(document.documentElement.getAttribute("data-theme")).toBe("dark")

    const button = container.querySelector("button")
    button.click()
    await sleep(10)

    expect(document.documentElement.getAttribute("data-theme")).toBe("light")
    expect(localStorage.getItem("hw-theme")).toBe("light")
  })

  it("sets aria-label on toggle target", async () => {
    const { application, container } = await setupController("hw-theme", ThemeController, html)
    app = application

    const button = container.querySelector("button")
    // After connecting with "light" mode, label should mention switching to dark
    const label = button.getAttribute("aria-label")
    expect(label).not.toBeNull()
    expect(label).toContain("dark")

    button.click()
    await sleep(10)
    const label2 = button.getAttribute("aria-label")
    expect(label2).toContain("light")
  })
})
