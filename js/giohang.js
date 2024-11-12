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
        const danhMucLink = document.querySelector('.menu-link[href="danhmuc.html"]');
        const trangChuLink = document.querySelector('.menu-link[href="index.html"]');

        // Xóa 'active' khỏi tất cả các menu links
        document.querySelectorAll('.menu-link').forEach(link => link.classList.remove('active'));

        // Kiểm tra URL hiện tại để thêm 'active' cho "Trang chủ" hoặc "Danh Mục Sản phẩm"
        if (currentUrl.includes("index.html") || currentUrl === "/") {
            trangChuLink.classList.add('active');
        } else {
            danhMucLink.classList.add('active');
        }

        // Xử lý sự kiện click cho tất cả submenu để luôn thêm 'active' cho "Danh Mục Sản phẩm"
        document.querySelectorAll('.submenu a').forEach(subLink => {
            subLink.addEventListener('click', function(event) {
                // Bỏ 'active' khỏi tất cả các menu links
                document.querySelectorAll('.menu-link').forEach(link => link.classList.remove('active'));

                // Thêm 'active' cho "Danh Mục Sản phẩm"
                danhMucLink.classList.add('active');
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
        // Đăng ký
        let signupButton = document.getElementById('signup-button');
        signupButton.addEventListener('click', (event) => {
            let signupResult = handleSignup(event);

            if (signupResult == true) {
                alert('Đăng ký thành công');
                resetModal();
                document.querySelector('.sign-up').style.display = 'none';
                document.querySelector('.login').style.display = 'block';
            }
        });

        // Đăng nhập
        let loginButton = document.getElementById('login-button');
        loginButton.addEventListener('click', (event) => {
            let accountFound = handleLogin(event);

            // Nếu đăng nhập thành công, hiển thị thông báo
            if (accountFound) {
                alert('Đăng nhập thành công');
                resetModal();
                document.getElementById('login-menu').style.display = 'none';
                document.getElementById('signup-menu').style.display = 'none';
                document.getElementById('account-menu').style.display = 'block';
                document.getElementById('account-name').innerText = accountFound.fullName;
                $('#signup-login').modal('hide');
            }
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
}// Giỏ hàng dưới dạng mảng
let cart = [];

// Khởi tạo giỏ hàng từ localStorage
document.addEventListener('DOMContentLoaded', function () {
    const storedCart = JSON.parse(localStorage.getItem('cart')) || [];
    cart = storedCart;
    updateCartDisplay();
});

// Hàm trích xuất số từ chuỗi
function extractNumber(priceString) {
    return Number(priceString.replace(/[^0-9]/g, ''));
}

// Hàm tính tổng tiền của giỏ hàng
function calculateTotal() {
    return cart.reduce((total, product) => total + extractNumber(product.price), 0);
}

// Cập nhật giỏ hàng hiển thị và tổng tiền
function updateCartDisplay() {
    const cartItemsContainer = document.getElementById('cart-items');
    const emptyMessage = document.getElementById('empty-message');
    const cartTotal = document.getElementById('cart-total');

    // Cập nhật danh sách sản phẩm trong giỏ hàng
    if (cartItemsContainer) {
        cartItemsContainer.innerHTML = '';

        if (cart.length > 0) {
            emptyMessage.style.display = 'none';
            cart.forEach((product, index) => {
                const productHTML = `
                    <li class="cart-item" id="cart-item-${index}">
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
            emptyMessage.style.display = 'block';
        }
    }

    // Cập nhật tổng tiền trong giỏ hàng
    if (cartTotal) {
        cartTotal.textContent = calculateTotal().toLocaleString() + ' đ';
    }
}

// Hàm xóa sản phẩm khỏi giỏ hàng và cập nhật hiển thị ngay lập tức
function removeFromCart(index) {
    if (window.confirm('Bạn có chắc chắn muốn xóa sản phẩm này khỏi giỏ hàng?')) {
        cart.splice(index, 1); // Xóa sản phẩm khỏi giỏ hàng
        saveCart(); // Lưu lại giỏ hàng vào localStorage
        location.reload();
    }
}

// Lưu giỏ hàng vào localStorage
function saveCart() {
    localStorage.setItem('cart', JSON.stringify(cart));
}
function redirectToCheckout() {
    saveCart(); // Lưu giỏ hàng vào localStorage
    window.location.href = "checkout.html"; // Chuyển hướng sang trang thanh toán
}
