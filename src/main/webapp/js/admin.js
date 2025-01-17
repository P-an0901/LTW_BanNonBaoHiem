document.addEventListener("DOMContentLoaded", function () {
    const table1 = document.getElementById("product-table");
    const dataTable = new DataTable(table1, {
        "paging": true,
        "searching": true,
        "ordering": true,
        "info": true,
        "lengthChange": true,
        "pageLength": 5,
    });
    const table2 = document.getElementById("variant-content");
    const variantDataTable = new DataTable(table2, {
        "paging": true,
        "searching": true,
        "ordering": true,
        "info": true,
        "lengthChange": true,
        "pageLength": 5,
    });
    const table3 = document.getElementById("brand-table");
    const brandDataTable = new DataTable(table3, {
        "paging": true,
        "searching": true,
        "ordering": true,
        "info": true,
        "lengthChange": true,
        "pageLength": 5,
    });
    const table4 = document.getElementById("category-table");
    const cateDataTable = new DataTable(table4, {
        "paging": true,
        "searching": true,
        "ordering": true,
        "info": true,
        "lengthChange": true,
        "pageLength": 5,
    });
    const table5 = document.getElementById("p-size-content");
    const productSizeDataTable = new DataTable(table5, {
        "paging": true,
        "searching": true,
        "ordering": true,
        "info": true,
        "lengthChange": true,
        "pageLength": 5,
    });
    const table6 = document.getElementById("user-table");
    const userDataTable = new DataTable(table6, {
        "paging": true,
        "searching": true,
        "ordering": true,
        "info": true,
        "lengthChange": true,
        "pageLength": 5,
    });
    const table7 = document.getElementById("promotion-table");
    const promtionDataTable = new DataTable(table7, {
        "paging": true,
        "searching": true,
        "ordering": true,
        "info": true,
        "lengthChange": true,
        "pageLength": 5,
    });
    const table8 = document.getElementById("order-table");
    const orderDataTable = new DataTable(table8, {
        "paging": true,
        "searching": true,
        "ordering": true,
        "info": true,
        "lengthChange": true,
        "pageLength": 5,
    });
});
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

$(document).ready(function() {
    $('#btn-add-product_variant').click(function () {
        document.getElementById('addVariantForm').style.display = 'block';
        document.getElementById('editVariantForm').style.display = 'none';
        document.querySelector('.modal-title').textContent = 'Thêm biến thể sản phẩm';
        $('#addVariantModal').modal('show')
    });

    $('#btn-add-category').click(function () {
        $('#addCategoryModal').modal('show')
    });

    $('#btn-add-user').click(function () {
        $('#addUserModal').modal('show')
    });

    $('#btn-add-product').click(function () {
        document.getElementById('addProForm').style.display = 'block';
        document.getElementById('editProForm').style.display = 'none';
        document.querySelector('.modal-title').textContent = 'Thêm sản phẩm';
        $('#addProductModal').modal('show')
    });
    $('#btn-add-brand').click(function () {
        $('#addBrandModal').modal('show')
    });
    $('#btn-add-promotion').click(function () {
        $('#addDPromotionModal').modal('show')
    });
});
function openEditBrandModal(brandId) {

    $.ajax({
        type: 'GET',
        url: '/LTW_BanNonBaoHiem/show-tab-product',
        data: {
            action: 'findBrand',
            brandId: brandId
        },
        dataType: 'json',
        success: function(data) {
            $('#editBrandId').val(data.id);
            $('#editBrandName').val(data.name);
            $('#editBrandImagePreview').attr('src', '/LTW_BanNonBaoHiem/' + data.imageUrl);

            $('#editBrandModal').modal('show');
        },
        error: function(xhr, status, error) {
            console.log('Lỗi:', error);
            console.log('Response:', xhr.responseText);
        }
    });
}
function openEditProModal(productId) {

    $.ajax({
        type: 'GET',
        url: '/LTW_BanNonBaoHiem/show-tab-product',
        data: {
            action: 'findProduct',
            productId: productId
        },
        dataType: 'json',
        success: function(data) {
            $('#editProductId').val(data.id);
            $('#productName').val(data.name);
            $('#productDescription').val(data.description);
            $('#brand').val(data.brand.id);
            $('#category').val(data.category.id);

            document.getElementById('addProForm').style.display = 'none';
            document.getElementById('editProForm').style.display = 'block';
            document.querySelector('.modal-title').textContent = 'Chỉnh sửa sản phẩm';
            $('#addProductModal').modal('show');
        },
        error: function(xhr, status, error) {
            console.log('Lỗi:', error);
            console.log('Response:', xhr.responseText);
        }
    });
}
function openEditVariantModal(variantId) {

    $.ajax({
        type: 'GET',
        url: '/LTW_BanNonBaoHiem/show-tab-product',
        data: {
            action: 'findProductVariant',
            variantId: variantId
        },
        dataType: 'json',
        success: function(data) {
            $('#editVariantId').val(data.id);
            $('#editProductParent').val(data.productId);
            $('#editVariantName').val(data.name);
            $('#editVariantColor').val(data.color);
            $('#editVariantPrice').val(data.price);
            $('#editVariantImagePreview').attr('src', '/LTW_BanNonBaoHiem/' + data.image);
            $('#editVariantActive').val(data.isActive ? 1 : 0);

            document.getElementById('addVariantForm').style.display = 'none';
            document.getElementById('editVariantForm').style.display = 'block';
            document.getElementById('addVariantModalLabel').textContent = 'Chỉnh sửa biến thể sản phẩm';
            $('#addVariantModal').modal('show');
        },
        error: function(xhr, status, error) {
            console.log('Lỗi:', error);
            console.log('Response:', xhr.responseText);
        }
    });
}
function openDetailProModal(productId) {
    $.ajax({
        type: 'GET',
        url: '/LTW_BanNonBaoHiem/show-tab-product',
        data: {
            action: 'showProductTech',
            productId: productId
        },
        dataType: 'json',
        success: function(data) {
            console.log(data);
            // $('#product-id-display').text(data.productId);
            $('#list-size').text(data.lstSize);
            $('#weight-value').text(data.weight);
            $('#list-color').text(data.lstColor);
            $('#standards').text(data.standards);
            $('#material-value').text(data.material);
            $('#inner-lining').text(data.innerLining);
            $('#visor-type').text(data.visorType);
            $('#made-in').text(data.madeIn);
            $('#condition-value').text(data.condition);
            $('#warranty-value').text(data.warranty);
            $('#returns-value').text(data.returns);
            $('#productDetailModal').modal('show');
        },
        error: function(xhr, status, error) {
            console.log('Lỗi:', error);
            console.log('Response:', xhr.responseText);
        }
    });
}
$('#addUserModal').submit(function(event){
    event.preventDefault();
    var username = $('#username').val();
    var password = $('#password').val();
    var confirmPassword = $('#password2').val();
    var email = $('#email').val();
    var fullName = $('#fullName').val();
    var role = $('#role').val();
    var active = $('#active').val();

    $.ajax({
        url: '/LTW_BanNonBaoHiem/admin/user',
        method: 'POST',
        data: {
            username: username,
            password: password,
            confirmPassword: confirmPassword,
            email: email,
            fullName: fullName,
            role: role,
            active: active,
            action: 'add'
        },
        success: function(response) {
            if (response.registerSuccess) {
                location.reload();
            }
        },
        error: function(xhr) {
            var errors = JSON.parse(xhr.responseText);

            $('.form-message').text('').hide();


            if (errors.registerError) {
                $('.form-message-register').text(errors.registerError).show();
            }
            if (errors.username) {
                $('.form-message-username').text(errors.username).show();
            }
            if (errors.password) {
                $('.form-message-password').text(errors.password).show();
            }
            if (errors.confirmPass) {
                $('.form-message-password-confi').text(errors.confirmPass).show();
            }
            if (errors.email) {
                $('.form-message-email').text(errors.email).show();
            }
            if (errors.name) {
                $('.form-message-name').text(errors.name).show();
            }
            $('#signup-login').modal('show');
        }
    });
});
$(document).ready(function() {
    $(".detail-btn").on("click", function() {
        var orderId = $(this).data("order-id");
        $.ajax({
            url: '/LTW_BanNonBaoHiem/admin/order',
            method: 'POST',
            data: { orderId: orderId, action: "detailOrder" },
            success: function(response) {
                if (response) {
                    console.log(response);

                    $('#modal-full-name').text(response.order.recipientName);
                    $('#modal-address').text(response.order.shippingAddress);
                    $('#modal-phone').text(response.order.phone);
                    $('#modal-note').text(response.order.note);
                    $('#delivery-date').text(response.order.estimatedDelivery);
                    $('#modal-payment-method').text(response.order.paymentMethod.name);
                    $('#modal-totalAmount').text(response.order.totalAmount);

                    var tableBody = $("#detailOrderModal table tbody");
                    tableBody.empty();
                    if (response.items && response.items.length > 0) {
                        response.items.forEach(function(item) {
                            var row = `<tr>
                                <td></td>
                                <td>${item.proVariant.name}</td>
                                <td>${item.size.id}</td>
                                <td>${item.quantity}</td>
                                <td>${item.price} đ</td>
                            </tr>`;
                            tableBody.append(row);
                        });
                    } else {
                        tableBody.append("<tr><td colspan='4'>Không có sản phẩm</td></tr>");
                    }

                    $('#detailOrderModal').modal('show');
                } else {
                    alert("Dữ liệu trả về không hợp lệ!");
                }
            },
            error: function() {
                alert("Có lỗi xảy ra trong việc lấy dữ liệu!");
            }
        });
    });
});



document.getElementById('edit-product-btn').addEventListener('click', function() {
    // Chuyển đổi các ô thông tin sản phẩm thành input để chỉnh sửa
    document.getElementById('list-size').innerHTML = `<input type="text" value="${document.getElementById('list-size').innerHTML}">`;
    document.getElementById('weight-value').innerHTML = `<input type="text" value="${document.getElementById('weight-value').innerHTML}">`;
    document.getElementById('list-color').innerHTML = `<input type="text" value="${document.getElementById('list-color').innerHTML}">`;
    document.getElementById('standards').innerHTML = `<input type="text" value="${document.getElementById('standards').innerHTML}">`;
    document.getElementById('material-value').innerHTML = `<input type="text" value="${document.getElementById('material-value').innerHTML}">`;
    document.getElementById('inner-lining').innerHTML = `<input type="text" value="${document.getElementById('inner-lining').innerHTML}">`;
    document.getElementById('visor-type').innerHTML = `<input type="text" value="${document.getElementById('visor-type').innerHTML}">`;
    document.getElementById('made-in').innerHTML = `<input type="text" value="${document.getElementById('made-in').innerHTML}">`;
    document.getElementById('condition-value').innerHTML = `<input type="text" value="${document.getElementById('condition-value').innerHTML}">`;
    document.getElementById('warranty-value').innerHTML = `<input type="text" value="${document.getElementById('warranty-value').innerHTML}">`;
    document.getElementById('returns-value').innerHTML = `<input type="text" value="${document.getElementById('returns-value').innerHTML}">`;

    document.getElementById('edit-product-btn').style.display = 'none';
    document.getElementById('save-btn').style.display = 'inline-block';
});







