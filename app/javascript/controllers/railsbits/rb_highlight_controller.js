import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["content"]
  static values = { term: { type: String, default: "" }, caseSensitive: { type: Boolean, default: false } }

  connect() {
    this.originalContent = this.contentTarget.innerHTML
  }

  termValueChanged() {
    this.apply()
  }

  apply() {
    const term = this.termValue
    if (!term) {
      this.contentTarget.innerHTML = this.originalContent
      return
    }
    this.contentTarget.innerHTML = this.originalContent
    const walker = document.createTreeWalker(this.contentTarget, NodeFilter.SHOW_TEXT, null, false)
    const textNodes = []
    while (walker.nextNode()) textNodes.push(walker.currentNode)

    textNodes.forEach((node) => {
      const flags = this.caseSensitiveValue ? "g" : "gi"
      const escaped = term.replace(/[.*+?^${}()|[\]\\]/g, "\\$&")
      const regex = new RegExp(`(${escaped})`, flags)
      if (regex.test(node.textContent)) {
        const span = document.createElement("span")
        span.innerHTML = node.textContent.replace(regex, '<mark class="highlight">$1</mark>')
        node.parentNode.replaceChild(span, node)
      }
    })
  }

  highlight(event) {
    this.termValue = event.params.term || event.currentTarget.value || ""
    this.apply()
  }

  clear() {
    this.termValue = ""
    this.contentTarget.innerHTML = this.originalContent
  }
}
