import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="question"
export default class extends Controller {
  static targets = ["question", "submit"];

  connect() {
    this.questionTargets.forEach((question) => {
      // console.log("Hey!", question)
    });

    const first_question = this.questionTargets[0];
    first_question.classList.remove('invisible');
    const last_question = this.questionTargets[this.questionTargets.length - 1];

    this.questionTargets.forEach((question, i) => {
      question.addEventListener('click', () => {
        if (question !== last_question) {
          question.classList.add('invisible');
        };
        question.nextElementSibling.classList.remove('invisible');
        // console.log(question);
      });
    });
  }
}
