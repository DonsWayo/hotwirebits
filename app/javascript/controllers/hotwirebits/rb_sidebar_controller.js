import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["sidebar", "overlay", "main"]
  static values = { open: { type: Boolean, default: false }, breakpoint: { type: Number, default: 768 } }

  connect() {
    this._beforeCache = () => { if (this.hasOverlayTarget) this.overlayTarget.classList.add("hidden") }
    document.addEventListener("turbo:before-cache", this._beforeCache)
    this.handleResize = this.handleResize.bind(this)
    this.handleKeydown = this.handleKeydown.bind(this)
    window.addEventListener("resize", this.handleResize)
    document.addEventListener("keydown", this.handleKeydown)
    this.handleResize()
  }

  disconnect() {
    document.removeEventListener("turbo:before-cache", this._beforeCache)
    this._beforeCache = () => { if (this.hasOverlayTarget) this.overlayTarget.classList.add("hidden") }
    document.addEventListener("turbo:before-cache", this._beforeCache)
    window.removeEventListener("resize", this.handleResize)
    document.removeEventListener("keydown", this.handleKeydown)
  }

  toggle() {
    this.openValue = !this.openValue
    this.update()
  }

  open() {
    this.openValue = true
    this.update()
  }

  close() {
    this.openValue = false
    this.update()
  }

  update() {
    this.sidebarTarget.classList.toggle("sidebar-open", this.openValue)
    this.sidebarTarget.classList.toggle("sidebar-closed", !this.openValue)
    if (this.hasOverlayTarget) {
      this.overlayTarget.classList.toggle("hidden", !this.openValue || this.isDesktop)
    }
    if (this.hasMainTarget) {
      this.mainTarget.classList.toggle("sidebar-expanded", this.openValue && this.isDesktop)
    }
  }

  handleResize() {
    this.update()
  }

  get isDesktop() {
    return window.innerWidth >= this.breakpointValue
  }

  handleKeydown(event) {
    if (event.key === "Escape" && this.openValue && !this.isDesktop) {
      this.close()
    }
  }

  closeOnOverlay(event) {
    if (!this.isDesktop) this.close()
  }
}
