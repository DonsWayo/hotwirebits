import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { key: { type: String, default: "banner_dismissed" } }

  connect() {
    this._onAnimationEnd = this._onAnimationEnd.bind(this)
    if (localStorage.getItem(this.keyValue) === "true") {
      this.element.classList.add("hidden")
    }
  }

  disconnect() {
    this.element.removeEventListener("animationend", this._onAnimationEnd)
  }

  dismiss() {
    this.element.classList.add("animate-slide-up-out")
    this.element.addEventListener("animationend", this._onAnimationEnd)
  }

  _onAnimationEnd() {
    this.element.classList.add("hidden")
    localStorage.setItem(this.keyValue, "true")
    this.element.removeEventListener("animationend", this._onAnimationEnd)
  }
}
