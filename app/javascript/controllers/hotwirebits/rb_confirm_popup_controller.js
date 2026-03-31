import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["popup"]
  static values = { open: { type: Boolean, default: false } }

  open() { this.openValue = true; if (this.hasPopupTarget) this.popupTarget.classList.remove("hidden") }
  close() { this.openValue = false; if (this.hasPopupTarget) this.popupTarget.classList.add("hidden") }
  confirm() { this.dispatch("confirm"); this.close() }
}
