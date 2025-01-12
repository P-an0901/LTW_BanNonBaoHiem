<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix = "f" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Trang Khuyến Mãi</title>
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
  <link rel="stylesheet" href="css/style.css">
  <link rel="stylesheet" href="css/danhmuc.css">
  <link rel="stylesheet" href="css/header.css">
  <link rel="icon" href="images/HELMET.png">
</head>
<body>
<!-- Load header -->
<jsp:include page="html/header.jsp" />

<!-- Load modal -->
<jsp:include page="html/modal.jsp" />
<div class="breadcrumb-container">
  <ul class="breadcrumb">
    <li><a href="/">Trang chủ </a></li>
    <li><span>/</span></li>
    <li><a href="/danhmuc"></a></li>
    <li><span>/</span></li>
    <li><a href="#" class="active">Kết quả tìm kiếm cho "${query}"</a></li>
  </ul>
</div>
<div class="back-to-top active">
  <a href="#"><i class="fa-solid fa-arrow-up"></i></a>
</div>
<section id="promotions" class="container my-1">
  <h2 class="text-danger mb-4">Kết quả tìm kiếm</h2>
  <div class="tab-content" id="promotion-tabs-content">
    <div class="tab-pane fade show active" id="product" role="tabpanel" aria-labelledby="product-tab">
      <div class="product-row">
        <c:forEach var="proV" items="${listVariantSale}">
          <div class="product-item" data-has-discount="${proV.salePrice > 0 ? 'true' : 'false'}">
            <a href="${pageContext.request.contextPath}/detail?pvId=${proV.id}">
              <img src="${pageContext.request.contextPath}/${fn:escapeXml(proV.image)}" alt="${proV.name}" class="product-image">
            </a>
            <div class="select-size">
              <c:forEach var="productSize" items="${proV.listPSize}">
                <button class="size-button" data-value="${productSize.id}">
                    ${productSize.size.name}
                </button>
              </c:forEach>
            </div>
            <a href="${pageContext.request.contextPath}/detail?pvId=${proV.id}">
              <h3 class="product-name">${proV.name}</h3>

            </a>
            <div class="product-price-container">
              <p class="product-sale-price"><span><f:formatNumber value="${proV.salePrice}" pattern="#,###.###"/> đ</span></p>
              <p class="product-price"><span><f:formatNumber value="${proV.price}" pattern="#,###.###"/> đ</span></p>
            </div>
            <form action="${pageContext.request.contextPath}/add-cart" method="POST">
              <input type="hidden" name="productId" value="${proV.id}">
              <input type="hidden" name="price" value="${proV.salePrice}">
              <input type="hidden" name="sizeId" class="sizeId-${proV.id}">
              <input type="hidden" name="quantity" value="1" min="1">
              <button type="submit" class="buy-button" onclick="return validateF()">Thêm vào giỏ hàng</button>
            </form>
          </div>
        </c:forEach>
      </div>
    </div>
    <div class="pagination">
      <div id="page-numbers">
        <c:forEach var="i" begin="1" end="${totalPages}">
          <a href="${pageContext.request.contextPath}/khuyenmai?&page=${i}"
             class="${i == currentPage ? 'active' : ''}">${i}</a>
        </c:forEach>
      </div>
    </div>
  </div>
  </div>
</section>

<!-- Load footer -->
<jsp:include page="html/footer.jsp" />
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script src="js/index.js"></script>
<script src="js/modal.js"></script>
<script src="js/header.js"></script>
</body>
</html>
