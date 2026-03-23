import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["drawer"]
  static values = {
    snapPoints: { type: Array, default: [100] },
    open: { type: Boolean, default: false },
    currentSnap: { type: Number, default: 0 }
  }

  connect() {
    this.startY = 0
    this.currentY = 0
    this.handleKeydown = this.handleKeydown.bind(this)
    document.addEventListener("keydown", this.handleKeydown)
  }

  disconnect() {
    document.removeEventListener("keydown", this.handleKeydown)
  }

  open() {
    this.openValue = true
    this.snapTo(0)
  }

  close() {
    this.openValue = false
    this.currentSnapValue = this.snapPointsValue.length - 1
    this.drawerTarget.style.transform = `translateY(100%)`
  }

  toggle() {
    this.openValue ? this.close() : this.open()
  }

  snapTo(index) {
    this.currentSnapValue = index
    const point = this.snapPointsValue[index]
    this.drawerTarget.style.transform = `translateY(${100 - point}%)`
  }

  startDrag(event) {
    this.startY = event.touches ? event.touches[0].clientY : event.clientY
  }

  onDrag(event) {
    if (!this.openValue) return
    const y = event.touches ? event.touches[0].clientY : event.clientY
    this.currentY = y - this.startY
    if (this.currentY > 0) {
      this.drawerTarget.style.transform = `translateY(${this.currentY}px)`
    }
  }

  endDrag() {
    const threshold = 50
    if (this.currentY > threshold) {
      this.close()
    } else {
      this.snapTo(this.currentSnapValue)
    }
    this.currentY = 0
  }

  handleKeydown(event) {
    if (event.key === "Escape" && this.openValue) this.close()
  }
}
