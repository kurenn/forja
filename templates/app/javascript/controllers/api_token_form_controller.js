import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  handleSubmit(event) {
    if (event.detail.success) {
      // Form submitted successfully, token created
      // Keep modal open so user can copy the token
      console.log("Token created successfully")
    }
  }
}
