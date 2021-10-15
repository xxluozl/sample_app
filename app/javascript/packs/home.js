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

document.querySelector("#micropost_image").addEventListener("change", function () {
    const img_size = this.files[0].size / 1024 / 1024
    if (img_size > 5) {
        alert("请上传大小小于5M的图片")
        this.value = null
    }
    const file = this.files[0];
    if (window.FileReader) {
        const fr = new FileReader();
        const showImg = document.querySelector('.show-img');
        fr.onloadend = function (e) {
            showImg.src = e.target.result;
        };
        fr.readAsDataURL(file);
        showImg.style.display = 'block';
    }
})
