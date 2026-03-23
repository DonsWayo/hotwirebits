import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["full", "preview", "toggle"]
  static values = { maxLines: { type: Number, default: 3 }, open: { type: Boolean, default: false } }

  connect() {
    if (!this.openValue) {
      this.previewTarget.classList.remove("hidden")
      this.fullTarget.classList.add("hidden")
    } else {
      this.previewTarget.classList.add("hidden")
      this.fullTarget.classList.remove("hidden")
    }
  }

  toggle() {
    this.openValue = !this.openValue
    this.fullTarget.classList.toggle("hidden", !this.openValue)
    this.previewTarget.classList.toggle("hidden", this.openValue)
    if (this.hasToggleTarget) {
      this.toggleTarget.textContent = this.openValue ? "Show less" : "Show more"
      this.toggleTarget.setAttribute("aria-expanded", this.openValue.toString())
    }
  }
}
