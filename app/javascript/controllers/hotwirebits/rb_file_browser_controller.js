import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["list", "input"]
  static values = { multiple: { type: Boolean, default: false } }

  browse() { if (this.hasInputTarget) this.inputTarget.click() }
  select(event) { this.dispatch("select", { detail: { files: event.target.files } }) }
}
