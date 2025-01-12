<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix = "f" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="stylesheet" href="./css/style.css">
    <link rel="stylesheet" href="./css/header.css">
    <title>Cửa hàng Mũ Bảo Hiểm</title>
    <link rel="icon" href="images/HELMET.png">

</head>
<body>
<!-- Load header -->
<jsp:include page="html/header.jsp" />

<!-- Load modal -->
<jsp:include page="html/modal.jsp" />


    <div class="back-to-top active">
        <a href="#"><i class="fa-solid fa-arrow-up"></i></a>
    </div>
    <div class="pixfort_pix_slider pix_builder_bg" id="section_slider">
        <div class="container-fluid">
            <div class="sixteen columns">
                <div id="myCarousel" class="carousel slide" data-ride="carousel" data-interval="3000">
                    <ol class="carousel-indicators">
                        <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
                        <li data-target="#myCarousel" data-slide-to="1"></li>
                    </ol>
                    <div class="carousel-inner">
                        <div class="carousel-item active">
                            <img src=" images/poster_2.png" alt="">
                        </div>
                        <div class="carousel-item">
                            <img src=" images/poster.png" alt="">
                        </div>
                    </div>
                    <a class="carousel-control-prev" href="#myCarousel" role="button" data-slide="prev">
                        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                        <span class="sr-only">Previous</span>
                    </a>
                    <a class="carousel-control-next" href="#myCarousel" role="button" data-slide="next">
                        <span class="carousel-control-next-icon" aria-hidden="true"></span>
                        <span class="sr-only">Next</span>
                    </a>
                </div>
            </div>
        </div>
    </div>
        <div class="slider">
            <div class="container">
                <div class="slider-wrapper">
                    <c:forEach var="category" items="${cates}">
                        <div class="slider-item">
                            <a href="./danhmuc?category=${category.id}">
                                <div class="image-container">
                                    <img src="${category.image}" alt="${category.name}">
                                </div>
                                <h5>${category.name}</h5>
                            </a>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>
        
    <div class="product-list">
        <div class="container">
            <div class="pro-lst" id="proSale">
                <div class="lst-title p-4">
                    <h3>Khuyến Mãi %</h3>
                </div>
                <div class="product-row">
                    <c:forEach var="proV" items="${limitedProSale}">
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
                                <c:choose>
                                    <c:when test="${not empty proV.salePrice}">
                                        <p class="product-sale-price">
                                            <span><f:formatNumber value="${proV.salePrice}" pattern="#,###.###"/> đ</span>
                                        </p>
                                        <p class="product-price">
                                            <span><f:formatNumber value="${proV.price}" pattern="#,###.###"/> đ</span>
                                        </p>
                                    </c:when>
                                    <c:otherwise>
                                        <p class="product-price">
                                            <span><f:formatNumber value="${proV.price}" pattern="#,###.###"/> đ</span>
                                        </p>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <form action="${pageContext.request.contextPath}/add-cart" method="POST">
                                <input type="hidden" name="productId" value="${proV.id}">
                                <input type="hidden" name="price" value="${proV.sale ? proV.salePrice : proV.price}">
                                <input type="hidden" name="sizeId" class="sizeId-${proV.id}">
                                <input type="hidden" name="quantity" value="1" min="1">
                                <button type="submit" class="buy-button" onclick="return validateF()">Thêm vào giỏ hàng</button>
                            </form>
                        </div>
                    </c:forEach>
                </div>
                <div class="xem-them p-3 d-flex justify-content-end">
                    <a href="./khuyenmai" class="btn-xem-them d-flex align-items-center justify-content-between">
                        <span>Xem thêm</span>
                        <i class="fas fa-chevron-right"></i>
                    </a>
                </div>
            </div>
            <div class="pro-lst" id="proNew">
                <div class="lst-title p-4">
                    <h3>Sản Phẩm Mới</h3>
                </div>
                <div class="product-row">
                    <c:forEach var="proV" items="${proVariants}">
                        <div class="product-item">
                            <c:if test="${proV.newProV}">
                                <div class="product-new-label">Mới</div>
                            </c:if>
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
                            <c:choose>
                                <c:when test="${proV.sale == true}">
                                    <p class="product-sale-price">
                                        <span><f:formatNumber value="${proV.salePrice}" pattern="#,###.###"/> đ</span>
                                    </p>
                                    <p class="product-price">
                                        <span><f:formatNumber value="${proV.price}" pattern="#,###.###"/> đ</span>
                                    </p>
                                </c:when>
                                <c:otherwise>
                                    <p class="product-price"><f:formatNumber value="${proV.price}" pattern="#,###.###"/> đ</p>
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <form action="${pageContext.request.contextPath}/add-cart" method="POST">
                            <input type="hidden" name="productId" value="${proV.id}">
                            <input type="hidden" name="price" value="${proV.sale ? proV.salePrice : proV.price}">
                            <input type="hidden" name="sizeId" class="sizeId-${proV.id}">
                            <input type="hidden" name="quantity" value="1" min="1">
                            <button type="submit" class="buy-button" onclick="return validateF()">Thêm vào giỏ hàng</button>
                        </form>
                        </div>
                    </c:forEach>
                </div>
                    <div class="xem-them p-3 d-flex justify-content-end">
                        <a href="./danhmuc?filter_type=new" class="btn-xem-them d-flex align-items-center justify-content-between">
                            <span>Xem thêm</span>
                            <i class="fas fa-chevron-right"></i>
                        </a>
                    </div>
                </div>
            <div class="pro-lst" id="pro-most-sell">
                <div class="lst-title p-4">
                    <h3>Mua Nhiều</h3>
                </div>
                <div class="product-row">
                    <c:forEach var="proV" items="${proVariants}">
                    <div class="product-item">
                        <div class="product-hot-label">Mua nhiều</div> 
                        <a href="${pageContext.request.contextPath}/detail?pvId=${proV.id}">
                            <img src="${pageContext.request.contextPath}/${fn:escapeXml(proV.image)}" alt="${proV.name}" class="product-image">
                        </a>
                        <div class="select-size">
                            <c:forEach var="productSize" items="${proV.listPSize}">
                                <button class="size-button" data-value="${productSize.size.id}">
                                        ${productSize.size.name}
                                </button>
                            </c:forEach>
                        </div> 
                        <a href="${pageContext.request.contextPath}/detail?pvId=${proV.id}">
                            <h3 class="product-name">${proV.name}</h3>
                        </a>
                        <div class="product-price-container">
                            <c:choose>
                                <c:when test="${proV.sale == true}">
                                    <p class="product-sale-price">
                                        <span><f:formatNumber value="${proV.salePrice}" pattern="#,###.###"/> đ</span>
                                    </p>
                                    <p class="product-price">
                                        <span><f:formatNumber value="${proV.price}" pattern="#,###.###"/> đ</span>
                                    </p>
                                </c:when>
                                <c:otherwise>
                                    <p class="product-price"><f:formatNumber value="${proV.price}" pattern="#,###.###"/> đ</p>
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <form action="${pageContext.request.contextPath}/add-cart" method="POST">
                            <input type="hidden" name="productId" value="${proV.id}">
                            <input type="hidden" name="price" value="${proV.sale ? proV.salePrice : proV.price}">
                            <input type="hidden" name="sizeId" class="sizeId-${proV.id}">
                            <input type="hidden" name="quantity" value="1" min="1">
                            <button type="submit" class="buy-button" onclick="return validateF()">Thêm vào giỏ hàng</button>
                        </form>
                    </div>
                    </c:forEach>
                </div>
                <div class="xem-them p-3 d-flex justify-content-end">
                    <a href="#" class="btn-xem-them d-flex align-items-center justify-content-between">
                        <span>Xem thêm</span>
                        <i class="fas fa-chevron-right"></i>
                    </a>
                </div>
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
</body>
</html>
