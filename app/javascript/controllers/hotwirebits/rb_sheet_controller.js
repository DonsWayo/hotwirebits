import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["sheet"]
  static values = { side: { type: String, default: "right" }, open: { type: Boolean, default: false } }

  connect() {
    this.handleKeydown = this.handleKeydown.bind(this)
    document.addEventListener("keydown", this.handleKeydown)
  }

  disconnect() {
    document.removeEventListener("keydown", this.handleKeydown)
  }

  open() {
    this.openValue = true
    this.sheetTarget.classList.remove("translate-x-full", "-translate-x-full")
    this.sheetTarget.classList.add("translate-x-0")
  }

  close() {
    this.openValue = false
    this.sheetTarget.classList.remove("translate-x-0")
    if (this.sideValue === "right") {
      this.sheetTarget.classList.add("translate-x-full")
    } else {
      this.sheetTarget.classList.add("-translate-x-full")
    }
  }

  toggle() {
    this.openValue ? this.close() : this.open()
  }

  handleKeydown(event) {
    if (event.key === "Escape" && this.openValue) this.close()
  }

  closeOnOverlay(event) {
    if (event.target === this.element) this.close()
  }
}
