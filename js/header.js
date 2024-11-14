document.getElementById("account-menu").addEventListener("click", function(event) {
    event.stopPropagation(); // Ngăn chặn việc sự kiện click lan ra ngoài
    const dropdownMenu = this.querySelector(".dropdown-menu");
    dropdownMenu.style.display = dropdownMenu.style.display === "block" ? "none" : "block";
});

// Đóng dropdown khi nhấp ra ngoài
document.addEventListener("click", function() {
    const dropdownMenu = document.querySelector("#account-menu .dropdown-menu");
    if (dropdownMenu) {
        dropdownMenu.style.display = "none";
    }
});