import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="question"
export default class extends Controller {
  static targets = ["question"];

  connect() {
    this.questionTargets.forEach((question) => {
      console.log("Hey!", question)
    });

    const first_question = this.questionTargets[0];
    first_question.classList.remove('invisible');

    this.questionTargets.forEach((question, i) => {
      question.addEventListener('click', () => {
        question.classList.add('invisible');
        question.nextElementSibling.classList.remove('invisible');
        console.log(question);
      });
    });
  }

}
