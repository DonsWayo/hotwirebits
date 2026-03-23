import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input"]
  static values = { on: { type: Boolean, default: false } }

  connect() {
    this.update()
  }

  toggle() {
    this.onValue = !this.onValue
    this.update()
    this.dispatch("change", { detail: { on: this.onValue } })
  }

  update() {
    this.element.setAttribute("aria-checked", this.onValue.toString())
    this.element.setAttribute("tabindex", "0")
    if (this.hasInputTarget) {
      this.inputTarget.checked = this.onValue
    }
    this.element.classList.toggle("is-on", this.onValue)
    this.element.classList.toggle("is-off", !this.onValue)
  }

  handleKeydown(event) {
    if (event.key === " " || event.key === "Enter") {
      event.preventDefault()
      this.toggle()
    }
  }
}
