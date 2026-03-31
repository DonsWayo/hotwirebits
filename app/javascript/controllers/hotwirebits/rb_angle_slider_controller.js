import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["track", "input"]
  static values = { min: { type: Number, default: 0 }, max: { type: Number, default: 360 }, value: { type: Number, default: 0 } }

  input(event) {
    this.valueValue = parseFloat(event.target.value)
    this.dispatch("change", { detail: { value: this.valueValue } })
  }
}
