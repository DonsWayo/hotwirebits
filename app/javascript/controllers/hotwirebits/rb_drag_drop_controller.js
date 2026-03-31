import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["zone"]

  connect() {
    if (this.hasZoneTarget) {
      this.zoneTarget.addEventListener("dragover", (e) => e.preventDefault())
      this.zoneTarget.addEventListener("drop", (e) => { e.preventDefault(); this.dispatch("drop", { detail: { files: e.dataTransfer?.files } }) })
    }
  }
}
