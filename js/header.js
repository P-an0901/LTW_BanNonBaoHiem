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
document.addEventListener("DOMContentLoaded", () => {
    // Kiểm tra xem có người dùng nào đang đăng nhập không
    const loggedInUser = JSON.parse(localStorage.getItem("loggedInUser"));

    if (loggedInUser) {
        // Hiển thị menu tài khoản nếu có người dùng đăng nhập
        document.getElementById("account-menu").style.display = "block";
        document.getElementById("login-menu").style.display = "none";
        document.getElementById("signup-menu").style.display = "none";
        document.getElementById("account-name").textContent = loggedInUser.fullName || "Tài khoản";

        // Xử lý sự kiện đăng xuất
        document.getElementById("logout-button").addEventListener("click", (e) => {
            e.preventDefault();

            // Xóa thông tin người dùng khỏi localStorage


            // Hiển thị lại nút Đăng nhập và Đăng ký, ẩn menu tài khoản
            document.getElementById("account-menu").style.display = "none";
            document.getElementById("login-menu").style.display = "block";
            document.getElementById("signup-menu").style.display = "block";

            // Chuyển hướng người dùng về trang đăng nhập hoặc trang chủ
            alert("Bạn đã đăng xuất thành công!");
            window.location.href = "index.html"; // Chuyển hướng về trang đăng nhập
        });
    } else {
        // Nếu không có người dùng đăng nhập, ẩn menu tài khoản
        document.getElementById("account-menu").style.display = "none";
    }
});
