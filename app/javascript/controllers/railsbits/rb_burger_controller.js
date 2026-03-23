import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["line1", "line2", "line3"]
  static values = { open: { type: Boolean, default: false } }

  toggle() {
    this.openValue = !this.openValue
    this.render()
    this.dispatch("change", { detail: { open: this.openValue } })
  }

  render() {
    this.element.setAttribute("aria-expanded", this.openValue.toString())
    this.element.classList.toggle("is-open", this.openValue)
    this.element.classList.toggle("is-closed", !this.openValue)
  }

  handleKeydown(event) {
    if (event.key === " " || event.key === "Enter") {
      event.preventDefault()
      this.toggle()
    }
  }
}
