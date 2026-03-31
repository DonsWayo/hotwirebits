import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["zone"]

  connect() {
    if (this.hasZoneTarget) {
      this._onDragOver = (e) => e.preventDefault()
      this._onDrop = (e) => { e.preventDefault(); this.dispatch("drop", { detail: { files: e.dataTransfer?.files } }) }
      this.zoneTarget.addEventListener("dragover", this._onDragOver)
      this.zoneTarget.addEventListener("drop", this._onDrop)
    }
  }

  disconnect() {
    if (this.hasZoneTarget) {
      this.zoneTarget.removeEventListener("dragover", this._onDragOver)
      this.zoneTarget.removeEventListener("drop", this._onDrop)
    }
  }
}
