import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="scroll"
export default class extends Controller {
  static targets = ["newQuizButton"];

  connect() {
    this.lastScrollTop = 0;
    window.addEventListener("scroll", this.handleScroll.bind(this));
  }

  disconnect() {
    window.removeEventListener("scroll", this.handleScroll.bind(this));
  }

  handleScroll() {
    const scrollTop = window.scrollY || document.documentElement.scrollTop;

    if (scrollTop > this.lastScrollTop) {
      this.newQuizButtonTarget.classList.remove("moved-static");
      this.newQuizButtonTarget.classList.add("moved-right");
    } else {
      this.newQuizButtonTarget.classList.add("moved-static");
      this.newQuizButtonTarget.classList.remove("moved-right");
    }

    this.lastScrollTop = scrollTop <= 0 ? 0 : scrollTop;
    console.log("you scrolling troll");
  }
}
