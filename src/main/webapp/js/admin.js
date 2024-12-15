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

document.addEventListener('DOMContentLoaded', function () {
    // Dữ liệu mẫu cho biến thể
    const variantData = {
        1: [

            { id: 1, idp: 1, name: "Royal M139 Trắng", color: "Trắng", price: "100,000 VND", image: "images/Royal-M139-V.10-Trang.jpg" },
            { id: 2, idp: 1,name: "Royal M139 Trắng Đen", color: "Trắng Đen", price: "150,000 VND", image: "images/Royal-M139-V.5-Trang-den.jpg" },
        ],
        2: [
            { id: 1, idp: 2,name: "Royal M125K Chuột Mờ", color: "Chuột Mờ", price: "200,000 VND", image: "images/1-Royal M125K Chuột Mờ.png" },
        ],
        3: [
            { id: 1, idp: 3,name: "Asia MT-10 Đỏ Mờ", color: "Đỏ Mờ", price: "300,000 VND", image: "images/1.2-Asia MT-10-Do-mo.jpg" },
            { id: 2, idp: 3,name: "Asia MT-10 Mực Mờ", color: "Mực Mờ", price: "250,000 VND", image: "images/1.2-Asia MT-10-Muc-mo.jpg" },

       
        ],
    };
    const table2 = document.getElementById("variant-content");
            const variantDataTable = new DataTable(table2, {
                "paging": true,
                "searching": false, 

                "ordering": false,  

                "info": false,  
                "lengthChange": false,
                "pageLength": 3,    
            });

    // Xử lý khi nhấn nút Chi tiết
    document.querySelectorAll('.variant-btn').forEach(button => {
        button.addEventListener('click', function () {
            const productId = this.getAttribute('data-id');
            const variants = variantData[productId] || [];

            const variantTableBody = document.querySelector('#variant-content tbody');
            variantTableBody.innerHTML = ''; 
            variants.forEach((variant, index) => {
                const row = document.createElement('tr');
                row.innerHTML = `
                    <td>${index + 1}</td>

                    <td>${variant.idp}</td>

                    <td>${variant.name}</td>
                    <td><img src="${variant.image}" alt="${variant.name}" width="50"></td>
                    <td>${variant.color}</td>
                    <td>${variant.price}</td>
                    <td><button class="details-btn" data-id="3"><i class="fa-solid fa-eye"></i></button></td>

                    <td><button class="addImage-btn"><i class="fa-solid fa-plus"></i></button></td>

                    <td><button class="edit-btn"><i class="fa-solid fa-pen"></i></button></td>
                    <td><button class="delete-btn"><i class="fa-solid fa-trash"></i></button></td>
                `;
                variantTableBody.appendChild(row);
            });
            variantDataTable.clear();
            variantDataTable.rows.add(variantTableBody.rows); 
            variantDataTable.draw();
        });
    });
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
function openEditModal(id, name, imageUrl) {
    // Cập nhật giá trị của các trường trong form modal
    document.getElementById('brandName').value = name;
    document.getElementById('brandImage').value = '';

    // Mở modal
    $('#brandModal').modal('show');
}
$(document).ready(function() {
    $("#btn-add-brand").click(function() {
        $("#brandModal").modal('show');
    });
});




