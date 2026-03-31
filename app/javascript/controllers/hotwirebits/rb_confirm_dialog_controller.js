import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["dialog"]
  static values = { open: { type: Boolean, default: false } }

  open() { this.openValue = true; if (this.hasDialogTarget) this.dialogTarget.classList.remove("hidden") }
  close() { this.openValue = false; if (this.hasDialogTarget) this.dialogTarget.classList.add("hidden") }
  confirm() { this.dispatch("confirm"); this.close() }
  cancel() { this.dispatch("cancel"); this.close() }
}
