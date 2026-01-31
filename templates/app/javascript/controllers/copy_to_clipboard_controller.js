import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["source", "buttonText"]
  static values = { text: String }

  async copy() {
    // Get text from either the value or the source target
    const text = this.hasTextValue ? this.textValue : this.sourceTarget.value

    try {
      await navigator.clipboard.writeText(text)

      // Show success feedback
      const originalText = this.hasButtonTextTarget ? this.buttonTextTarget.textContent : "Copy"
      if (this.hasButtonTextTarget) {
        this.buttonTextTarget.textContent = "Copied!"
      }

      // Reset after 2 seconds
      setTimeout(() => {
        if (this.hasButtonTextTarget) {
          this.buttonTextTarget.textContent = originalText
        }
      }, 2000)
    } catch (err) {
      console.error("Failed to copy:", err)
      if (this.hasButtonTextTarget) {
        this.buttonTextTarget.textContent = "Failed"
        setTimeout(() => {
          this.buttonTextTarget.textContent = "Copy"
        }, 2000)
      }
    }
  }
}
