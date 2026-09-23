const yearEl = document.querySelector(".footer-year");
if (yearEl) yearEl.textContent = new Date().getFullYear();

const form = document.getElementById("contact-form");
const status = document.getElementById("form-status");

form?.addEventListener("submit", async (event) => {
  event.preventDefault();
  const button = form.querySelector("button[type=submit]");

  button.disabled = true;
  status.classList.remove("error");
  status.textContent = "Sending…";

  try {
    const response = await fetch("https://api.web3forms.com/submit", {
      method: "POST",
      headers: { Accept: "application/json" },
      body: new FormData(form),
    });
    const result = await response.json();
    if (!response.ok) throw new Error(result.message ?? "Something went wrong.");

    form.reset();
    status.textContent = "Thanks — I'll come back to you within a day.";
  } catch (error) {
    status.classList.add("error");
    status.textContent = `${error.message} You can also ring or text me instead.`;
    button.disabled = false;
  }
});
