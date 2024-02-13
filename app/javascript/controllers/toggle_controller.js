import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="toggle"
export default class extends Controller {
  static targets = ["toggleLike", "toggleMessage"]

  connect() {

  }

  like() {
    this.toggleLikeTarget.classList.toggle("fa-regular");
    this.toggleLikeTarget.classList.toggle("fa-solid");
  }

  message() {
    // this.toggleMessageTarget.classList.toggle("d-none");
  }
}
