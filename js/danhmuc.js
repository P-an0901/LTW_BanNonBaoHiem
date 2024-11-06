/* Phân trang */
function scrollToProductList() {
    // Cuộn lên đầu container sản phẩm
    document.querySelector('.product-list').scrollIntoView({
        behavior: 'smooth',
        block: 'start'
    });
}
function setActivePage(event) {
    event.preventDefault();

    var links = document.querySelectorAll('.pagination a');
    links.forEach(function(link) {
        link.classList.remove('active');
    });

    event.target.classList.add('active');
    
    // Cuộn lên đầu danh sách sản phẩm
    scrollToProductList();
}

function changePage(direction) {
    // Tìm trang hiện tại
    const currentPage = document.querySelector('.pagination a.active');
    let newPage = currentPage;

    if (direction === -1 && currentPage.previousElementSibling) {
        // Di chuyển đến trang trước
        newPage = currentPage.previousElementSibling;
    } else if (direction === 1 && currentPage.nextElementSibling) {
        // Di chuyển đến trang sau
        newPage = currentPage.nextElementSibling;
    }

    // Nếu trang mới hợp lệ, thay đổi active page
    if (newPage && newPage.tagName === 'A' && newPage !== currentPage) {
        currentPage.classList.remove('active');
        newPage.classList.add('active');
        
        // Cuộn lên đầu danh sách sản phẩm
        scrollToProductList();
    }
}
// Cập nhật giá khi thay đổi giá trị của thanh range
document.getElementById("price-range").addEventListener("input", function() {
    var price = this.value;
    document.getElementById("price-value").textContent = "Giá: " + price + "đ";
});

// Cập nhật lượt mua khi thay đổi giá trị của thanh range
document.getElementById("purchase-range").addEventListener("input", function() {
    var purchase = this.value;
    document.getElementById("purchase-value").textContent = "Lượt mua: " + purchase;
});

// Hàm áp dụng lọc
function applyFilters() {
    var helmetType = document.getElementById("helmet-type").value;
    var helmetSize = document.getElementById("helmet-size").value;
    var priceRange = document.getElementById("price-range").value;
    var purchaseRange = document.getElementById("purchase-range").value;
    var selectedColors = [];

    // Lấy tất cả màu đã chọn
    document.querySelectorAll(".filter-color:checked").forEach(function(color) {
        selectedColors.push(color.value);
    });

    // In ra kết quả lọc (thực tế bạn có thể gửi dữ liệu này đến server hoặc hiển thị lại sản phẩm)
    console.log("Loại nón: " + helmetType);
    console.log("Kích thước: " + helmetSize);
    console.log("Giá: " + priceRange + "đ");
    console.log("Lượt mua: " + purchaseRange);
    console.log("Màu sắc: " + selectedColors.join(", "));
}
