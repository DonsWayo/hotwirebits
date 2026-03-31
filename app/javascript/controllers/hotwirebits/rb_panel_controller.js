import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["content", "chevron"]
  static values = { collapsed: { type: Boolean, default: false } }

  toggle() {
    this.collapsedValue = !this.collapsedValue
    if (this.hasContentTarget) this.contentTarget.classList.toggle("hidden", this.collapsedValue)
    if (this.hasChevronTarget) this.chevronTarget.classList.toggle("rotate-90", !this.collapsedValue)
  }
}
