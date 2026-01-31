import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="flash"
export default class extends Controller {
  static targets = ["notification"]
  static values = {
    autoDismiss: { type: Boolean, default: true },
    delay: { type: Number, default: 5000 }
  }

  connect() {
    if (this.autoDismissValue) {
      this.timeout = setTimeout(() => {
        this.dismiss()
      }, this.delayValue)
    }
  }

  disconnect() {
    if (this.timeout) {
      clearTimeout(this.timeout)
    }
  }

  dismiss() {
    // Add exit animation
    this.notificationTarget.classList.add("opacity-0", "translate-y-2", "sm:translate-x-2")
    
    // Remove element after animation completes
    setTimeout(() => {
      this.element.remove()
    }, 300)
  }
}
