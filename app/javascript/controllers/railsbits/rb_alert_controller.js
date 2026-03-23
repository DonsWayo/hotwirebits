import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { animation: { type: String, default: "fade" } }

  dismiss() {
    this.element.classList.add(`animate-${this.animationValue}-out`)
    this.element.addEventListener("animationend", () => {
      this.element.classList.add("hidden")
      this.dispatch("dismissed")
    })
  }
}
