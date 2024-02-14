import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="question"
export default class extends Controller {
  static targets = ["question", "submit", "questionCorrect", "questionFalse"]

  connect() {
    this.questionTargets.forEach((question) => {
      // console.log("Hey!", question)
    });

    const first_question = this.questionTargets[0];
    first_question.classList.remove('invisible');
    const last_question = this.questionTargets[this.questionTargets.length - 1];

    this.questionTargets.forEach((question, i) => {
      question.addEventListener('click', () => {
        const inputs = question.querySelectorAll("input")
        const checked_input = question.querySelector("input:checked")
        console.log("Hey!", checked_input)


        if(checked_input) {
          this.revealAnswer(checked_input)
        }

        setTimeout(() => {
          if (question !== last_question) {
            question.classList.add('invisible');
          };

          console.log("Delayed for 1 second.");
          question.nextElementSibling.classList.remove('invisible');

          this.questionCorrectTarget.classList.add("d-none");
          this.questionFalseTarget.classList.add("d-none");
        }, "1000");

        // console.log(question);
      });
    });
  }

  revealAnswer (checked_input) {
    const answer = checked_input.dataset.correct
    console.log("Hey!", answer)
    console.log("Hey!", typeof answer)
    if (answer == "true")
      {this.questionCorrectTarget.classList.remove("d-none") }
    else {this.questionFalseTarget.classList.remove("d-none")}
  }
}
