document.addEventListener("DOMContentLoaded", function () {
    const table1 = document.getElementById("product-table");
    const dataTable = new DataTable(table1, {
        "paging": true,
        "searching": true,

        "ordering": true,

        "info": false,  
        "lengthChange": false, 
        "pageLength": 5,
    });
});


    const table2 = document.getElementById("variant-content");
            const variantDataTable = new DataTable(table2, {
                "paging": true,
                "searching": true,

                "ordering": true,

                "info": false,
                "lengthChange": false,
                "pageLength": 5,
            });



document.addEventListener('DOMContentLoaded', function() {
    // Lấy các nút
    const btnAddUser = document.getElementById('btn-add-user');

    // Lấy các modal
    const addCategoryModal = document.getElementById('addCategoryModal');
    const addUserModal = document.getElementById('addUserModal');

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
$(document).ready(function() {
    $('#btn-add-product_variant').click(function () {
        $('#addVariantModal').modal('show')
    });

    $('#btn-add-category').click(function () {
        $('#addCategoryModal').modal('show')
    });

    $('#btn-add-product').click(function () {
        $('#addProductModal').modal('show')
    });

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







