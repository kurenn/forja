import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["panel", "backdrop", "dialog"]
  static values = { open: Boolean, id: String }

  connect() {
    this.handleEscape = this.handleEscape.bind(this)
    this.handleCustomOpen = this.handleCustomOpen.bind(this)
    this.handleCustomClose = this.handleCustomClose.bind(this)
    
    // Listen for custom events
    document.addEventListener(`modal:open:${this.idValue}`, this.handleCustomOpen)
    document.addEventListener(`modal:close:${this.idValue}`, this.handleCustomClose)
  }

  handleCustomOpen(event) {
    this.open(event)
  }

  handleCustomClose(event) {
    this.close(event)
  }

  open(event) {
    event?.preventDefault()
    this.openValue = true
    
    // Show the container (the controller element itself)
    this.element.classList.remove("hidden")
    this.element.classList.add("block")
    
    // Open the dialog element
    if (this.hasDialogTarget && !this.dialogTarget.open) {
      this.dialogTarget.showModal()
    }
    
    document.body.classList.add("overflow-hidden")
    document.addEventListener("keydown", this.handleEscape)
  }

  close(event) {
    event?.preventDefault()
    this.openValue = false
    
    // Close the dialog element
    if (this.hasDialogTarget && this.dialogTarget.open) {
      this.dialogTarget.close()
    }
    
    // Hide the container (the controller element itself)
    this.element.classList.add("hidden")
    this.element.classList.remove("block")
    
    document.body.classList.remove("overflow-hidden")
    document.removeEventListener("keydown", this.handleEscape)

    // Reset the form and result frame when closing
    const form = this.element.querySelector("form")
    const resultFrame = this.element.querySelector("#api_token_result")

    if (form) form.reset()
    if (resultFrame) resultFrame.innerHTML = ""
  }

  handleEscape(event) {
    if (event.key === "Escape") {
      this.close()
    }
  }

  disconnect() {
    document.removeEventListener("keydown", this.handleEscape)
    document.removeEventListener(`modal:open:${this.idValue}`, this.handleCustomOpen)
    document.removeEventListener(`modal:close:${this.idValue}`, this.handleCustomClose)
    document.body.classList.remove("overflow-hidden")
  }
}
