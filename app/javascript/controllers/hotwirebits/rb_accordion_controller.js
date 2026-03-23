import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["content"]
  static values = { open: { type: Boolean, default: false } }

  toggle() {
    this.openValue = !this.openValue
    this.contentTarget.classList.toggle("hidden", !this.openValue)
    this.trigger?.setAttribute("aria-expanded", this.openValue.toString())
  }

  get trigger() {
    return this.element.querySelector('[data-action~="hw-accordion#toggle"]')
  }
}
