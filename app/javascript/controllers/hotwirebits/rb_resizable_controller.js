import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["handle", "panel"]
  static values = {
    minSize: { type: Number, default: 100 },
    maxSize: { type: Number, default: 800 },
    direction: { type: String, default: "horizontal" }
  }

  connect() {
    this.isResizing = false
    this.startPos = 0
    this.startSize = 0
    this._onMove = this.onMove.bind(this)
    this._onEnd = this.onEnd.bind(this)

    this.handleTarget.addEventListener("mousedown", this.onStart.bind(this))
    this.handleTarget.addEventListener("touchstart", this.onStart.bind(this), { passive: false })
  }

  disconnect() {
    this.cleanupListeners()
  }

  onStart(event) {
    event.preventDefault()
    this.isResizing = true
    this.startPos = this.directionValue === "horizontal"
      ? (event.touches ? event.touches[0].clientX : event.clientX)
      : (event.touches ? event.touches[0].clientY : event.clientY)
    this.startSize = this.directionValue === "horizontal"
      ? this.panelTarget.offsetWidth
      : this.panelTarget.offsetHeight

    document.addEventListener("mousemove", this._onMove)
    document.addEventListener("mouseup", this._onEnd)
    document.addEventListener("touchmove", this._onMove, { passive: false })
    document.addEventListener("touchend", this._onEnd)
    document.body.style.cursor = this.directionValue === "horizontal" ? "col-resize" : "row-resize"
    document.body.style.userSelect = "none"
  }

  onMove(event) {
    if (!this.isResizing) return
    event.preventDefault()
    const pos = this.directionValue === "horizontal"
      ? (event.touches ? event.touches[0].clientX : event.clientX)
      : (event.touches ? event.touches[0].clientY : event.clientY)
    const delta = pos - this.startPos
    const newSize = Math.max(this.minSizeValue, Math.min(this.maxSizeValue, this.startSize + delta))

    if (this.directionValue === "horizontal") {
      this.panelTarget.style.width = `${newSize}px`
    } else {
      this.panelTarget.style.height = `${newSize}px`
    }

    this.dispatch("resize", { detail: { size: newSize } })
  }

  onEnd() {
    this.isResizing = false
    this.cleanupListeners()
    this.dispatch("resize-end", {
      detail: {
        size: this.directionValue === "horizontal"
          ? this.panelTarget.offsetWidth
          : this.panelTarget.offsetHeight
      }
    })
  }

  cleanupListeners() {
    document.removeEventListener("mousemove", this._onMove)
    document.removeEventListener("mouseup", this._onEnd)
    document.removeEventListener("touchmove", this._onMove)
    document.removeEventListener("touchend", this._onEnd)
    document.body.style.cursor = ""
    document.body.style.userSelect = ""
  }
}
