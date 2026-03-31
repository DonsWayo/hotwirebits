import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "list"]
  static values = { open: { type: Boolean, default: false } }

  connect() {
    this._onKeydown = (e) => {
      if ((e.metaKey || e.ctrlKey) && e.key === "k") { e.preventDefault(); this.openValue = !this.openValue }
      if (e.key === "Escape") this.openValue = false
    }
    document.addEventListener("keydown", this._onKeydown)
  }

  disconnect() { document.removeEventListener("keydown", this._onKeydown) }

  search() { this.dispatch("search", { detail: { query: this.inputTarget?.value || "" } }) }
  select(event) { this.dispatch("select", { detail: event.currentTarget.dataset }) }
}
