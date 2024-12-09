<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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
    <link rel="icon" href="images/HELMET.png">
    <title>Thanh toán</title>
  </head>
  <body>
  <!-- Load header -->
  <jsp:include page="html/header.jsp" />

  <!-- Load modal -->
  <jsp:include page="html/modal.jsp" />
      <div class="back-to-top active">
          <a href="#"><i class="fa-solid fa-arrow-up"></i></a>
      </div>
  <div class="checkout-container">
    <h3>Thông tin thanh toán</h3>
    <div class="checkout-page">
      <!-- Thông tin Khách hàng -->
      <div class="billing-info">
        <h5>Thông tin người nhận</h5>
        <form id="checkout-form">
          <div class="form-group">
            <label for="full-name">Họ và tên</label>
            <input type="text" id="full-name" name="full-name" class="form-control" required>
          </div>
          <div class="form-group">
            <label>Email</label>
            <input type="email" name="email" class="form-control" required>
          </div>
          <div class="form-group">
            <label for="address">Địa chỉ</label>
            <input type="text" id="address" name="address" class="form-control" required>
          </div>
          <div class="form-group">
            <label for="phone">Số điện thoại</label>
            <input type="text" id="phone" name="phone" class="form-control" required>
          </div>
        </form>
      </div>

      <!-- Tóm tắt Đơn hàng -->
      <div class="order-summary">
        <h5>Tóm tắt đơn hàng</h5>
        <ul id="order-items">
          <!-- Các sản phẩm trong đơn hàng sẽ được hiển thị ở đây -->
        </ul>
        <p>Tổng cộng: <span id="order-total">0 đ</span></p>
      </div>

      <!-- Phương thức Thanh toán -->
      <div class="payment-info">
        <h5>Phương thức thanh toán</h5>
        <div class="form-group">
          <button class="btn btn-primary" id="cash-payment">Thanh toán tiền mặt</button>
          <button class="btn btn-primary" id="card-payment">Thanh toán bằng thẻ</button>
          <button class="btn btn-primary" id="e-wallet-payment">Thanh toán qua ví điện tử</button>
        </div>
          <!-- Form thanh toán ví điện tử -->
          <form id="e-wallet-payment-form" style="display: none;">
              <h6>Chọn ví điện tử để thanh toán</h6>
              <div class="form-group">
                  <label for="momo-payment">Momo</label>
                  <input type="radio" id="momo-payment" name="e-wallet" value="momo">
                  <img id="momo-image" src="images/momo.jpg" alt="QR Momo" class="qr-code-img" style="display: none;">
              </div>
              <div class="form-group">
                  <label for="zalopay-payment">ZaloPay</label>
                  <input type="radio" id="zalopay-payment" name="e-wallet" value="zalopay">
                  <img id="zalopay-image" src="zalopay-qr.png" alt="QR ZaloPay" class="qr-code-img" style="display: none;">
              </div>
              <div class="form-group">
                  <label for="viettel-money-payment">Viettel Money</label>
                  <input type="radio" id="viettel-money-payment" name="e-wallet" value="viettel-money">
                  <img id="viettel-money-image" src="viettel-money-qr.png" alt="QR Viettel Money" class="qr-code-img" style="display: none;">
              </div>
              <div class="form-group">
                  <label for="vnpay-payment">VNPay</label>
                  <input type="radio" id="vnpay-payment" name="e-wallet" value="vnpay">
                  <img id="vnpay-image" src="vnpay-qr.png" alt="QR VNPay" class="qr-code-img" style="display: none;">
              </div>
          </form>

          <form id="card-payment-form" style="display: none;">
          <div class="form-group">
            <label for="card-name">Tên trên thẻ</label>
            <input type="text" id="card-name" name="card-name" class="form-control">
          </div>
          <div class="form-group">
            <label for="card-number">Số thẻ</label>
            <input type="text" id="card-number" name="card-number" class="form-control">
          </div>
          <div class="form-group">
            <label for="expiry-date">Ngày hết hạn</label>
            <input type="text" id="expiry-date" name="expiry-date" class="form-control" placeholder="MM/YY">
          </div>
          <div class="form-group">
            <label for="cvv">CVV</label>
            <input type="text" id="cvv" name="cvv" class="form-control">
          </div>
        </form>
      </div>

      <!-- Nút Thanh toán -->
      <button id="place-order-btn" class="btn btn-success">Đặt hàng</button>
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
