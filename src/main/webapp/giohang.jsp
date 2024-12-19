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
  <link rel="stylesheet" href="./css/style.css">
  <link rel="stylesheet" href="./css/danhmuc.css">
  <link rel="stylesheet" href="./css/header.css">
  <link rel="icon" href="images/HELMET.png">
  <title>Giỏ hàng</title>
</head>
<body>

<!-- Load header -->
<jsp:include page="html/header.jsp" />

<!-- Load modal -->
<jsp:include page="html/modal.jsp" />

<div class="back-to-top active">
    <a href="#"><i class="fa-solid fa-arrow-up"></i></a>
</div>
<div class="breadcrumb-container">
  <ul class="breadcrumb">
    <li><a href="index.jsp">Trang chủ </a></li>
       <li><span>/</span></li>
    <li><a href="#" class="active"> Giỏ hàng</a></li>
  </ul>
</div>
<div class="back-to-top active">
  <a href="#"><i class="fa-solid fa-arrow-up"></i></a>
</div>
<div class="container" style="background-color: #fff;">
  <h3>Giỏ hàng của bạn</h3>
  <div class="cart-page">
    <div id="cart-container">
      <ul id="cart2-items">
        <c:forEach var="item" items="${cartItems}">
          <li class="cart-item">
            <img src="${pageContext.request.contextPath}/${fn:escapeXml(item.image)}" alt="${item.name}" class="cart-item-img" />
            <span class="cart-item-name">${item.name}</span>
            <span class="cart-item-size">Size: ${item.size}</span>
            <span class="ms-3">Số lượng: </span>
            <span class="cart-item-quantity">
              <input type="number" id="quantity-${item.id}" class="form-control text-center" value="${item.quantity}" min="1" step="1" style="width: 80px;">
            </span>
            <span class="cart-item-price">${item.price} đ</span>
          </li>
        </c:forEach>

      </ul>
      <div id="empty-message" class="empty-message">
        <i class="fas fa-shopping-bag"></i>
        Không có sản phẩm nào trong giỏ hàng.
      </div>
      <div class="cart-summary">
        <p>Tổng cộng: <span id="cart-total" >0 đ</span></p>
        <button id="checkout-btn" class="btn btn-primary" onclick="redirectToCheckout()">Thanh toán</button>

      </div>
    </div>
  </div>
</div>

<jsp:include page="html/footer.jsp" />
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script src="js/index.js"></script>
<script src="js/modal.js"></script>
<script src="js/header.js"></script>
<script src="js/giohang.js"></script>
</body>
</html>
