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

