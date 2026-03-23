import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["form", "buttons", "response", "comment"]
  static values = { url: { type: String, default: "" }, type: { type: String, default: "rating" } }

  selectResponse(event) {
    const value = event.currentTarget.dataset.value
    this.responseTargets.forEach((r) => r.classList.toggle("selected", r === event.currentTarget))
    this.dispatch("select", { detail: { value } })
  }

  async submit() {
    const data = {
      type: this.typeValue,
      response: this.element.querySelector(".selected")?.dataset.value,
      comment: this.hasCommentTarget ? this.commentTarget.value : null
    }

    if (this.urlValue) {
      try {
        const response = await fetch(this.urlValue, {
          method: "POST",
          headers: { "Content-Type": "application/json", "X-CSRF-Token": this.csrfToken },
          body: JSON.stringify(data)
        })
        if (response.ok) {
          this.dispatch("submitted", { detail: data })
          this.showThankYou()
        }
      } catch (e) {
        this.dispatch("error", { detail: { error: e } })
      }
    } else {
      this.dispatch("submitted", { detail: data })
      this.showThankYou()
    }
  }

  showThankYou() {
    if (this.hasFormTarget) {
      this.formTarget.innerHTML = '<div class="feedback-thanks">Thank you for your feedback!</div>'
    }
  }

  get csrfToken() {
    const meta = document.querySelector('meta[name="csrf-token"]')
    return meta ? meta.content : ""
  }
}
