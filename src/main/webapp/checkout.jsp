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
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/checkout.css">
    <link rel="stylesheet" href="css/header.css">
      <link rel="stylesheet" href="css/danhmuc.css">
    <link rel="icon" href="images/HELMET.png">
    <title>Thanh toán</title>
  </head>
  <body>
  <!-- Load header -->
  <jsp:include page="html/header.jsp" />

  <!-- Load modal -->
  <jsp:include page="html/modal.jsp" />
  <div class="breadcrumb-container">
      <ul class="breadcrumb">
          <li><a href="${pageContext.request.contextPath}/">Trang chủ </a></li>
          <li><span>/</span></li>
          <li><a href="#" class="active">Thanh toán</a></li>
      </ul>
  </div>
      <div class="back-to-top active">
          <a href="#"><i class="fa-solid fa-arrow-up"></i></a>
      </div>
  <div class="checkout-container">
      <h2>THANH TOÁN</h2>
      <div class="row">
          <!-- Bên trái: Thông tin người nhận -->
          <div class="col-md-6 billing-info">
              <h5 class="section-title">THÔNG TIN NGƯỜI NHẬN</h5>
              <form id="checkout-form">
                  <div class="form-group">
                      <label for="full-name">Họ và tên <span class="text-danger">*</span></label>
                      <input type="text" id="full-name" name="recipientName" class="form-control" required>
                      <div id="full-name-error" class="form-message" style="display: none;">Họ và tên là bắt buộc!</div>
                  </div>
                  <div class="form-group">
                      <label for="address">Địa chỉ <span class="text-danger">*</span></label>
                      <input type="text" id="address" name="address" class="form-control" required>
                      <div id="address-error" class="form-message" style="display: none;">Địa chỉ là bắt buộc!</div>
                  </div>
                  <div class="form-group">
                      <label for="phone">Số điện thoại <span class="text-danger">*</span></label>
                      <input type="text" id="phone" name="phone" class="form-control" required>
                      <div id="phone-error" class="form-message" style="display: none;">Số điện thoại là bắt buộc!</div>
                  </div>
                  <div class="form-group">
                      <label for="note">Ghi chú</label>
                      <textarea id="note" name="note" class="form-control" rows="4" placeholder="Nhập ghi chú của bạn"></textarea>
                  </div>
              </form>
          </div>

          <!-- Bên phải: Danh sách sản phẩm, phương thức thanh toán -->
          <div class="col-md-6 order-summary">
              <h5 class="section-title">ĐƠN HÀNG CỦA BẠN</h5>
              <div class="product-list">
                  <c:choose>
                      <c:when test="${not empty sessionScope.cart.list}">
                          <table class="table table-bordered">
                              <thead>
                              <tr>
                                  <th>Hình ảnh</th>
                                  <th>Tên sản phẩm</th>
                                  <th>Kích cỡ</th>
                                  <th>Số lượng</th>
                                  <th>Giá</th>
                              </tr>
                              </thead>
                              <tbody>
                              <c:forEach var="item" items="${sessionScope.cart.list}">
                                  <tr>
                                      <td><img src="${pageContext.request.contextPath}/${fn:escapeXml(item.image)}" alt="${item.name}" class="carts-item-img" /></td>
                                      <td>${item.name}</td>
                                      <td>${item.size.size.name}</td>
                                      <td>${item.quantity}</td>
                                      <td><span><f:formatNumber value="${item.price}" pattern="#,###.###"/> đ</span></td>
                                  </tr>
                              </c:forEach>
                              <!-- Tổng tiền -->
                              <tr class="cart-summary">
                                  <td colspan="4" class="text-right"><strong>Tổng cộng:</strong></td>
                                  <td><strong><f:formatNumber value="${sessionScope.cart.totalPrice} " pattern="#,###.###"/> đ</strong></td>
                              </tr>
                              </tbody>
                          </table>
                      </c:when>
                      <c:otherwise>
                          <div id="empty-message" class="empty-message">
                              <p>Không có sản phẩm nào.</p>
                          </div>
                      </c:otherwise>
                  </c:choose>
              </div>

              <div class="payment-methods">
                  <h5>Phương thức thanh toán</h5>
                  <div class="form-group">
                      <c:forEach var="payment" items="${payList}">
                          <div class="form-check">
                              <input type="radio" id="${payment.id}" name="payment-method" class="form-check-input" value="${payment.id}"
                                  ${payment.active == 0 ? 'disabled' : ''} />
                              <label class="form-check-label" for="${payment.id}">
                                      ${payment.name}
                              </label>
                              <small class="text-muted">${payment.active == 1 ? '' : 'Không hoạt động'}</small>
                          </div>
                      </c:forEach>
                  </div>
              </div>
              <input type="hidden" id="isLoggedIn" value="${not empty sessionScope.auth ? 'true' : 'false'}">
              <input type="hidden" id="isHaveCart" value="${not empty sessionScope.cart ? 'true' : 'false'}">
              <button id="place-order-btn" class="btn btn-success" data-toggle="modal" >Đặt hàng</button>
              <div id="payment-error" class="form-message" style="display: none;">Vui lòng chọn phương thức thanh toán!</div>
          </div>
      </div>
  </div>
  <!-- Modal for Order Confirmation -->
  <div class="modal fade" id="orderModal">
      <div class="modal-dialog modal-lg" role="document">
          <div class="modal-content">
              <div class="modal-header">
                  <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                      <span aria-hidden="true">&times;</span>
                  </button>
              </div>
              <div class="modal-body">
                  <h2 class="form-title">Kiểm Tra và Xác Nhận</h2>
                  <p class="form-description">Kiểm tra lại đơn hàng để của bạn và xác nhận thanh toán.</p>
                  <p><strong>Họ và tên:</strong> <span id="modal-full-name"></span></p>
                  <p><strong>Địa chỉ:</strong> <span id="modal-address"></span></p>
                  <p><strong>Số điện thoại:</strong> <span id="modal-phone"></span></p>
                  <p><strong>Ghi chú:</strong> <span id="modal-note"></span></p>
                  <p><strong>Ngày giao dự kiến: </strong><span id="delivery-date"></span></p>
                  <c:choose>
                      <c:when test="${not empty sessionScope.cart.list}">
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
                              <c:forEach var="item" items="${sessionScope.cart.list}">
                                  <tr>
                                      <td>${status.index + 1}</td>
                                      <td>${item.name}</td>
                                      <td>${item.size.size.name}</td>
                                      <td>${item.quantity}</td>
                                      <td><f:formatNumber value="${item.price} " pattern="#,###.###"/> đ</td>
                                  </tr>
                              </c:forEach>
                              </tbody>
                          </table>
                      </c:when>
                      <c:otherwise>
                          <div id="empty-message" class="empty-message">
                              <p>Không có sản phẩm nào.</p>
                          </div>
                      </c:otherwise>
                  </c:choose>
                  <c:choose>
                      <c:when test="${not empty sessionScope.cart.totalPrice}">
                          <h6><strong>Tổng cộng:</strong><strong><f:formatNumber value="${sessionScope.cart.totalPrice}" pattern="#,###.###"/> Đ</strong></h6>
                      </c:when>
                      <c:otherwise>
                          <h6><strong>Tổng cộng: 0 Đ</strong></h6>
                      </c:otherwise>
                  </c:choose>
                        <h6><strong>Phương thức thanh toán: </strong><span id="modal-payment-method"></span></h6>
              </div>
              <form action="${pageContext.request.contextPath}/thanh-toan" method="post" id="addOrderForm">
              <div class="modal-footer">
                  <input type="hidden" name="recipientName" id="hidden-recipient-name" value="" />
                  <input type="hidden" name="address" id="hidden-address" value="" />
                  <input type="hidden" name="phone" id="hidden-phone" value="" />
                  <input type="hidden" name="note" id="hidden-note" value="" />
                  <input type="hidden" name="paymentMethodId" id="hidden-payment-method" value="" />

                  <button type="button" class="btn btn-secondary" data-dismiss="modal">Đóng</button>
                  <button type="submit" class="btn btn-primary" id="confirm-order-btn">Xác nhận Đặt Hàng</button>
              </div>
              </form>
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
  <script src="js/checkout.js"></script>

  </body>
  </html>
