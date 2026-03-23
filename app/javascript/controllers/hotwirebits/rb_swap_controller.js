import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["on", "off"]
  static values = { active: { type: Boolean, default: true } }

  connect() {
    this.render()
  }

  swap() {
    this.activeValue = !this.activeValue
    this.render()
    this.dispatch("change", { detail: { active: this.activeValue } })
  }

  render() {
    if (this.hasOnTarget) this.onTarget.classList.toggle("hidden", !this.activeValue)
    if (this.hasOffTarget) this.offTarget.classList.toggle("hidden", this.activeValue)
    this.element.setAttribute("aria-pressed", this.activeValue.toString())
  }
}
