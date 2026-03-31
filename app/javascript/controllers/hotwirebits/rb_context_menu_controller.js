import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["menu"]

  connect() {
    this._onContext = (e) => {
      e.preventDefault()
      if (this.hasMenuTarget) {
        this.menuTarget.classList.remove("hidden")
        const rect = this.element.getBoundingClientRect()
        this.menuTarget.style.left = `${e.clientX - rect.left}px`
        this.menuTarget.style.top = `${e.clientY - rect.top}px`
      }
    }
    this._onClick = () => { if (this.hasMenuTarget) this.menuTarget.classList.add("hidden") }
    this.element.addEventListener("contextmenu", this._onContext)
    document.addEventListener("click", this._onClick)
  }

  disconnect() {
    this.element.removeEventListener("contextmenu", this._onContext)
    document.removeEventListener("click", this._onClick)
  }

  select(event) { this.dispatch("select", { detail: event.currentTarget.dataset }); if (this.hasMenuTarget) this.menuTarget.classList.add("hidden") }
}
