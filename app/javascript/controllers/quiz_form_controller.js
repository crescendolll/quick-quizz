import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="quiz-form"
export default class extends Controller {
  static targets = ["imageInput", "textInput"];

  toggleInputs(event) {
    const inputType = event.target.type;
    console.log("hello")

    if (inputType === 'file') {
      this.imageInputTarget.disabled = false;
      this.textInputTarget.disabled = true;
    } else {
      this.imageInputTarget.disabled = true;
      this.textInputTarget.disabled = false;
    }
  }
}
