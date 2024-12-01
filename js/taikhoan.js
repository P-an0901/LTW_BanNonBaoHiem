document.addEventListener("DOMContentLoaded", () => {
    // Lấy thông tin người dùng đăng nhập
    const loggedInUser = JSON.parse(localStorage.getItem('loggedInUser'));

    if (loggedInUser) {
        // Hiển thị thông tin cá nhân
        document.getElementById("account-fullname").textContent = loggedInUser.fullName;
        document.getElementById("account-email").textContent = loggedInUser.email || "Không rõ";
        document.getElementById("account-phone").textContent = loggedInUser.email || "Không rõ";
        document.getElementById("account-address").textContent = loggedInUser.email || "Không rõ";

        // Hiển thị lịch sử đơn hàng
        const orderHistory = document.getElementById("order-history");
        const cartItems = JSON.parse(localStorage.getItem("cartItems")) || [];

        if (cartItems.length > 0) {
            orderHistory.innerHTML = ""; // Xóa thông báo mặc định
            cartItems.forEach((item, index) => {
                const listItem = document.createElement("li");
                listItem.className = "list-group-item";
                listItem.textContent = `${index + 1}. ${item.name} - ${item.price} đ - Số lượng: ${item.quantity}`;
                orderHistory.appendChild(listItem);
            });
        }
    } else {
        // alert("Vui lòng đăng nhập để xem thông tin tài khoản!");
        // window.location.href = "index.html"; // Chuyển hướng về trang đăng nhập nếu chưa đăng nhập
    }
});

const extraOrders = document.querySelectorAll('.extra-order');
    const loadMoreBtn = document.getElementById('load-more');
    const hideBtn = document.getElementById('hide-extra');
    
    for (let i = 3; i < extraOrders.length; i++) {
        extraOrders[i].style.display = 'none';
    }

    loadMoreBtn.addEventListener('click', function() {
        extraOrders.forEach(order => {
            order.style.display = 'table-row'; 
        });
        loadMoreBtn.style.display = 'none';  
        hideBtn.style.display = 'inline-block'; 
    });

    hideBtn.addEventListener('click', function() {
        for (let i = 3; i < extraOrders.length; i++) {
            extraOrders[i].style.display = 'none'; 
        }
        loadMoreBtn.style.display = 'inline-block'; 
        hideBtn.style.display = 'none'; 
    });
    function toggleDetails(button) {
        const row = button.closest('tr'); 
        const detailsRow = row.nextElementSibling;  
        if (detailsRow.style.display === 'none') {
            detailsRow.style.display = 'table-row';  
        } else {
            detailsRow.style.display = 'none';  
        }
    }