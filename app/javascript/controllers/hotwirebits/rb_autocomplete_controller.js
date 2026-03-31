import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "dropdown", "hidden"]
  static values = { minLength: { type: Number, default: 1 } }

  connect() {
    this._onOutsideClick = (e) => { if (!this.element.contains(e.target)) this.close() }
    document.addEventListener("click", this._onOutsideClick)
  }

  disconnect() {
    document.removeEventListener("click", this._onOutsideClick)
  }

  search() {
    const q = this.inputTarget.value.trim()
    if (q.length < this.minLengthValue) { this.close(); return }
    this.open()
    this.dispatch("search", { detail: { query: q } })
  }

  open() { if (this.hasDropdownTarget) this.dropdownTarget.classList.remove("hidden") }
  close() { if (this.hasDropdownTarget) this.dropdownTarget.classList.add("hidden") }

  select(event) {
    const { value } = event.currentTarget.dataset
    const label = event.currentTarget.textContent.trim()
    this.inputTarget.value = label
    if (this.hasHiddenTarget) this.hiddenTarget.value = value
    this.close()
    this.dispatch("select", { detail: { value, label } })
  }
}
