document.addEventListener("DOMContentLoaded", function() {
    const accountMenu = document.getElementById("account-menu");
    if (accountMenu) {
        accountMenu.addEventListener("click", function(event) {
            event.stopPropagation();
            const dropdownMenu = this.querySelector(".dropdown-menu");
            dropdownMenu.style.display = dropdownMenu.style.display === "block" ? "none" : "block";
        });
    }
});


// Đóng dropdown khi nhấp ra ngoài
document.addEventListener("click", function() {
    const dropdownMenu = document.querySelector("#account-menu .dropdown-menu");
    if (dropdownMenu) {
        dropdownMenu.style.display = "none";
    }
});
