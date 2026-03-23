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

    this.handleTarget.addEventListener("mousedown", this.onStart.bind(this))
    this.handleTarget.addEventListener("touchstart", this.onStart.bind(this), { passive: true })
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

    const onMove = this.onMove.bind(this)
    const onEnd = () => {
      this.isResizing = false
      document.removeEventListener("mousemove", onMove)
      document.removeEventListener("mouseup", onEnd)
      document.removeEventListener("touchmove", onMove)
      document.removeEventListener("touchend", onEnd)
      document.body.style.cursor = ""
      document.body.style.userSelect = ""
      this.dispatch("resize-end", { detail: { size: this.directionValue === "horizontal" ? this.panelTarget.offsetWidth : this.panelTarget.offsetHeight } })
    }

    document.addEventListener("mousemove", onMove)
    document.addEventListener("mouseup", onEnd)
    document.addEventListener("touchmove", onMove, { passive: false })
    document.addEventListener("touchend", onEnd)
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
}
