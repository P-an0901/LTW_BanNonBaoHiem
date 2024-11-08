/* Chèn header*/
$(document).ready(function(){
    $("#header-container").load("header.html", function(){
        const headerNav = document.querySelector(".header-bottom");
        if (headerNav) {
            let lastScrollY = window.scrollY;

            window.addEventListener("scroll", () => {
                if (lastScrollY < window.scrollY) {
                    headerNav.classList.add("hide");
                } else {
                    headerNav.classList.remove("hide");
                }
                lastScrollY = window.scrollY;
            });
        }
        const currentUrl = window.location.pathname;
        const menuLinks = document.querySelectorAll('.menu-link');
        
        // Bỏ lớp 'active' khỏi tất cả các menu links
        menuLinks.forEach(link => link.classList.remove('active'));

        // Thêm lớp 'active' cho link hiện tại dựa trên URL
        menuLinks.forEach(link => {
            if (currentUrl.includes(link.getAttribute('href'))) {
                link.classList.add('active');
            }
        });

        // Thêm sự kiện click để chuyển đổi active khi nhấn vào các liên kết menu
        menuLinks.forEach(link => {
            link.addEventListener('click', function() {
                menuLinks.forEach(link => link.classList.remove('active'));
                this.classList.add('active');
            });
        });
        document.querySelector('.cart-dropdown').addEventListener('click', function(event) {
            event.stopPropagation(); // Ngăn không cho sự kiện click lan ra ngoài
        });
        updateCart();
    })
     // Khi nội dung của modal được tải xong
     $("#modal-container").load("modal.html", function() {
        // Đảm bảo rằng các sự kiện đã được gán sau khi tải modal
        const closeButton = document.querySelector('.close');
        if (closeButton) {
            closeButton.addEventListener('click', resetModal);
        }

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
    });

    // Hàm mở modal với các loại form: login, signup
    window.openModal = function(type) {
        if (type === 'login') {
            document.querySelector('.sign-up').style.display = 'none'; // Ẩn phần đăng ký
            document.querySelector('.login').style.display = 'block';  // Hiển thị phần đăng nhập
        } else if (type === 'signup') {
            document.querySelector('.login').style.display = 'none';   // Ẩn phần đăng nhập
            document.querySelector('.sign-up').style.display = 'block'; // Hiển thị phần đăng ký
        }
        document.querySelector('.forgot-password-form').style.display = 'none';
        $('#signup-login').modal('show'); // Hiển thị modal
    };

    // Hàm reset modal
    function resetModal() {
        const modal = document.querySelector('#signup-login');
        modal.querySelectorAll('input[type="text"], input[type="password"]').forEach(input => {
            input.value = ''; 
        });
        modal.querySelectorAll('.form-message').forEach(msg => {
            msg.textContent = ''; // Xóa nội dung của các thông báo
        });
        
        modal.querySelector('.sign-up').style.display = 'none';
        modal.querySelector('.forgot-password-form').style.display = 'none';
        modal.querySelector('.login').style.display = 'block';
    }
    $("#footer").load("footer.html")
});
function loginWithFacebook() {
    // Logic for Facebook login
  }
  
  function loginWithGoogle() {
    // Logic for Google login
  }

/* Giảm giá*/
const products = document.querySelectorAll('.product-item');

products.forEach(pro => {
    const priceElement = pro.querySelector('.product-price');
    const salePriceElement = pro.querySelector('.product-sale-price');

    // Kiểm tra nếu phần tử giá có tồn tại
    if (priceElement && salePriceElement) {
        if (pro.dataset.hasDiscount === 'true') {
            pro.classList.add('has-discount');
            priceElement.style.textDecoration = 'line-through'; 
            salePriceElement.style.display = 'block'; 
        } else {
            priceElement.style.textDecoration = 'none';
            pro.classList.remove('has-discount');
            //salePriceElement.style.display = 'none'; 
        }
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
    // Cập nhật giỏ hàng trong localStorage
    localStorage.setItem('cart', JSON.stringify(cart));

    // Cập nhật giỏ hàng hiển thị
    const cartItemsContainer = document.getElementById('cart-items');
    const emptyMessage = document.getElementById('empty-message');
    
    // Xóa nội dung hiện tại trong giỏ
   if (cartItemsContainer) {
    cartItemsContainer.innerHTML = '';  // Xóa tất cả nội dung của phần tử
} else {
    console.error('Không tìm thấy phần tử #cart-items');
}

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

    // Cập nhật badge giỏ hàng
    const cartBadge = document.querySelector('.cart-container .badge');
    cartBadge.textContent = cart.length;
}

// Hàm xóa sản phẩm khỏi giỏ
function removeFromCart(index) {
    // Xóa sản phẩm khỏi giỏ
    cart.splice(index, 1);

    // Cập nhật lại giỏ hàng
    updateCart();
}

// Đọc giỏ hàng từ localStorage khi trang tải
document.addEventListener('DOMContentLoaded', function() {
    const storedCart = JSON.parse(localStorage.getItem('cart')) || [];
    cart = storedCart;
    updateCart();
});
