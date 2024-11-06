const headerNav = document.querySelector(".header-bottom");
let lastScrollY = window.scrollY;

window.addEventListener("scroll", () => {
    if(lastScrollY < window.scrollY) {
        headerNav.classList.add("hide")
    } else {
        headerNav.classList.remove("hide")
    }
    lastScrollY = window.scrollY;
})
function openModal(type) {
    if (type === 'login') {
        document.querySelector('.sign-up').style.display = 'none'; // Ẩn phần đăng ký
        document.querySelector('.login').style.display = 'block';  // Hiển thị phần đăng nhập
    } else if (type === 'signup') {
        document.querySelector('.login').style.display = 'none';   // Ẩn phần đăng nhập
        document.querySelector('.sign-up').style.display = 'block'; // Hiển thị phần đăng ký
    }
    document.querySelector('.forgot-password-form').style.display = 'none';
    $('#signup-login').modal('show'); // Hiển thị modal
    }
function resetModal() {
        const modal = document.querySelector('#signup-login');
        // Reset tất cả các input trong modal
        modal.querySelectorAll('input[type="text"], input[type="password"]').forEach(input => {
            input.value = ''; // Đặt lại giá trị cho từng input
        });
        modal.querySelectorAll('.form-message').forEach(msg => {
            msg.textContent = ''; // Xóa nội dung của các thông báo
        });
        
        // Ẩn tất cả các phần trong modal và hiển thị lại phần đăng nhập
        modal.querySelector('.sign-up').style.display = 'none';
        modal.querySelector('.forgot-password-form').style.display = 'none';
        modal.querySelector('.login').style.display = 'block';
    }
    
    document.querySelector('.close').addEventListener('click', function () {
        resetModal(); // Gọi hàm reset khi nhấn nút đóng
    });
    
        // Sự kiện chuyển đổi giữa đăng ký và đăng nhập
document.querySelector('.login-link').addEventListener('click', function () {
document.querySelector('.sign-up').style.display = 'none';
document.querySelector('.forgot-password-form').style.display = 'none';
document.querySelector('.login').style.display = 'block';
});

document.querySelector('.signup-link').addEventListener('click', function () {
document.querySelector('.login').style.display = 'none';
document.querySelector('.sign-up').style.display = 'block';
});

document.querySelector('.forgot-password-link').addEventListener('click', function () {
document.querySelector('.login').style.display = 'none';
document.querySelector('.forgot-password-form').style.display = 'block';
});
document.querySelector('.forgot-password-form .login-link').addEventListener('click', function () {
document.querySelector('.forgot-password-form').style.display = 'none'; 
document.querySelector('.login').style.display = 'block'; 
});


document.querySelector('.cart-dropdown').addEventListener('click', function(event) {
    event.stopPropagation(); // Ngăn không cho sự kiện click lan ra ngoài
});

/* Ngăn hành động mục có dropdown*/
const menuLinks = document.querySelectorAll('.menu-link');
    const submenuItems = document.querySelectorAll('.menu-list-item');

    menuLinks.forEach(link => {
        link.addEventListener('click', function(event) {
                menuLinks.forEach(link => {
                    link.classList.remove('active');
                });
                this.classList.add('active');
        });
});


/* Giảm giá*/
const products = document.querySelectorAll('.product-item');
let hasDiscount = false;

products.forEach(product => {
    if (product.dataset.hasDiscount === 'true') {
        hasDiscount = true;
        const priceElement = product.querySelector('.product-price');
        const salePriceElement = product.querySelector('.product-sale-price');

        // Gạch giá gốc và hiển thị giá khuyến mại
        priceElement.style.textDecoration = 'line-through'; 
        salePriceElement.style.display = 'block'; 
    } else {
        const priceElement = product.querySelector('.product-price');
        const salePriceElement = product.querySelector('.product-sale-price');

        priceElement.style.textDecoration = 'none'; 
        // salePriceElement.style.display = 'none'; 
    }
});
// Giỏ hàng dưới dạng mảng
let cart = [];

// Hàm thêm sản phẩm vào giỏ hàng
function addToCart(button) {
    // Lấy thông tin sản phẩm từ DOM
    const productElement = button.closest('.product-item');
    const productName = productElement.querySelector('.product-name').innerText;
    const productPrice = productElement.querySelector('.product-price').innerText;
    const productImage = productElement.querySelector('.product-image').src;

    // Kiểm tra xem sản phẩm đã có trong giỏ hay chưa
    const productInCart = cart.find(item => item.name === productName);
    if (productInCart) {
        alert('Sản phẩm này đã có trong giỏ hàng!');
        return;
    }

    // Thêm sản phẩm vào giỏ
    const product = {
        name: productName,
        price: productPrice,
        image: productImage,
    };
    cart.push(product);

    // Cập nhật giỏ hàng
    updateCart();
}

// Hàm cập nhật giỏ hàng
function updateCart() {
    const cartItemsContainer = document.getElementById('cart-items');
    const emptyMessage = document.getElementById('empty-message');

    // Xóa nội dung hiện tại trong giỏ
    cartItemsContainer.innerHTML = '';

    // Nếu giỏ hàng có sản phẩm
    if (cart.length > 0) {
        emptyMessage.style.display = 'none'; // Ẩn thông báo "giỏ hàng trống"

        // Hiển thị từng sản phẩm trong giỏ
        cart.forEach((product, index) => {
            const productHTML = `
        <li class="cart-item">
          <img src="${product.image}" alt="${product.name}" class="cart-item-img">
          <span class="cart-item-name">${product.name}</span>
          <span class="cart-item-price">${product.price}</span>
          <button class="remove-item-btn" onclick="removeFromCart(${index})">
            <i class="fas fa-trash"></i> Xóa
          </button>
        </li>
      `;
            cartItemsContainer.innerHTML += productHTML;
        });
    } else {
        emptyMessage.style.display = 'block'; // Hiển thị thông báo giỏ hàng trống
    }
}

// Hàm xóa sản phẩm khỏi giỏ
function removeFromCart(index) {
    // Xóa sản phẩm khỏi giỏ
    cart.splice(index, 1);

    // Cập nhật lại giỏ hàng
    updateCart();
}


function updateCart() {
    var cartItems = JSON.parse(localStorage.getItem('cart')) || [];
    var cartBadge = document.querySelector('.cart-container .badge');
    cartBadge.textContent = cartItems.length;

    var cartList = document.querySelector('#cart-items');
    cartList.innerHTML = '';  // Xóa danh sách cũ
    cartItems.forEach(function(item) {
        var li = document.createElement('li');
        li.textContent = `${item.name} - ${item.price}`;
        cartList.appendChild(li);
    });
}