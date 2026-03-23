import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input"]

  connect() {
    if (this.inputTargets.length) this.inputTargets[0].focus()
  }

  onInput(event) {
    const input = event.target
    const index = this.inputTargets.indexOf(input)
    if (input.value.length === 1 && index < this.inputTargets.length - 1) {
      this.inputTargets[index + 1].focus()
    }
    this.dispatch("input", { detail: { value: this.value } })
  }

  onKeydown(event) {
    const input = event.target
    const index = this.inputTargets.indexOf(input)
    if (event.key === "Backspace" && !input.value && index > 0) {
      event.preventDefault()
      this.inputTargets[index - 1].focus()
      this.inputTargets[index - 1].value = ""
    }
    if (event.key === "ArrowLeft" && index > 0) {
      event.preventDefault()
      this.inputTargets[index - 1].focus()
    }
    if (event.key === "ArrowRight" && index < this.inputTargets.length - 1) {
      event.preventDefault()
      this.inputTargets[index + 1].focus()
    }
  }

  onPaste(event) {
    event.preventDefault()
    const text = (event.clipboardData || window.clipboardData).getData("text")
    const chars = text.replace(/\D/g, "").slice(0, this.inputTargets.length).split("")
    chars.forEach((char, i) => {
      this.inputTargets[i].value = char
    })
    const lastIndex = Math.min(chars.length - 1, this.inputTargets.length - 1)
    this.inputTargets[lastIndex].focus()
    if (chars.length === this.inputTargets.length) {
      this.dispatch("complete", { detail: { value: this.value } })
    }
  }

  get value() {
    return this.inputTargets.map((i) => i.value).join("")
  }
}
