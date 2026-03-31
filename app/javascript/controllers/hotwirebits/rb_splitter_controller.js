import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["handle", "panel"]
  static values = { minSize: { type: Number, default: 100 }, maxSize: { type: Number, default: 800 } }

  startResize(event) {
    event.preventDefault()
    this._startPos = event.clientX
    this._startSize = this.panelTarget.offsetWidth
    this._onMove = (e) => {
      const size = Math.max(this.minSizeValue, Math.min(this.maxSizeValue, this._startSize + (e.clientX - this._startPos)))
      this.panelTarget.style.width = `${size}px`
    }
    this._onEnd = () => {
      document.removeEventListener("pointermove", this._onMove)
      document.removeEventListener("pointerup", this._onEnd)
      document.body.style.cursor = ""
      document.body.style.userSelect = ""
    }
    document.addEventListener("pointermove", this._onMove)
    document.addEventListener("pointerup", this._onEnd)
    document.body.style.cursor = "col-resize"
    document.body.style.userSelect = "none"
  }
}
