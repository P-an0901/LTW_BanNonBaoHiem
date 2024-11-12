// Hiển thị form thanh toán bằng thẻ khi chọn phương thức thanh toán tương ứng
document.getElementById('card-payment').addEventListener('click', function (e) {
    e.preventDefault();
    document.getElementById('card-payment-form').style.display = 'block';
});

// Ẩn form thanh toán bằng thẻ khi chọn phương thức khác
document.getElementById('cash-payment').addEventListener('click', function (e) {
    e.preventDefault();
    document.getElementById('card-payment-form').style.display = 'none';
});

document.getElementById('e-wallet-payment').addEventListener('click', function (e) {
    e.preventDefault();
    document.getElementById('card-payment-form').style.display = 'none';
}); document.addEventListener("DOMContentLoaded", function() {
    // Lấy giỏ hàng từ localStorage
    const cart = JSON.parse(localStorage.getItem("cart")) || [];

    // Kiểm tra nếu giỏ hàng trống
    if (cart.length === 0) {
        document.getElementById("order-items").innerHTML = "<p>Không có sản phẩm nào trong giỏ hàng.</p>";
        document.getElementById("order-total").textContent = "0 đ";
        return;
    }

    // Hiển thị thông tin sản phẩm
    const orderItemsContainer = document.getElementById("order-items");
    let totalAmount = 0;

    cart.forEach(product => {
        const productElement = document.createElement("li");
        productElement.classList.add("order-item");

        productElement.innerHTML = `
            <img src="${product.image}" alt="${product.name}" class="order-item-img">
            <span class="order-item-name">${product.name}</span>
            <span class="order-item-price">${product.price}</span>
        `;
        orderItemsContainer.appendChild(productElement);

        // Cộng dồn tổng tiền
        totalAmount += parseInt(product.price.replace(/[^0-9]/g, ''));
    });

    // Hiển thị tổng tiền
    document.getElementById("order-total").textContent = totalAmount.toLocaleString() + " đ";
});


document.getElementById('place-order-btn').addEventListener('click', function () {
    // xóa khi đặt xong
    localStorage.removeItem('cart');
    alert('Đơn hàng của bạn đã được đặt thành công!');
});

