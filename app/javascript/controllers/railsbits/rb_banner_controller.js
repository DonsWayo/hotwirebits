import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { key: { type: String, default: "banner_dismissed" } }

  connect() {
    if (localStorage.getItem(this.keyValue) === "true") {
      this.element.classList.add("hidden")
    }
  }

  dismiss() {
    this.element.classList.add("animate-slide-up-out")
    this.element.addEventListener("animationend", () => {
      this.element.classList.add("hidden")
      localStorage.setItem(this.keyValue, "true")
    })
  }
}
