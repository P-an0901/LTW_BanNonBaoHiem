/* Phân trang */
function scrollToProductList() {
    // Cuộn lên đầu container sản phẩm
    document.querySelector('.product-list').scrollIntoView({
        behavior: 'smooth',
        block: 'start'
    });
}
function setActivePage(event) {
    event.preventDefault();

    var links = document.querySelectorAll('.pagination a');
    links.forEach(function(link) {
        link.classList.remove('active');
    });

    event.target.classList.add('active');
    
    // Lọc sản phẩm theo trang
    var pageNumber = event.target.innerText.trim(); // Lấy số trang và loại bỏ khoảng trắng
    var productItems = document.querySelectorAll('.product-item');
    
    productItems.forEach(function(item) {
        // So sánh trang sản phẩm với trang hiện tại
        if (item.getAttribute('data-page') === pageNumber) {
            item.style.display = 'block'; // Hiển thị sản phẩm
        } else {
            item.style.display = 'none'; // Ẩn sản phẩm không thuộc trang hiện tại
        }
    });

    // Cuộn lên đầu danh sách sản phẩm
    scrollToProductList();
}


function changePage(direction) {
    // Tìm trang hiện tại
    const currentPage = document.querySelector('.pagination a.active');
    let newPage = currentPage;

    if (direction === -1 && currentPage.previousElementSibling) {
        // Di chuyển đến trang trước
        newPage = currentPage.previousElementSibling;
    } else if (direction === 1 && currentPage.nextElementSibling) {
        // Di chuyển đến trang sau
        newPage = currentPage.nextElementSibling;
    }

    // Nếu trang mới hợp lệ, thay đổi active page và lọc sản phẩm
    if (newPage && newPage.tagName === 'A' && newPage !== currentPage) {
        currentPage.classList.remove('active');
        newPage.classList.add('active');

        // Lọc sản phẩm theo trang
        var pageNumber = newPage.innerText.trim(); // Lấy số trang và loại bỏ khoảng trắng
        var productItems = document.querySelectorAll('.product-item');

        productItems.forEach(function(item) {
            if (item.getAttribute('data-page') === pageNumber) {
                item.style.display = 'block'; // Hiển thị sản phẩm thuộc trang này
            } else {
                item.style.display = 'none'; // Ẩn sản phẩm không thuộc trang này
            }
        });

        // Cuộn lên đầu danh sách sản phẩm
        scrollToProductList();
    }
}
window.onload = function() {
    var activePage = document.querySelector('.pagination a.active');
    if (!activePage) {
        activePage = document.querySelector('.pagination a');
        if (activePage) {
            setActivePage({ target: activePage });
        }
    }

    // Đảm bảo chỉ hiển thị sản phẩm thuộc trang hiện tại
    var pageNumber = activePage.innerText.trim();
    var productItems = document.querySelectorAll('.product-item');
    productItems.forEach(function(item) {
        if (item.getAttribute('data-page') === pageNumber) {
            item.style.display = 'block'; // Hiển thị sản phẩm thuộc trang này
        } else {
            item.style.display = 'none'; // Ẩn sản phẩm không thuộc trang này
        }
    });
};


