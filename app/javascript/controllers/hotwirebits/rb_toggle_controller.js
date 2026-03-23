import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { pressed: { type: Boolean, default: false } }

  connect() {
    this.update()
  }

  toggle() {
    this.pressedValue = !this.pressedValue
    this.update()
    this.dispatch("change", { detail: { pressed: this.pressedValue } })
  }

  update() {
    this.element.setAttribute("aria-pressed", this.pressedValue.toString())
    this.element.classList.toggle("is-pressed", this.pressedValue)
    this.element.classList.toggle("is-unpressed", !this.pressedValue)
  }

  handleKeydown(event) {
    if (event.key === " " || event.key === "Enter") {
      event.preventDefault()
      this.toggle()
    }
  }
}
