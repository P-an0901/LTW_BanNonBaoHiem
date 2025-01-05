document.getElementById('place-order-btn').addEventListener('click', function() {
    var isLoggedIn = document.getElementById('isLoggedIn').value;
    var isHaveCart = document.getElementById('isHaveCart').value;

    if (isLoggedIn === "true" && isHaveCart === "true") {
    var fullName = document.getElementById('full-name').value;
    var address = document.getElementById('address').value;
    var phone = document.getElementById('phone').value;
    var note = document.getElementById('note').value;

    var isValid = true;

    // Kiểm tra trường "Họ và tên"
    if (fullName === "") {
        document.getElementById('full-name-error').style.display = "block";
        isValid = false;
    } else {
        document.getElementById('full-name-error').style.display = "none";
    }

    // Kiểm tra trường "Địa chỉ"
    if (address === "") {
        document.getElementById('address-error').style.display = "block";
        isValid = false;
    } else {
        document.getElementById('address-error').style.display = "none";
    }

    // Kiểm tra trường "Số điện thoại"
    if (phone === "") {
        document.getElementById('phone-error').style.display = "block";
        isValid = false;
    } else {
        document.getElementById('phone-error').style.display = "none";
    }

    // Kiểm tra phương thức thanh toán
    var paymentMethod = document.querySelector('input[name="payment-method"]:checked');
    if (!paymentMethod) {
        document.getElementById('payment-error').style.display = "block";
        isValid = false;
    } else {
        document.getElementById('payment-error').style.display = "none";
        var paymentMethodName = paymentMethod.nextElementSibling.textContent;
        document.getElementById('modal-payment-method').textContent = paymentMethodName;
    }

    // Nếu tất cả hợp lệ, hiển thị modal
    if (isValid) {
        document.getElementById('hidden-recipient-name').value = fullName;
        document.getElementById('hidden-address').value = address;
        document.getElementById('hidden-phone').value = phone;
        document.getElementById('hidden-note').value = note;
        document.getElementById('hidden-payment-method').value = paymentMethod.value;

        document.getElementById('modal-full-name').textContent = fullName;
        document.getElementById('modal-address').textContent = address;
        document.getElementById('modal-phone').textContent = phone;
        document.getElementById('modal-note').textContent = note;

        $('#orderModal').modal('show');
    }
    } else {
        if (isLoggedIn !== "true") {
            alert("Bạn cần đăng nhập để đặt hàng!");
            openModal('login');
        } else if (isHaveCart !== "true") {
            alert("Giỏ hàng của bạn hiện tại đang trống!");
        }
    }
});
