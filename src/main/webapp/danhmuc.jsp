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
    <!-- <title>Danh mục</title> -->
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
        <li><a href="${pageContext.request.contextPath}/">Trang chủ </a></li>
        <li><span>/</span></li>
        <li><a href="#" class="active"> Danh mục sản phẩm</a></li>
    </ul>
</div>
<div class="back-to-top active">
    <a href="#"><i class="fa-solid fa-arrow-up"></i></a>
</div>

    <div class="product-list">
        <div class="filter-container">
            <h3>Lọc sản phẩm</h3>
            <form action="${pageContext.request.contextPath}/danhmuc" method="GET">
                <div class="filter-menu">
                <div class="filter-item">
                    <label for="helmet-brand">Thương hiệu:</label>
                    <select id="helmet-brand" name="brand" class="filter-select">
                        <option value="all" ${param.brand == 'all' ? 'selected' : ''}>Tất cả</option>
                        <c:forEach var="brand" items="${brands}">
                            <option value="${brand.id}" ${param.brand != null && param.brand == brand.id.toString() ? 'selected' : ''}>${brand.name}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="filter-item">
                    <label for="helmet-type">Loại nón:</label>
                    <select id="helmet-type" name="category" class="filter-select">
                        <option value="all" ${param.category == 'all' ? 'selected' : ''}>Tất cả</option>
                        <c:forEach var="cate" items="${cates}">
                            <option value="${cate.id}" ${param.category != null && param.category == cate.id.toString() ? 'selected' : ''}>${cate.name}</option>
                        </c:forEach>
                    </select>
                </div>


                <div class="filter-item">
                <label>Kích thước:</label>
                <div class="filter-options">
                <c:forEach var="size" items="${sizes}">
                    <div class="size-checkbox">
                        <input type="checkbox" id="${size.id}" name="sizes" class="filter-checkbox" value="${size.id}">
                        <label for="${size.id}">${size.name}</label>
                    </div>
                </c:forEach>
                </div>
            </div>
                    <div class="filter-item">
                        <label for="price-select">Khoảng giá:</label>
                        <select id="price-select" name="price" class="filter-select">
                            <c:forEach var="entry" items="${priceMap}">
                                <option value="${entry.key}" ${param.price == entry.key ? 'selected' : ''}>${entry.value}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="filter-item">
                        <label for="filter-select">Lọc theo:</label>
                        <select id="filter-select" name="filter_type" class="filter-select">
                            <c:forEach var="entry" items="${filterMap}">
                                <option value="${entry.key}" ${param.filter_type == entry.key ? 'selected' : ''}>${entry.value}</option>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="filter-item">
                        <label>Màu sắc:</label>
                        <div class="filter-colors" name="colors">
                            <c:forEach var="entry" items="${colorMap}">
                                <label for="color-${entry.key}" style="color: ${entry.key == 'white' || entry.key == 'yellow' ? 'black' : entry.key};">
                                    <input type="checkbox" id="color-${entry.key}" name="colors" value="${entry.value}"> ${entry.value}
                                </label>
                            </c:forEach>
                        </div>
                    </div>
                </div>
            <button id="filter-btn" class="btn">Áp dụng lọc</button>
            </form>
        </div>

        <div class="container">
            <div class="pro-lst" id="prolst">
                <div class="lst-title p-4">
                    <h3 id="product-list-title">
                        <c:choose>
                            <c:when test="${param.category eq 'all'}">
                                Tất cả sản phẩm
                            </c:when>
                            <c:when test="${not empty param.category}">
                                ${cates[param.category -1].name}
                            </c:when>
                            <c:otherwise>
                                Tất cả sản phẩm
                            </c:otherwise>
                        </c:choose>
                    </h3>
                </div>
                <div class="product-row" id="danhmuc-pro">
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
                            <p class="product-price">Giá: <f:formatNumber value="${proV.price}"/> đ</p>
                            <form action="${pageContext.request.contextPath}/add-cart" method="POST">
                                <input type="hidden" name="productId" value="${proV.id}">
                                <input type="hidden" name="price" value="${proV.price}">
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
                        <c:url var="newUrl" value="/danhmuc?">
                            <c:forEach var="paramName" items="${pageContext.request.parameterMap}">
                                <c:if test="${paramName.key != 'page'}">
                                    <c:param name="${paramName.key}" value="${paramName.value[0]}" />
                                </c:if>
                            </c:forEach>
                            <c:param name="page" value="${i}" />
                        </c:url>
                        <a href="${newUrl}" class="${i == currentPage ? 'active' : ''}">
                                ${i}
                        </a>
                    </c:forEach>
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
    <script src="js/danhmuc.js"></script>
</body>
</html>
