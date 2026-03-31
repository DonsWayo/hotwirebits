import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["messages", "input"]
  static values = { endpoint: { type: String, default: "" } }

  send() {
    if (!this.hasInputTarget) return
    const msg = this.inputTarget.value.trim()
    if (!msg) return
    this.inputTarget.value = ""
    this.dispatch("send", { detail: { message: msg } })
  }

  appendMessage(event) {
    if (this.hasMessagesTarget) {
      this.messagesTarget.insertAdjacentHTML("beforeend", event.detail.html)
      this.messagesTarget.scrollTop = this.messagesTarget.scrollHeight
    }
  }
}
