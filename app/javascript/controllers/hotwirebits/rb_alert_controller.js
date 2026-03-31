import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { animation: { type: String, default: "fade" } }

  connect() {
    this._onAnimationEnd = this._onAnimationEnd.bind(this)
  }

  disconnect() {
    this.element.removeEventListener("animationend", this._onAnimationEnd)
  }

  dismiss() {
    this.element.classList.add(`animate-${this.animationValue}-out`)
    this.element.addEventListener("animationend", this._onAnimationEnd)
  }

  _onAnimationEnd() {
    this.element.classList.add("hidden")
    this.element.removeEventListener("animationend", this._onAnimationEnd)
    this.dispatch("dismissed")
  }
}
