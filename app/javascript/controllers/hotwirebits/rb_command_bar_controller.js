import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "list", "overlay"]
  static values = { open: { type: Boolean, default: false } }

  connect() {
    this._onKeydown = (e) => {
      if ((e.metaKey || e.ctrlKey) && e.key === "k") { e.preventDefault(); this.openValue = !this.openValue }
      if (e.key === "Escape") this.openValue = false
    }
    document.addEventListener("keydown", this._onKeydown)
  }

  disconnect() { document.removeEventListener("keydown", this._onKeydown) }

  openValueChanged() {
    if (this.hasOverlayTarget) {
      this.overlayTarget.classList.toggle("hidden", !this.openValue)
    }
    this.element.classList.toggle("open", this.openValue)
    if (this.openValue && this.hasInputTarget) {
      this.inputTarget.focus()
      this.inputTarget.value = ""
    }
    this.dispatch(this.openValue ? "open" : "close")
  }

  search() { this.dispatch("search", { detail: { query: this.inputTarget?.value || "" } }) }
  select(event) { this.openValue = false; this.dispatch("select", { detail: event.currentTarget.dataset }) }
  close() { this.openValue = false }
}
