import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["user", "chimney", "list"];

  connect() {
    this.highlightCurrentPage();
    // this.lastScrollTop = 0;
    // window.addEventListener("scroll", this.handleScroll.bind(this));
  }

  // disconnect() {
  //   window.removeEventListener("scroll", this.handleScroll.bind(this));
  // }

  highlightCurrentPage() {
    const currentPath = window.location.pathname;

    if (currentPath.includes("quizzes")) {
      this.listTarget.style.color = "black";
      this.chimneyTarget.style.color = "lightgray";
      this.userTarget.style.color = "lightgray";
    } else if (currentPath === "/") {
      this.listTarget.style.color = "lightgray";
      this.chimneyTarget.style.color = "black";
      this.userTarget.style.color = "lightgray";
    } else if (currentPath.includes("profile")) {
      this.listTarget.style.color = "lightgray";
      this.chimneyTarget.style.color = "lightgray";
      this.userTarget.style.color = "black";
    }
  }

  // handleScroll() {
  //   const scrollTop = window.scrollY || document.documentElement.scrollTop;
  //   const navbar = this.navbarTarget;

  //   if (scrollTop > this.lastScrollTop) {
  //     navbar.classList.remove("navbar-up");
  //     navbar.classList.add("navbar-down");
  //   } else {
  //     navbar.classList.add("navbar-up");
  //     navbar.classList.remove("navbar-down");
  //   }

  //   this.lastScrollTop = scrollTop <= 0 ? 0 : scrollTop;
  // }
  // if we need navbar to be moved down and up just add new classes to css
}
