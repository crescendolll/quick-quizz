import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="loading"
export default class extends Controller {
  static targets = ["loadingPopup", "loading"]

  connect() {
  }

  show() {
    this.loadingPopupTarget.classList.add('d-none')
    this.loadingTarget.classList.remove('d-none')
  }

}
