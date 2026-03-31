import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  toggle() {
    const pressed = this.element.getAttribute("aria-pressed") === "true"
    this.element.setAttribute("aria-pressed", (!pressed).toString())
    this.dispatch("toggle", { detail: { pressed: !pressed } })
  }
}
