import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["source", "feedback"]
  static values = { text: { type: String, default: "" } }

  async copy() {
    const text = this.textValue || (this.hasSourceTarget ? this.sourceTarget.textContent : "")

    try {
      await navigator.clipboard.writeText(text)
      this.showFeedback("Copied!")
      this.dispatch("copy", { detail: { text } })
    } catch {
      this.fallbackCopy(text)
    }
  }

  fallbackCopy(text) {
    const textarea = document.createElement("textarea")
    textarea.value = text
    textarea.style.cssText = "position:fixed;left:-9999px"
    document.body.appendChild(textarea)
    textarea.select()
    try {
      document.execCommand("copy")
      this.showFeedback("Copied!")
    } catch {
      this.showFeedback("Failed to copy")
    }
    textarea.remove()
  }

  showFeedback(message) {
    if (!this.hasFeedbackTarget) return
    this.feedbackTarget.textContent = message
    this.feedbackTarget.classList.remove("hidden")
    setTimeout(() => {
      this.feedbackTarget.classList.add("hidden")
    }, 2000)
  }
}
