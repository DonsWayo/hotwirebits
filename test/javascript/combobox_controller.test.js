import { describe, it, expect, afterEach } from "vitest"
import { setupController, teardownController, sleep } from "./setup.js"
import ComboboxController from "../../app/javascript/controllers/hotwirebits/rb_combobox_controller.js"

describe("ComboboxController", () => {
  let app

  const html = `
    <div data-controller="hw-combobox">
      <input data-hw-combobox-target="input" data-action="input->hw-combobox#filter keydown->hw-combobox#handleKeydown" type="text" />
      <input data-hw-combobox-target="hidden" type="hidden" />
      <ul data-hw-combobox-target="list" class="hidden">
        <li data-hw-combobox-target="option" data-value="apple" data-action="click->hw-combobox#select">Apple</li>
        <li data-hw-combobox-target="option" data-value="banana" data-action="click->hw-combobox#select">Banana</li>
        <li data-hw-combobox-target="option" data-value="cherry" data-action="click->hw-combobox#select">Cherry</li>
      </ul>
    </div>
  `

  afterEach(() => teardownController(app))

  it("opens list on filter", async () => {
    const { application, container } = await setupController("hw-combobox", ComboboxController, html)
    app = application

    const input = container.querySelector("input[type=text]")
    const list = container.querySelector("ul")

    expect(list.classList.contains("hidden")).toBe(true)

    // Simulate typing
    input.value = "a"
    input.dispatchEvent(new Event("input", { bubbles: true }))
    await sleep(10)

    expect(list.classList.contains("hidden")).toBe(false)
  })

  it("filters options based on input", async () => {
    const { application, container } = await setupController("hw-combobox", ComboboxController, html)
    app = application

    const input = container.querySelector("input[type=text]")
    input.value = "ban"
    input.dispatchEvent(new Event("input", { bubbles: true }))
    await sleep(10)

    const options = container.querySelectorAll('[data-hw-combobox-target="option"]')
    expect(options[0].classList.contains("hidden")).toBe(true) // Apple
    expect(options[1].classList.contains("hidden")).toBe(false) // Banana
    expect(options[2].classList.contains("hidden")).toBe(true) // Cherry
  })

  it("selects an option and updates hidden input", async () => {
    const { application, container } = await setupController("hw-combobox", ComboboxController, html)
    app = application

    const input = container.querySelector("input[type=text]")
    const hidden = container.querySelector("input[type=hidden]")
    const options = container.querySelectorAll('[data-hw-combobox-target="option"]')

    // Open the list
    input.value = "a"
    input.dispatchEvent(new Event("input", { bubbles: true }))
    await sleep(10)

    // Select banana
    options[1].click()
    await sleep(10)

    expect(input.value).toBe("Banana")
    expect(hidden.value).toBe("banana")
  })

  it("closes on outside click", async () => {
    const { application, container } = await setupController("hw-combobox", ComboboxController, html)
    app = application

    const input = container.querySelector("input[type=text]")
    const list = container.querySelector("ul")

    // Open
    input.value = "a"
    input.dispatchEvent(new Event("input", { bubbles: true }))
    await sleep(10)
    expect(list.classList.contains("hidden")).toBe(false)

    // Click outside
    document.body.click()
    await sleep(10)
    expect(list.classList.contains("hidden")).toBe(true)
  })

  it("closes on Escape", async () => {
    const { application, container } = await setupController("hw-combobox", ComboboxController, html)
    app = application

    const input = container.querySelector("input[type=text]")
    const list = container.querySelector("ul")

    // Open
    input.value = "a"
    input.dispatchEvent(new Event("input", { bubbles: true }))
    await sleep(10)

    const controller = application.getControllerForElementAndIdentifier(
      container.querySelector('[data-controller="hw-combobox"]'),
      "hw-combobox"
    )
    controller.handleKeydown(new KeyboardEvent("keydown", { key: "Escape", bubbles: true }))
    await sleep(10)

    expect(list.classList.contains("hidden")).toBe(true)
  })
})
