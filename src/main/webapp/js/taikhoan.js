$(document).ready(function() {
    $('#edit-info-btn').click(function () {
        $('#editInfoModal').modal('show')
    });
    $('#change-password-btn').click(function () {
        $('#changePasswordModal').modal('show')
    });
    $('#delete-account-btn').click(function () {
        $('#deleteAccountModal').modal('show')
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