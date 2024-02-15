// import { Controller } from "@hotwired/stimulus";

// export default class extends Controller {
//   static targets = ["icon"];

//   connect() {
//     this.highlightCurrentPage();
//   }

//   highlightCurrentPage() {
//     const activeIcon = this.iconTargets.find((icon) =>
//       icon.parentElement.classList.contains("active")
//     );

//     if (activeIcon) {
//       this.iconTargets.forEach((icon) => {
//         icon.style.color = "lightgray";
//       });

//       activeIcon.style.color = "black";
//     }
//   }
// }
