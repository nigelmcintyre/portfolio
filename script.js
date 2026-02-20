const yearEl = document.querySelector(".footer-year");
if (yearEl) {
  yearEl.textContent = String(new Date().getFullYear());
}
