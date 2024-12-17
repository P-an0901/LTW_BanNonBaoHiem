// const sidebars = document.querySelectorAll(".sidebar-list-item.tab-content");
// const sections = document.querySelectorAll(".section");
//
// for (let i = 0; i < sidebars.length; i++) {
//     sidebars[i].onclick = function () {
//         document.querySelector(".sidebar-list-item.active")?.classList.remove("active");
//         document.querySelector(".section.active")?.classList.remove("active");
//
//         sidebars[i].classList.add("active");
//         sections[i].classList.add("active");
//     };
// }
document.addEventListener("DOMContentLoaded", function () {
    const table1 = document.getElementById("product-table");
    const table2 = document.getElementById("variant-content");
    const dataTable = new DataTable(table1, {
        "paging": true,
        "searching": false, 

        "ordering": false,  

        "info": false,  
        "lengthChange": false, 
        "pageLength": 3,    
    });
});


    const table2 = document.getElementById("variant-content");
            const variantDataTable = new DataTable(table2, {
                "paging": true,
                "searching": false, 

                "ordering": false,  

                "info": false,  
                "lengthChange": false,
                "pageLength": 3,    
            });



document.addEventListener('DOMContentLoaded', function() {
    // Lấy các nút
    const btnAddProduct = document.getElementById('btn-add-product');
    const btnAddCategory = document.getElementById('btn-add-category');
    const btnAddUser = document.getElementById('btn-add-user');

    // Lấy các modal
    const addProductModal = document.getElementById('addProductModal');
    const addCategoryModal = document.getElementById('addCategoryModal');
    const addUserModal = document.getElementById('addUserModal');

    // Kiểm tra và thêm sự kiện vào các nút nếu chúng tồn tại
    if (btnAddProduct && addProductModal) {
        btnAddProduct.addEventListener('click', function() {
            addProductModal.style.display = 'block';
        });
    }

    if (btnAddCategory && addCategoryModal) {
        btnAddCategory.addEventListener('click', function() {
            addCategoryModal.style.display = 'block';
        });
    }

    if (btnAddUser && addUserModal) {
        btnAddUser.addEventListener('click', function() {
            addUserModal.style.display = 'block';
        });
    }
});

    const detailsBtns = document.querySelectorAll('.pdetails-btn'); 
    detailsBtns.forEach(function(btn) {
        btn.addEventListener('click', function() {
            const productId = btn.getAttribute('data-id'); 
            console.log('ID Sản Phẩm:', productId); 
            const productIdDisplay = document.getElementById('product-id-display');
            productIdDisplay.textContent = `ID sản phẩm: ${productId}`; 
            productDetailModal.style.display = 'block';
        });


    // Đóng modal khi nhấn nút đóng (×)
    const closeButtons = document.querySelectorAll('.close');
    closeButtons.forEach(function(button) {
        button.addEventListener('click', function() {
            const modal = button.closest('.modal');
            modal.style.display = 'none';
        });
    });

    // Đóng modal khi nhấn ngoài vùng modal
    window.addEventListener('click', function(event) {
        if (event.target.classList.contains('modal')) {
            event.target.style.display = 'none';
        }
    });
});
document.querySelectorAll(".tab-item").forEach(tab => {
    tab.addEventListener("click", () => {
        document.querySelectorAll(".tab-content").forEach(content => content.classList.remove("active"));
        document.querySelectorAll(".tab-item").forEach(item => item.classList.remove("active"));

        const target = tab.getAttribute("data-tab");
        tab.classList.add("active");
        document.getElementById(target).classList.add("active");
    });
});
$(document).ready(function() {

    $("#btn-add-brand").click(function() {
        $("#addBrandForm").show();
        $("#editBrandForm").hide();
        $("#modalTitle").text('Thêm Thương Hiệu');
        $("#brandModal").modal('show');
    });

    window.openEditModal = function(id, name, imageUrl) {
        document.getElementById("brandId").value = id;
        document.getElementById("editBrandName").value = name;
        document.getElementById("brandImagePreview").src = imageUrl;

        $("#addBrandForm").hide();
        $("#editBrandForm").show();
        $("#modalTitle").text('Cập Nhật Thương Hiệu');
        $("#brandModal").modal('show');
    };

});







