import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["list"]

  load() { this.dispatch("load") }

  append(event) {
    if (this.hasListTarget) this.listTarget.insertAdjacentHTML("afterbegin", event.detail.html)
  }
}
