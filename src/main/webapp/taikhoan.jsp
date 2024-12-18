<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
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
      <li><a href="index.jsp">Trang chủ </a></li>
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
            <!-- Thông tin cá nhân và ảnh -->
            <div class="d-flex align-items-center">
                <!-- Ảnh người dùng -->
                <img src="images/Royal M139 Cờ VN.jpg" alt="Avatar" class="avatar-img me-3" />
                
                <!-- Thông tin cá nhân -->
                <div>
                    <p><strong>Họ và tên:</strong> <span id="account-fullname"></span></p>
                    <p><strong>Email:</strong> <span id="account-email"></span></p>
                    <p><strong>Số điện thoại:</strong> <span id="account-phone"></span></p>
                    <p><strong>Địa chỉ:</strong> <span id="account-address"></span></p>
                </div>
            </div>
            
            <!-- Thao tác với tài khoản -->
            <div class="d-flex justify-content-between flex-column flex-sm-row">
                <div class="mb-3">
                    <button class="btn mb-2" id="edit-info-btn">
                        <i class="fas fa-edit"></i> Chỉnh sửa thông tin
                    </button>
                    <button class="btn mb-2" id="change-password-btn">
                        <i class="fas fa-key"></i> Đổi mật khẩu
                    </button>
                </div>
                <button class="btn mt-2 mt-sm-0" id="delete-account-btn">
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
                        <th>Mã đơn</th>
                        <th>Sản phẩm</th>
                        <th>Tổng tiền</th>
                        <th>Phương thức thanh toán</th>
                        <th>Địa chỉ</th>
                        <th>Ngày giao dự kiến</th>
                        <th>Trạng thái</th>
                        <th>Thao tác</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>#12345</td>
                        <td>
                            <ul>
                                <li>Nón bảo hiểm 3/4 - Đen nhám (Số lượng: 1)</li>
                                <li>Nón bảo hiểm fullface - Xanh dương (Số lượng: 1)</li>
                            </ul>
                        </td>
                        <td>500.000 VNĐ</td>
                        <td>Chuyển khoản ngân hàng</td>
                        <td>123 Đường ABC, Quận 1, TP.HCM</td>
                        <td>Chưa rõ</td>
                        <td>Đang xử lý</td>
                        <td>
                            <button class="btn btn-sm " style="width: 80px;" onclick="toggleDetails(this)">Chi tiết</button>
                            <button class="btn btn-danger btn-sm" style="width: 80px;">Hủy đơn</button>
                        </td>
                    </tr>
                    <tr id="order-details-1" class="order-details">
                        <td colspan="8">
                            <div class="order-detail-container">
                                <h5>Chi tiết đơn hàng #12345</h5>
                                <div class="order-detail-content">
                                    <p><strong>Sản phẩm:</strong></p>
                                    <ul>
                                        <li>Nón bảo hiểm 3/4 - Đen nhám (Số lượng: 1)</li>
                                        <li>Nón bảo hiểm fullface - Xanh dương (Số lượng: 1)</li>
                                    </ul>
                                    <p><strong>Phương thức thanh toán:</strong> Chuyển khoản ngân hàng</p>
                                    <p><strong>Địa chỉ giao hàng:</strong> 123 Đường ABC, Quận 1, TP.HCM</p>
                                    <p><strong>Số điện thoại:</strong> 0901234567</p>
                                    <p><strong>Trạng thái:</strong> Đang xử lý</p>
                                </div>
                                <div class="order-detail-actions">
                                    <button class="btn btn-warning btn-sm">Chỉnh sửa</button>
                                </div>
                            </div>
                        </td>
                    </tr>                    
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
                        <th>Sản phẩm</th>
                        <th>Tổng tiền</th>
                        <th>Phương thức thanh toán</th>
                        <th>Địa chỉ</th>
                        <th>Ngày giao</th>
                        <th>Trạng thái</th>
                        <th>Thao tác</th>
                    </tr>
                </thead>
                <tbody>
                    <tr class="extra-order">
                        <td>#12344</td>
                        <td>
                            <ul>
                                <li>Nón bảo hiểm 3/4 - Đen bóng (Số lượng: 1)</li>
                            </ul>
                        </td>
                        <td>450.000 VNĐ</td>
                        <td>Tiền mặt</td>
                        <td>123 Đường XYZ, Quận 3, TP.HCM</td>
                        <td>10-11-2024</td>
                        <td>Đã giao</td>
                        <td>
                            <button class="btn btn-info btn-sm" style="width: 80px;">Chi tiết</button>
                        </td>
                    </tr>
                    <tr class="extra-order">
                        <td>#12343</td>
                        <td>
                            <ul>
                                <li>Nón bảo hiểm 3/4 - Đen bóng (Số lượng: 1)</li>
                            </ul>
                        </td>
                        <td>450.000 VNĐ</td>
                        <td>Tiền mặt</td>
                        <td>123 Đường XYZ, Quận 3, TP.HCM</td>
                        <td>10-11-2024</td>
                        <td>Đã giao</td>
                        <td>
                            <button class="btn btn-info btn-sm" style="width: 80px;">Chi tiết</button>
                        </td>
                    </tr>
                    <tr class="extra-order">
                        <td>#12342</td>
                        <td>
                            <ul>
                                <li>Nón bảo hiểm 3/4 - Đen bóng (Số lượng: 1)</li>
                            </ul>
                        </td>
                        <td>450.000 VNĐ</td>
                        <td>Tiền mặt</td>
                        <td>123 Đường XYZ, Quận 2, TP.HCM</td>
                        <td>10-11-2024</td>
                        <td>Đã giao</td>
                        <td>
                            <button class="btn btn-info btn-sm" style="width: 80px;">Chi tiết</button>
                        </td>
                    </tr>
                    <tr class="extra-order">
                        <td>#12341</td>
                        <td>
                            <ul>
                                <li>Nón bảo hiểm 3/4 - Đen bóng (Số lượng: 1)</li>
                            </ul>
                        </td>
                        <td>450.000 VNĐ</td>
                        <td>Tiền mặt</td>
                        <td>123 Đường XYZ, Quận 1, TP.HCM</td>
                        <td>10-11-2024</td>
                        <td>Đã giao</td>
                        <td>
                            <button class="btn btn-info btn-sm" style="width: 80px;">Chi tiết</button>
                        </td>
                    </tr>


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
                <tr>
                    <td>#12346</td>
                    <td>
                        <ul>
                            <li>Nón bảo hiểm 3/4 - Đỏ đô (Số lượng: 1)</li>
                        </ul>
                    </td>
                    <td>300.000 VNĐ</td>
                    <td>Chuyển khoản ngân hàng</td>
                    <td>456 Đường DEF, Quận 2, TP.HCM</td>
                    <td>25-11-2024</td>
                    <td>Khách thay đổi ý định</td>
                </tr>
                <tr>
                    <td>#12347</td>
                    <td>
                        <ul>
                            <li>Nón bảo hiểm fullface - Đen nhám (Số lượng: 2)</li>
                        </ul>
                    </td>
                    <td>1.200.000 VNĐ</td>
                    <td>Tiền mặt</td>
                    <td>789 Đường GHI, Quận 4, TP.HCM</td>
                    <td>30-11-2024</td>
                    <td>Không thể giao hàng</td>
                </tr>
                </tbody>
            </table>
        </div>
    </div>
</div>
<!-- Load footer -->
<jsp:include page="html/footer.jsp" />
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script src="js/index.js"></script>
<script src="js/modal.js"></script>
<script src="js/header.js"></script>
<script src="js/taikhoan.js"></script>
</body>
</html>
