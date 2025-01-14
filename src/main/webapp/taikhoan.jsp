<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix = "f" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.13.5/css/jquery.dataTables.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="stylesheet" href=" css/style.css">
    <link rel="stylesheet" href="css/header.css">
    <link rel="stylesheet" href=" css/danhmuc.css">
    <link rel="stylesheet" href=" css/taikhoan.css">
    <link rel="icon" href="images/HELMET.png">
    <title>Thông tin tài khoản</title>
</head>
<body>
<!-- Header -->
<!-- Load header -->
<jsp:include page="html/header.jsp" />

<!-- Load modal -->
<jsp:include page="html/modal.jsp" />
<div class="breadcrumb-container">
    <ul class="breadcrumb">
      <li><a href="${pageContext.request.contextPath}/">Trang chủ </a></li>
      <li><span>/</span></li>
      <li><a href="#" class="active">Tài khoản</a></li>
    </ul>
</div>
<div class="back-to-top active">
    <a href="#"><i class="fa-solid fa-arrow-up"></i></a>
</div>
<div class="container" id="container-user">

    <!-- Thông tin và thao tác với tài khoản -->
    <div class="card mb-4">
        <div class="card-header bg-primary text-white">
            <h4>Thông tin tài khoản</h4>
        </div>
        <div class="card-body">
            <div class="d-flex align-items-center">
                <c:choose>
                    <c:when test="${empty sessionScope.auth.image}">
                        <img src="${pageContext.request.contextPath}/images/default-avatar.jpg" alt="Avatar" class="avatar-img me-3" />
                    </c:when>
                    <c:otherwise>
                        <img src="${pageContext.request.contextPath}/${fn:escapeXml(sessionScope.auth.image)}" alt="Avatar" class="avatar-img me-3" />
                    </c:otherwise>
                </c:choose>

                <div>
                    <p><strong>Họ và tên:</strong> <span id="account-fullname">${sessionScope.auth.fullName}</span></p>
                    <p><strong>Tên đăng nhập:</strong> <span id="account-username">${sessionScope.auth.username}</span></p>
                    <p><strong>Email:</strong> <span id="account-email">${sessionScope.auth.email}</span></p>
                    <p><strong>Số điện thoại:</strong> <span id="account-phone">${sessionScope.auth.phone}</span></p>
                    <p><strong>Địa chỉ:</strong> <span id="account-address">${sessionScope.auth.address}</span></p>
                </div>
            </div>
            
            <!-- Thao tác với tài khoản -->
            <div class="d-flex justify-content-between flex-column flex-sm-row">
                <div class="mb-3">
                    <button class="btn mb-2" id="edit-info-btn" data-bs-toggle="modal" data-bs-target="#editInfoModal">
                        <i class="fas fa-edit"></i> Chỉnh sửa thông tin
                    </button>
                    <button class="btn mb-2" id="change-password-btn" data-bs-toggle="modal" data-bs-target="#changePasswordModal">
                        <i class="fas fa-key"></i> Đổi mật khẩu
                    </button>
                </div>
                <button class="btn mt-2 mt-sm-0" id="delete-account-btn" data-bs-toggle="modal" data-bs-target="#deleteAccountModal">
                    <i class="fas fa-trash-alt"></i> Xóa tài khoản
                </button>
            </div>
        </div>
    </div>

    <!-- Lịch sử đơn hàng -->
    <div class="card">
        <div class="card-header bg-success text-white">
            <h4>Đơn hàng hiện tại</h4>
        </div>
        <div class="card-body">
            <table class="table table-bordered">
                <thead>
                    <tr>
                        <th></th>
                        <th>Mã đơn</th>
                        <th>Tên người nhận</th>
                        <th>Tổng tiền</th>
                        <th>Phương thức thanh toán</th>
                        <th>Địa chỉ</th>
                        <th>Ngày giao dự kiến</th>
                        <th>Trạng thái</th>
                        <th>Hủy</th>
                        <th>Chi tiết</th>
                    </tr>
                </thead>
                <tbody>
                <c:forEach var="order" items="${currentOrders}" varStatus="status">
                    <tr>
                        <td>${status.index + 1}</td>
                        <td>#${order.id}</td>
                        <td>${order.recipientName}</td>
                        <td>${order.totalAmount}</td>
                        <td>${order.paymentMethod.name}</td>
                        <td>${order.shippingAddress}</td>
                        <td>${order.estimatedDelivery}</td>
                        <td>${order.status}</td>
                        <td>
                            <button class="btn btn-info">Hủy</button>
                        </td>
                        <td><button class="detail-btn" id="btn-detail-order" data-order-id="${order.id}"> <i class="fa-solid fa-pen"></i></button></td>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
    <div class="card mt-4">
        <div class="card-header bg-primary text-white">
            <h4>Lịch sử đơn hàng</h4>
        </div>
        <div class="card-body">
            <table class="table table-bordered" id="order-history">
                <thead>
                    <tr>
                        <th>Mã đơn</th>
                        <th>Tên người nhận</th>
                        <th>Tổng tiền</th>
                        <th>Phương thức thanh toán</th>
                        <th>Địa chỉ</th>
                        <th>Trạng thái</th>
                        <th>Ngày giao</th>
                        <th>Thao tác</th>
                    </tr>
                </thead>
                <tbody>
                <c:forEach var="order" items="${orderHistory}">
                    <tr>
                        <td>#${order.id}</td>
                        <td>${order.user.fullName}</td>
                        <td>${order.totalAmount}</td>
                        <td>${order.paymentMethod.name}</td>
                        <td>${order.shippingAddress}</td>
                        <td>${order.status}</td>
                        <td>${order.deliveryDate}</td>
                        <td>
                        <td><button class="detail-btn" id="btn-detail-orders" data-order-id="${order.id}"> <i class="fa-solid fa-pen"></i></button></td>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
            <button id="load-more" class="btn btn-primary btn-sm">Xem thêm</button>
            <button id="hide-extra" class="btn btn-secondary btn-sm" style="display: none;">Ẩn bớt</button>
        </div>
        <div class="card-header bg-danger text-white">
            <h4>Đơn hàng đã hủy</h4>
        </div>
        <div class="card-body">
            <table class="table table-bordered">
                <thead>
                <tr>
                    <th>Mã đơn</th>
                    <th>Sản phẩm</th>
                    <th>Tổng tiền</th>
                    <th>Phương thức thanh toán</th>
                    <th>Địa chỉ</th>
                    <th>Ngày hủy</th>
                    <th>Lý do hủy</th>
                </tr>
                </thead>
                <tbody>

                </tbody>
            </table>
        </div>
    </div>
</div>
<!-- Modal Chỉnh sửa thông tin -->
<div class="modal fade" id="editInfoModal" tabindex="-1" aria-labelledby="editInfoModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span>&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <h2 class="modal-title">Chỉnh sửa thông tin</h2>
                <form id="edit-info-form" action="${pageContext.request.contextPath}/account" method="POST" enctype="multipart/form-data">
                    <input type="hidden" name="action" value="updateInfoUser">
                    <div class="mb-3">
                        <label for="username-tk" class="form-label">Tên đăng nhập</label>
                        <input type="text" class="form-control" id="username-tk" name="username"
                               value="${sessionScope.auth.username}" readonly>
                    </div>
                    <div class="mb-3">
                        <label for="image-tk" class="form-label">Hình ảnh</label>
                        <div>
                            <img src="${empty sessionScope.auth.image ? './images/default-avatar.jpg' : sessionScope.auth.image}" alt="Hình ảnh người dùng" style="max-width: 150px; max-height: 150px;">
                        </div>
                        <input type="file" class="form-control" id="image-tk" name="image">
                    </div>
                    <div class="mb-3">
                        <label for="fullName-tk" class="form-label">Tên người dùng</label>
                        <input type="text" class="form-control" id="fullName-tk" name="fullName"
                               value="${sessionScope.auth.fullName}" required>
                    </div>
                    <div class="mb-3">
                        <label for="birthday-tk" class="form-label">Ngày sinh</label>
                        <input type="date" class="form-control" id="birthday-tk" name="birthday"
                               value="${sessionScope.auth.birthday}">
                    </div>
                    <div class="mb-3">
                        <label for="email-tk" class="form-label">Email</label>
                        <input type="email" class="form-control" id="email-tk" name="email"
                               value="${sessionScope.auth.email}">
                    </div>
                    <div class="mb-3">
                        <label for="address-tk" class="form-label">Địa chỉ</label>
                        <input type="text" class="form-control" id="address-tk" name="address"
                               value="${sessionScope.auth.address}">
                    </div>
                    <div class="mb-3">
                        <label for="phone-tk" class="form-label">Số điện thoại</label>
                        <input type="text" class="form-control" id="phone-tk" name="phone"
                               value="${sessionScope.auth.phone}">
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                <button type="submit" class="btn btn-primary" form="edit-info-form">Lưu thay đổi</button>
            </div>
        </div>
    </div>
</div>

<!-- Modal Đổi mật khẩu -->
<div class="modal fade" id="changePasswordModal" tabindex="-1" aria-labelledby="changePasswordModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span>&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <h2 class="modal-title">Đổi mật khẩu</h2>
                <form id="change-password-form">
                    <div class="mb-3">
                        <label for="old-password" class="form-label">Mật khẩu cũ</label>
                        <input type="password" class="form-control" id="old-password" name="old-password" required>
                    </div>
                    <div class="mb-3">
                        <label for="new-password" class="form-label">Mật khẩu mới</label>
                        <input type="password" class="form-control" id="new-password" name="new-password" required>
                    </div>
                    <div class="mb-3">
                        <label for="confirm-password" class="form-label">Xác nhận mật khẩu mới</label>
                        <input type="password" class="form-control" id="confirm-password" name="confirm-password" required>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                <button type="submit" class="btn btn-primary" form="change-password-form">Đổi mật khẩu</button>
            </div>
        </div>
    </div>
</div>

<!-- Modal Xóa tài khoản -->
<div class="modal fade" id="deleteAccountModal" tabindex="-1" aria-labelledby="deleteAccountModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span>&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <h2 class="modal-title">Xóa tài khoản</h2>
                Bạn có chắc chắn muốn xóa tài khoản của mình không? Việc này không thể hoàn tác.
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                <button type="button" class="btn btn-danger" id="confirm-delete-btn">Xóa tài khoản</button>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="detailOrderModal" tabindex="-1" aria-labelledby="detailOrderModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <h2 class="form-title">Chi tiết đơn hàng</h2>
                <p><strong>Họ và tên:</strong> <span id="modal-full-name"></span></p>
                <p><strong>Địa chỉ:</strong> <span id="modal-address"></span></p>
                <p><strong>Số điện thoại:</strong> <span id="modal-phone"></span></p>
                <p><strong>Ghi chú:</strong> <span id="modal-note"></span></p>
                <p><strong>Ngày giao dự kiến: </strong><span id="delivery-date"></span></p>
                <table class="table table-bordered">
                    <thead>
                    <tr>
                        <th></th>
                        <th>Tên sản phẩm</th>
                        <th>Kích cỡ</th>
                        <th>Số lượng</th>
                        <th>Giá</th>
                    </tr>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
                <h6  ><strong>Tổng cộng:</strong><strong><span  id="modal-totalAmount"></span> Đ</strong></h6>
                <h6><strong>Phương thức thanh toán: </strong><span id="modal-payment-method"></span></h6>
            </div>
        </div>
    </div>
</div>
<!-- Load footer -->
<jsp:include page="html/footer.jsp" />
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script src="js/index.js"></script>
<script src="js/modal.js"></script>
<script src="js/header.js"></script>
<script src="js/taikhoan.js"></script>
</body>
</html>
