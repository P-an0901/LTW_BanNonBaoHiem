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

function scrollToProductList(event) {
    // Ngăn chặn hành động mặc định của thẻ a
    event.preventDefault();

    // Cuộn lên đầu container sản phẩm
    document.querySelector('.slider').scrollIntoView({
        behavior: 'smooth',
        block: 'start'
    });
}
/* Phân trang*/
function setActivePage(event) {

    document.querySelector('.pagination a.active')?.classList.remove('active');
    event.target.classList.add('active');
    scrollToProductList(event);
}

function changePage(direction) {
    event.preventDefault();
    // Tìm trang hiện tại
    const currentPage = document.querySelector('.pagination a.active');
    let newPage = currentPage;

    if (direction === -1 && currentPage.previousElementSibling) {
        newPage = currentPage.previousElementSibling;
    } else if (direction === 1 && currentPage.nextElementSibling) {
        newPage = currentPage.nextElementSibling;
    }

    if (newPage && newPage.tagName === 'A' && newPage !== currentPage) {
        currentPage.classList.remove('active');
        newPage.classList.add('active');

        scrollToProductList(event);
    }
}
$(document).ready(function () {
    // Tự động chuyển slide mỗi 3 giây
    setInterval(function() {
        $('#myCarousel').carousel('next'); // Chuyển đến slide tiếp theo
    }, 3000); // Thay đổi 3000 thành thời gian bạn muốn (3 giây ở đây)
});



