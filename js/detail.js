// Chọn tất cả các thumbnail và hình lớn
const thumbnails = document.querySelectorAll('.thumbnail');
const mainImage = document.getElementById('main-product-image');

// Lắng nghe sự kiện click trên từng thumbnail
thumbnails.forEach(thumbnail => {
    thumbnail.addEventListener('click', (e) => {
        // Lấy đường dẫn của hình thu nhỏ được bấm và thay đổi hình lớn
        const newSrc = e.target.getAttribute('data-src');
        mainImage.src = newSrc;
    });
});

// Mở modal khi bấm vào hình ảnh lớn
mainImage.addEventListener('click', () => {
    const modal = document.getElementById('imageModal');
    const modalImage = document.getElementById('modal-image');
    modal.style.display = "flex";  // Mở modal
    modalImage.src = mainImage.src;  // Đặt hình ảnh modal giống với hình lớn
});

// Đóng modal khi click ra ngoài ảnh
window.addEventListener('click', (e) => {
    const modal = document.getElementById('imageModal');
    if (e.target === modal) {
        modal.style.display = "none";  // Ẩn modal khi click ra ngoài ảnh
    }
});
function closeModal() {
    var modal = document.getElementById('imageModal');
    modal.style.display = 'none'; // Ẩn modal
}
function selectOnlyOne(checkbox) {
    var checkboxes = document.getElementsByName('size');
    checkboxes.forEach(function(box) {
        if (box !== checkbox) {
            box.checked = false; 
        }
    });
}
// Giảm số lượng
function decreaseQuantity() {
    var quantityInput = document.getElementById("quantity");
    var quantity = parseInt(quantityInput.value);

    if (quantity > 1) {
        quantityInput.value = quantity - 1;
    }
}

// Tăng số lượng
function increaseQuantity() {
    var quantityInput = document.getElementById("quantity");
    var quantity = parseInt(quantityInput.value);

    quantityInput.value = quantity + 1;
}
document.getElementById('toggleDescription').addEventListener('click', function() {
    var fullDescription = document.querySelector('.full-description');
    fullDescription.classList.toggle('show');  
    if (fullDescription.classList.contains('show')) {
        this.textContent = 'Ẩn';  // Đổi chữ thành 'Xem ít' khi mở rộng
    } else {
        this.textContent = 'Xem thêm';  // Đổi lại thành 'Xem thêm' khi thu gọn
    }
});
function addToCart2(button) {
    // Lấy thông tin về sản phẩm
    var productName = document.querySelector(".product-name h1").innerText;
    var productPrice = document.querySelector(".product-price").innerText.replace("Giá: ", "").replace(" đ", "").trim();
    var quantity = document.getElementById("quantity").value;
    var productSize = Array.from(document.querySelectorAll('.checkbox-size:checked')).map(cb => cb.value).join(", ");
    var productImage = document.querySelector("#main-product-image").src;

    // Thông báo khi không chọn size
    if (!productSize) {
        alert("Vui lòng chọn kích thước sản phẩm.");
        return;
    }

    // Kiểm tra thông tin sản phẩm
    console.log("Sản phẩm:", productName);
    console.log("Giá:", productPrice);
    console.log("Số lượng:", quantity);
    console.log("Kích thước:", productSize);
    console.log("Hình ảnh:", productImage);

    // Giả lập giỏ hàng (có thể lưu vào localStorage hoặc sessionStorage)
    let cart = JSON.parse(localStorage.getItem('cart')) || [];

    var existingProduct = cart.find(item => item.name === productName && item.size === productSize);
    if (existingProduct) {
        existingProduct.quantity += parseInt(quantity);  // Tăng số lượng nếu đã có sản phẩm trong giỏ
    } else {
        cart.push({
            name: productName,
            price: productPrice,
            quantity: parseInt(quantity),
            size: productSize,
            image: productImage
        });
    }
    updateCart();
    localStorage.setItem('cart', JSON.stringify(cart));
    alert("Sản phẩm đã được thêm vào giỏ hàng.");
}
