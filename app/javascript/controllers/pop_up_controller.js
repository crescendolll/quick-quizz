import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="pop-up"
export default class extends Controller {
  static targets = ["question", "popUpAnswer", "popUpClose"];

  connect() {
    this.show();
    this.close();
  };

  show() {
    this.questionTargets.forEach((question, i) => {
      question.addEventListener('click', () => {
        // console.log("hi", i);
        this.popUpAnswerTargets[i].classList.remove('invisible');
      });
    });
  };

  close() {
    this.popUpCloseTargets.forEach((close) => {
      close.addEventListener('click', () => {
        this.popUpAnswerTargets.forEach((answer) => {
          answer.classList.add('invisible');
        });
      });
    });
  };
}
