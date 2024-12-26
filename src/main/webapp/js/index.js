        checkStatus();
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
        // updateCart();

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
                checkStatus();
                $('#signup-login').modal('hide');
             }else{
                
                document.querySelector('.form-message-login').style.display = 'block';
                return null;
             }
        });
        // Sự kiện chuyển đổi giữa đăng ký và đăng nhập
        document.querySelector('.login-link').addEventListener('click', function () {
            resetModal();
            document.querySelector('.sign-up').style.display = 'none';
            document.querySelector('.forgot-password-form').style.display = 'none';
            document.querySelector('.login').style.display = 'block';
        });

        document.querySelector('.signup-link').addEventListener('click', function () {
            resetModal();
            document.querySelector('.login').style.display = 'none';
            document.querySelector('.sign-up').style.display = 'block';
        });

        document.querySelector('.forgot-password-link').addEventListener('click', function () {
            resetModal();
            document.querySelector('.login').style.display = 'none';
            document.querySelector('.forgot-password-form').style.display = 'block';
        });

        document.querySelector('.forgot-password-form .login-link').addEventListener('click', function () {
            resetModal();
            document.querySelector('.forgot-password-form').style.display = 'none'; 
            document.querySelector('.login').style.display = 'block'; 
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
        modal.querySelector('.form-message-login').innerHTML = '';
        modal.querySelector('.form-message-login').style.display = 'none';
    }

// Lấy tất cả các nút button với class 'size-button'
        const buttons = document.querySelectorAll('.size-button');

        buttons.forEach(button => {
            button.addEventListener('click', () => {
                const productItem = button.closest('.product-item');

                const sizeButtons = productItem.querySelectorAll('.size-button');
                sizeButtons.forEach(btn => btn.classList.remove('selected'));

                button.classList.add('selected');
                const sizeId = button.getAttribute('data-value');
                const productId = productItem.querySelector('input[name="productId"]').value;
                productItem.querySelector(`.sizeId-${productId}`).value = sizeId;
            });
        });
        function validateF() {
            const productItem = event.target.closest('.product-item');
            const sizeIdInput = productItem.querySelector('input[name="sizeId"]');

            if (!sizeIdInput.value) {
                alert('Vui lòng chọn kích thước trước khi thêm vào giỏ hàng!');
                return false;
            }
            return true;
        }


        function checkStatus() {
    const loggedInUser = JSON.parse(localStorage.getItem("loggedInUser"));

    if (loggedInUser) {
        document.getElementById("account-menu").style.display = "block";
        document.getElementById("login-menu").style.display = "none";
        document.getElementById("signup-menu").style.display = "none";
        document.getElementById("account-name").textContent = loggedInUser.fullName || "Tài khoản";
        if (loggedInUser.role === 'admin') {
            document.getElementById('admin-page').style.display = 'block';
        } else {
            document.getElementById('admin-page').style.display = 'none';
        }
    } else {
        document.getElementById("account-menu").style.display = "none";
        document.getElementById("login-menu").style.display = "block";
        document.getElementById("signup-menu").style.display = "block";
    }
}
function logout() {
    // Xóa thông tin người dùng khỏi localStorage
    localStorage.removeItem("loggedInUser");

    // Cập nhật lại trạng thái giao diện
    checkStatus();

    // Thông báo và chuyển hướng
    alert("Bạn đã đăng xuất thành công!");
    window.location.href = "index.jsp";
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

function extractNumber(priceString) {
    return Number(priceString.replace(/[^0-9]/g, ''));
}

/*Lên đầu trang */
window.addEventListener("scroll", function() {
    const backToTopButton = document.querySelector(".back-to-top");
    if (window.scrollY > 200) {
        backToTopButton.classList.add("active");
    } else {
        backToTopButton.classList.remove("active");
    }
});
document.querySelector(".back-to-top").addEventListener("click", function(event) {
    event.preventDefault(); 
    window.scrollTo({
        top: 0,
        behavior: "smooth" 
    });
});
