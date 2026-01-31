import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="checkbox"
export default class extends Controller {
  static targets = ["input"]
  static values = {
    indeterminate: Boolean
  }

  connect() {
    if (this.indeterminateValue && this.hasInputTarget) {
      this.inputTarget.indeterminate = true
    }
  }

  toggle() {
    // Clear indeterminate state when user interacts
    if (this.hasInputTarget && this.inputTarget.indeterminate) {
      this.inputTarget.indeterminate = false
    }
  }

  setIndeterminate() {
    if (this.hasInputTarget) {
      this.inputTarget.indeterminate = true
    }
  }
}
