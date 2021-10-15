const submit_btn = document.querySelector('[type="submit"]');
document.querySelector("textarea").addEventListener("input", function () {
    if (this.value.trim().length) {
        submit_btn.removeAttribute("disabled")
    } else {
        submit_btn.disabled = true
    }
})

document.querySelector("#img-upload").onclick = function () {
    document.querySelector(".file-input").click()
}
