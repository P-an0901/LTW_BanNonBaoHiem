
const thumbnails = document.querySelectorAll('.thumbnail');
const mainImage = document.getElementById('main-product-image');

thumbnails.forEach(thumbnail => {
    thumbnail.addEventListener('click', (e) => {
        const newSrc = e.target.getAttribute('data-src');
        mainImage.src = newSrc;
    });
});

mainImage.addEventListener('click', () => {
    const modal = document.getElementById('imageModal');
    const modalImage = document.getElementById('modal-image');
    modal.style.display = "flex";
    modalImage.src = mainImage.src;
});

window.addEventListener('click', (e) => {
    const modal = document.getElementById('imageModal');
    if (e.target === modal) {
        modal.style.display = "none";
    }
});
function closeModal() {
    var modal = document.getElementById('imageModal');
    modal.style.display = 'none';
}
function selectOnlyOne(checkbox) {
    var checkboxes = document.getElementsByName('sizeId');

    if (checkbox.checked) {
        for (var i = 0; i < checkboxes.length; i++) {
            if (checkboxes[i] !== checkbox) {
                checkboxes[i].checked = false;
            }
        }
    }
}
function validateForm() {
    var checkboxes = document.getElementsByName('sizeId');
    var checked = false;
    for (var i = 0; i < checkboxes.length; i++) {
        if (checkboxes[i].checked) {
            checked = true;
            break;
        }
    }

    if (!checked) {
        alert("Vui lòng chọn một kích thước.");
        return false;
    }
    return true;
}


function decreaseQuantity() {
    var quantityInput = document.getElementById("quantity");
    var quantity = parseInt(quantityInput.value);

    if (quantity > 1) {
        quantityInput.value = quantity - 1;
    }
}

function increaseQuantity() {
    var quantityInput = document.getElementById("quantity");
    var quantity = parseInt(quantityInput.value);

    quantityInput.value = quantity + 1;
}

document.getElementById('toggleDescription').addEventListener('click', function() {
    const fullDescription = document.querySelector('.full-description');
    const overlay = document.querySelector('.overlay');

    if (fullDescription.style.display === 'none' || fullDescription.style.display === '') {
        fullDescription.style.display = 'block';
        overlay.style.display = 'none';
        this.textContent = 'Thu gọn';
    } else {
        fullDescription.style.display = 'none';
        overlay.style.display = 'block';
        this.textContent = 'Xem thêm';
    }
});
