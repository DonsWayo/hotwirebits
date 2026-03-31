import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["card"]
  static values = { delay: { type: Number, default: 300 } }

  connect() {
    this._onEnter = () => { this._timeout = setTimeout(() => { if (this.hasCardTarget) this.cardTarget.classList.remove("hidden") }, this.delayValue) }
    this._onLeave = () => { clearTimeout(this._timeout); if (this.hasCardTarget) this.cardTarget.classList.add("hidden") }
    this.element.addEventListener("mouseenter", this._onEnter)
    this.element.addEventListener("mouseleave", this._onLeave)
  }

  disconnect() {
    this.element.removeEventListener("mouseenter", this._onEnter)
    this.element.removeEventListener("mouseleave", this._onLeave)
    clearTimeout(this._timeout)
  }
}
