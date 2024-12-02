// Hiển thị form thanh toán bằng thẻ khi chọn phương thức thanh toán tương ứng
document.getElementById('card-payment').addEventListener('click', function (e) {
    e.preventDefault();
    document.getElementById('card-payment-form').style.display = 'block';
    setSelectedButton(this);
});
// Hiển thị form thanh toán ví điện tử khi chọn phương thức thanh toán ví điện tử
document.getElementById('e-wallet-payment').addEventListener('click', function (e) {
    e.preventDefault();
    document.getElementById('e-wallet-payment-form').style.display = 'block';
    document.getElementById('card-payment-form').style.display = 'none';
    setSelectedButton(this);
});

// Ẩn form thanh toán bằng thẻ khi chọn phương thức khác
document.getElementById('cash-payment').addEventListener('click', function (e) {
    e.preventDefault();
    document.getElementById('card-payment-form').style.display = 'none';
    setSelectedButton(this);
});
// Ẩn form thanh toán khi chọn phương thức thanh toán khác
document.getElementById('card-payment').addEventListener('click', function (e) {
    e.preventDefault();
    document.getElementById('e-wallet-payment-form').style.display = 'none';
});
// Hiển thị ảnh QR khi chọn ví điện tử
document.getElementById('momo-payment').addEventListener('click', function () {
    document.getElementById('momo-image').style.display = 'block';
    document.getElementById('zalopay-image').style.display = 'none';
    document.getElementById('viettel-money-image').style.display = 'none';
    document.getElementById('vnpay-image').style.display = 'none';
});
document.getElementById('zalopay-payment').addEventListener('click', function () {
    document.getElementById('momo-image').style.display = 'none';
    document.getElementById('viettel-money-qr').style.display = 'none';
    document.getElementById('vnpay-qr').style.display = 'none';
});
 document.addEventListener("DOMContentLoaded", function() {
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
    document.getElementById('place-order-btn').addEventListener('click', function () {
        // Lấy các giá trị từ form
        const fullName = document.getElementById('full-name').value.trim();
        const email = document.getElementById('email').value.trim();
        const address = document.getElementById('address').value.trim();
        const phone = document.getElementById('phone').value.trim();
        const cardPaymentForm = document.getElementById('card-payment-form');
        const cardName = document.getElementById('card-name').value.trim();
        const cardNumber = document.getElementById('card-number').value.trim();
        const expiryDate = document.getElementById('expiry-date').value.trim();
        const cvv = document.getElementById('cvv').value.trim();

        // Kiểm tra thông tin khách hàng
        if (!fullName || !email || !address || !phone) {
            alert("Vui lòng nhập đầy đủ thông tin khách hàng.");
            return;
        }

        // Kiểm tra số điện thoại
        const phoneRegex = /^[0-9]{10,11}$/;
        if (!phoneRegex.test(phone)) {
            alert("Số điện thoại không hợp lệ. Vui lòng nhập 10-11 chữ số.");
            return;
        }

        // Kiểm tra email
        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        if (!emailRegex.test(email)) {
            alert("Email không hợp lệ. Vui lòng nhập đúng định dạng.");
            return;
        }

        // Nếu chọn thanh toán bằng thẻ, kiểm tra các thông tin thẻ
        if (cardPaymentForm.style.display === 'block') {
            if (!cardName || !cardNumber || !expiryDate || !cvv) {
                alert("Vui lòng nhập đầy đủ thông tin thẻ.");
                return;
            }

            // Kiểm tra số thẻ
            const cardNumberRegex = /^[0-9]{16}$/;
            if (!cardNumberRegex.test(cardNumber)) {
                alert("Số thẻ không hợp lệ. Vui lòng nhập 16 chữ số.");
                return;
            }

            // Kiểm tra ngày hết hạn
            const expiryDateRegex = /^(0[1-9]|1[0-2])\/\d{2}$/;
            if (!expiryDateRegex.test(expiryDate)) {
                alert("Ngày hết hạn không hợp lệ. Vui lòng nhập đúng định dạng MM/YY.");
                return;
            }

            // Kiểm tra CVV
            const cvvRegex = /^[0-9]{3,4}$/;
            if (!cvvRegex.test(cvv)) {
                alert("CVV không hợp lệ. Vui lòng nhập 3-4 chữ số.");
                return;
            }
        }





        // Nếu tất cả thông tin hợp lệ, tiếp tục xử lý đặt hàng

        alert('Đơn hàng của bạn đã được đặt thành công!');
        window.location.href = "index.html"; // Chuyển hướng về trang chủ
    });

});

// Hàm giúp thêm lớp selected cho nút được chọn
function setSelectedButton(button) {
    // Loại bỏ lớp selected từ tất cả các nút
    let buttons = document.querySelectorAll('.btn2');
    buttons.forEach(function(btn) {
        btn.classList.remove('selected');
    });

    // Thêm lớp selected cho nút được chọn
    button.classList.add('selected');
}
