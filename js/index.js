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
    $('#signup-login').modal('show'); // Hiển thị modal
    }

        // Sự kiện chuyển đổi giữa đăng ký và đăng nhập
document.querySelector('.login-link').addEventListener('click', function () {
document.querySelector('.sign-up').style.display = 'none';
document.querySelector('.login').style.display = 'block';
});

document.querySelector('.signup-link').addEventListener('click', function () {
document.querySelector('.login').style.display = 'none';
document.querySelector('.sign-up').style.display = 'block';
});

document.querySelector('.cart-dropdown').addEventListener('click', function(event) {
    event.stopPropagation(); // Ngăn không cho sự kiện click lan ra ngoài
});
const body = document.querySelector("body");
function openCart() {
    showCart();
    document.querySelector('.modal-cart').classList.add('open');
    body.style.overflow = "hidden";
}

function closeCart() {
    document.querySelector('.modal-cart').classList.remove('open');
    body.style.overflow = "auto";
    updateAmount();
}
function showCart() {
    if (localStorage.getItem('currentuser') != null) {
        let currentuser = JSON.parse(localStorage.getItem('currentuser'));
        if (currentuser.cart.length != 0) {
            document.querySelector('.gio-hang-trong').style.display = 'none';
            document.querySelector('button.thanh-toan').classList.remove('disabled');
            let productcarthtml = '';
            currentuser.cart.forEach(item => {
                let product = getProduct(item);
                productcarthtml += `<li class="cart-item" data-id="${product.id}">
                <div class="cart-item-info">
                    <p class="cart-item-title">
                        ${product.title}
                    </p>
                    <span class="cart-item-price price" data-price="${product.price}">
                    ${vnd(parseInt(product.price))}
                    </span>
                </div>
                <p class="product-note"><i class="fa-light fa-pencil"></i><span>${product.note}</span></p>
                <div class="cart-item-control">
                    <button class="cart-item-delete" onclick="deleteCartItem(${product.id},this)">Xóa</button>
                    <div class="buttons_added">
                        <input class="minus is-form" type="button" value="-" onclick="decreasingNumber(this)">
                        <input class="input-qty" max="100" min="1" name="" type="number" value="${product.soluong}">
                        <input class="plus is-form" type="button" value="+" onclick="increasingNumber(this)">
                    </div>
                </div>
            </li>`
            });
            document.querySelector('.cart-list').innerHTML = productcarthtml;
            updateCartTotal();
            saveAmountCart();
        } else {
            document.querySelector('.gio-hang-trong').style.display = 'flex'
        }
    }
    let modalCart = document.querySelector('.modal-cart');
    let containerCart = document.querySelector('.cart-container');
    let themsp = document.querySelector('.them-san-pham');
    modalCart.onclick = function () {
        closeCart();
    }
    themsp.onclick = function () {
        closeCart();
    }
    containerCart.addEventListener('click', (e) => {
        e.stopPropagation();
    })
}
const menuLinks = document.querySelectorAll('.menu-link');
    const submenuItems = document.querySelectorAll('.menu-list-item');

    menuLinks.forEach(link => {
        link.addEventListener('click', function(event) {
            const hasSubmenu = this.nextElementSibling && this.nextElementSibling.classList.contains('submenu');
            if (hasSubmenu) {
            } else {
                menuLinks.forEach(link => {
                    link.classList.remove('active');
                });
                this.classList.add('active');
            }
        });
    });
