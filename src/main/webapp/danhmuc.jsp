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
        <li><a href="index.jsp">Trang chủ </a></li>
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
            <div class="filter-menu">
                <div class="filter-item">
                    <label for="helmet-brand">Thương hiệu:</label>
                    <select id="helmet-brand" class="filter-select">
                        <option value="all">Tất cả</option>
                        <c:forEach var="brand" items="${brands}">
                            <option value="${brand.id}">${brand.name}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="filter-item">
                    <label for="helmet-type">Loại nón:</label>
                    <select id="helmet-type" class="filter-select">
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
                        <input type="checkbox" id="${size.id}" class="filter-checkbox" value="${size.id}">
                        <label for="${size.id}">${size.name}</label>
                    </div>
                </c:forEach>
                </div>
            </div>
            <div class="filter-item">
                <label for="price-select">Khoảng giá:</label>
                <select id="price-select" class="filter-select">
                    <option value="all">Tất cả</option>
                    <option value="below500">Dưới 500.000 đ</option>
                    <option value="above500">Trên 500.000 đ</option>
                    <option value="above10000">Trên 1.000.000 đ</option>
                </select>
            </div>
            <div class="filter-item">
                <label for="purchase-time-select">Mua nhiều trong: </label>
                <select id="purchase-time-select" class="filter-select">
                    <option value="all">Tất cả thời gian</option>
                    <option value="this-month">1 tháng qua</option>
                    <option value="3-months">3 tháng qua</option>
                    <option value="6-months">6 tháng qua</option>
                    <option value="12-months">12 tháng qua</option>
                </select>
            </div>
        
        
            <div class="filter-item">
                <label>Màu sắc:</label>
                <div class="filter-colors">
                    <label for="color-red" style="color: red;">
                        <input type="checkbox" id="color-red" class="filter-color" value="red"> Đỏ
                    </label>
                    
                    <label for="color-blue" style="color: blue;">
                        <input type="checkbox" id="color-blue" class="filter-color" value="blue"> Xanh
                    </label>
                    
                    <label for="color-black" style="color: black;">
                        <input type="checkbox" id="color-black" class="filter-color" value="black"> Đen
                    </label>
                    
                    <label for="color-white">
                        <input type="checkbox" id="color-white" class="filter-color" value="white"> Trắng
                    </label>
                    
                    <label for="color-green" style="color: green;">
                        <input type="checkbox" id="color-green" class="filter-color" value="green"> Xanh lá
                    </label>
                    
                    <label for="color-yellow" style="color: #e68027;">
                        <input type="checkbox" id="color-yellow" class="filter-color" value="yellow"> Vàng
                    </label>
                    
                    <label for="color-gray" style="color: gray;">
                        <input type="checkbox" id="color-gray" class="filter-color" value="gray"> Xám
                    </label>                    
                </div>
            </div>
        </div>
            <button id="filter-btn" class="btn">Áp dụng lọc</button>
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
                            <a href="detail.jsp">
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
<%--                    <div class="product-item" data-type="mu34">--%>
<%--                        <a href="detail.jsp">--%>
<%--                            <img src="images/Royal-M139-BoomBang.jpg" alt="Sản phẩm 1" class="product-image">--%>
<%--                        </a>--%>
<%--                        <div class="select-size">--%>
<%--                            <button class="size-button selected" data-value="M">M</button>--%>
<%--                            <button class="size-button" data-value="L">L</button>--%>
<%--                            <button class="size-button" data-value="XL">XL</button>--%>
<%--                        </div> --%>
<%--                        <a href="detail.html">--%>
<%--                            <h3 class="product-name">Royal M139 BoomBang</h3>--%>
<%--                        </a>--%>
<%--                        <p class="product-price">Giá: 650.000 đ</p>--%>
<%--                        <button class="buy-button" onclick="addToCart(this)">Thêm vào giỏ hàng</button>--%>
<%--                    </div>--%>
<%--                    <div class="product-item" data-type="mu34">--%>
<%--                        <img src="images/Royal-M139-Chuot-xuoc-bong.jpg" alt="Sản phẩm 2" class="product-image">--%>
<%--                        <div class="select-size">--%>
<%--                            <button class="size-button selected" data-value="M">M</button>--%>
<%--                            <button class="size-button" data-value="L">L</button>--%>
<%--                            <button class="size-button" data-value="XL">XL</button>--%>
<%--                        </div> --%>
<%--                        <h3 class="product-name">Royal M139 Chuột xước bóng</h3>--%>
<%--                        <p class="product-price">Giá: 200.000 đ</p>--%>
<%--                        <button class="buy-button" onclick="addToCart(this)">Thêm vào giỏ hàng</button>--%>
<%--                    </div>--%>
<%--                    <div class="product-item" data-page="1">--%>
<%--                        <img src="images/Royal-M139-Den-mo.jpg" alt="Sản phẩm 3" class="product-image">--%>
<%--                        <div class="select-size">--%>
<%--                            <button class="size-button selected" data-value="M">M</button>--%>
<%--                            <button class="size-button" data-value="L">L</button>--%>
<%--                            <button class="size-button" data-value="XL">XL</button>--%>
<%--                        </div> --%>
<%--                        <h3 class="product-name">Royal M139 Đen mờ</h3>--%>
<%--                        <p class="product-price">Giá: 150.000 đ</p>--%>
<%--                        <button class="buy-button" onclick="addToCart(this)">Thêm vào giỏ hàng</button>--%>
<%--                    </div>--%>
<%--                    <div class="product-item" data-type="mu34">--%>
<%--                        <img src="images/Royal-M139-Leopard.jpg" alt="Sản phẩm 4" class="product-image">--%>
<%--                        <div class="select-size">--%>
<%--                            <button class="size-button selected" data-value="M">M</button>--%>
<%--                            <button class="size-button" data-value="L">L</button>--%>
<%--                            <button class="size-button" data-value="XL">XL</button>--%>
<%--                        </div> --%>
<%--                        <h3 class="product-name">Royal M139 Leopard</h3>--%>
<%--                        <p class="product-price">Giá: 250.000 đ</p>--%>
<%--                        <button class="buy-button" onclick="addToCart(this)">Thêm vào giỏ hàng</button>--%>
<%--                    </div>--%>
<%--                    <div class="product-item" data-type="mu34">--%>
<%--                        <img src="images/Royal-M139-V.1.jpg" alt="Sản phẩm 5" class="product-image">--%>
<%--                        <div class="select-size">--%>
<%--                            <button class="size-button selected" data-value="M">M</button>--%>
<%--                            <button class="size-button" data-value="L">L</button>--%>
<%--                            <button class="size-button" data-value="XL">XL</button>--%>
<%--                        </div> --%>
<%--                        <h3 class="product-name">Royal M139 V.1</h3>--%>
<%--                        <p class="product-price">Giá: 300.000 đ</p>--%>
<%--                        <button class="buy-button" onclick="addToCart(this)">Thêm vào giỏ hàng</button>--%>
<%--                    </div>--%>
<%--                    <div class="product-item" data-type="mu34">--%>
<%--                        <img src="images/Royal-M139-Vang-bong.png" alt="Sản phẩm 6" class="product-image">--%>
<%--                        <div class="select-size">--%>
<%--                            <button class="size-button selected" data-value="M">M</button>--%>
<%--                            <button class="size-button" data-value="L">L</button>--%>
<%--                            <button class="size-button" data-value="XL">XL</button>--%>
<%--                        </div> --%>
<%--                        <h3 class="product-name">Royal M139 Vàng bóng</h3>--%>
<%--                        <p class="product-price">Giá: 100.000 đ</p>--%>
<%--                        <button class="buy-button" onclick="addToCart(this)">Thêm vào giỏ hàng</button>--%>
<%--                    </div>--%>
<%--                    <div class="product-item" data-type="mu34">--%>
<%--                        <img src="images/Royal-M139-V.2.jpg" alt="Sản phẩm 7" class="product-image">--%>
<%--                        <div class="select-size">--%>
<%--                            <button class="size-button selected" data-value="M">M</button>--%>
<%--                            <button class="size-button" data-value="L">L</button>--%>
<%--                            <button class="size-button" data-value="XL">XL</button>--%>
<%--                        </div> --%>
<%--                        <h3 class="product-name">Royal M139 V.2</h3>--%>
<%--                        <p class="product-price">Giá: 100.000 đ</p>--%>
<%--                        <button class="buy-button" onclick="addToCart(this)">Thêm vào giỏ hàng</button>--%>
<%--                    </div>--%>
<%--                    <div class="product-item" data-type="mu34">--%>
<%--                        <img src="images/Royal-M139-V.5-Trang-den.jpg" alt="Sản phẩm 8" class="product-image">--%>
<%--                        <div class="select-size">--%>
<%--                            <button class="size-button selected" data-value="M">M</button>--%>
<%--                            <button class="size-button" data-value="L">L</button>--%>
<%--                            <button class="size-button" data-value="XL">XL</button>--%>
<%--                        </div> --%>
<%--                        <h3 class="product-name">Royal M5 Trắng Đen</h3>--%>
<%--                        <p class="product-price">Giá: 100.000 đ</p>--%>
<%--                        <button class="buy-button" onclick="addToCart(this)">Thêm vào giỏ hàng</button>--%>
<%--                    </div>--%>
<%--                    <div class="product-item" data-type="bicycle">--%>
<%--                        <img src="images/Mũ bảo hiểm xe đạp JC-20 Hồng.jpg" alt="Sản phẩm 9" class="product-image">--%>
<%--                        <div class="select-size">--%>
<%--                            <button class="size-button selected" data-value="M">M</button>--%>
<%--                            <button class="size-button" data-value="L">L</button>--%>
<%--                            <button class="size-button" data-value="XL">XL</button>--%>
<%--                        </div> --%>
<%--                        <h3 class="product-name">Mũ bảo hiểm xe đạp JC-20 Hồng</h3>--%>
<%--                        <p class="product-price">Giá: 200.000 đ</p>--%>
<%--                        <button class="buy-button" onclick="addToCart(this)">Thêm vào giỏ hàng</button>--%>
<%--                    </div>--%>
<%--                    <div class="product-item" data-type="bicycle">--%>
<%--                        <img src="images/Mũ bảo hiểm xe đạp JC-20 Cam.jpg" alt="Sản phẩm 10" class="product-image">--%>
<%--                        <div class="select-size">--%>
<%--                            <button class="size-button selected" data-value="M">M</button>--%>
<%--                            <button class="size-button" data-value="L">L</button>--%>
<%--                            <button class="size-button" data-value="XL">XL</button>--%>
<%--                        </div> --%>
<%--                        <h3 class="product-name">Mũ bảo hiểm xe đạp JC-20 Cam</h3>--%>
<%--                        <p class="product-price">Giá: 200.000 đ</p>--%>
<%--                        <button class="buy-button" onclick="addToCart(this)">Thêm vào giỏ hàng</button>--%>
<%--                    </div>--%>
<%--                    <div class="product-item" data-type="bicycle">--%>
<%--                        <img src="images/Mũ bảo hiểm xe đạp JC-20 Xanh Dương.jpg" alt="Sản phẩm 11" class="product-image">--%>
<%--                        <div class="select-size">--%>
<%--                            <button class="size-button selected" data-value="M">M</button>--%>
<%--                            <button class="size-button" data-value="L">L</button>--%>
<%--                            <button class="size-button" data-value="XL">XL</button>--%>
<%--                        </div> --%>
<%--                        <h3 class="product-name">Mũ bảo hiểm xe đạp JC-20 Xanh Dương</h3>--%>
<%--                        <p class="product-price">Giá: 200.000 đ</p>--%>
<%--                        <button class="buy-button" onclick="addToCart(this)">Thêm vào giỏ hàng</button>--%>
<%--                    </div>--%>
<%--                    <div class="product-item" data-type="bicycle">--%>
<%--                        <img src="images/Mũ bảo hiểm xe đạp JC-20 Xanh Lá.jpg" alt="Sản phẩm 12" class="product-image">--%>
<%--                        <div class="select-size">--%>
<%--                            <button class="size-button selected" data-value="M">M</button>--%>
<%--                            <button class="size-button" data-value="L">L</button>--%>
<%--                            <button class="size-button" data-value="XL">XL</button>--%>
<%--                        </div> --%>
<%--                        <h3 class="product-name">Mũ bảo hiểm xe đạp JC-20 Xanh Lá</h3>--%>
<%--                        <p class="product-price">Giá: 200.000 đ</p>--%>
<%--                        <button class="buy-button" onclick="addToCart(this)">Thêm vào giỏ hàng</button>--%>
<%--                    </div>--%>
<%--                    <div class="product-item" data-type="bicycle">--%>
<%--                        <img src="images/Mũ bảo hiểm xe đạp JC-20 Đỏ.jpg" alt="Sản phẩm 13" class="product-image">--%>
<%--                        <div class="select-size">--%>
<%--                            <button class="size-button selected" data-value="M">M</button>--%>
<%--                            <button class="size-button" data-value="L">L</button>--%>
<%--                            <button class="size-button" data-value="XL">XL</button>--%>
<%--                        </div> --%>
<%--                        <h3 class="product-name">Mũ bảo hiểm xe đạp JC-20 Đỏ</h3>--%>
<%--                        <p class="product-price">Giá: 200.000 đ</p>--%>
<%--                        <button class="buy-button" onclick="addToCart(this)">Thêm vào giỏ hàng</button>--%>
<%--                    </div>--%>
<%--                    <div class="product-item" data-type="mu34">--%>
<%--                        <img src="images/1-Royal M139 Đỏ đô.jpg" alt="Sản phẩm 14" class="product-image">--%>
<%--                        <div class="select-size">--%>
<%--                            <button class="size-button selected" data-value="M">M</button>--%>
<%--                            <button class="size-button" data-value="L">L</button>--%>
<%--                            <button class="size-button" data-value="XL">XL</button>--%>
<%--                        </div> --%>
<%--                        <h3 class="product-name">Royal M139 Đỏ đô</h3>--%>
<%--                        <p class="product-price">Giá: 100.000 đ</p>--%>
<%--                        <button class="buy-button" onclick="addToCart(this)">Thêm vào giỏ hàng</button>--%>
<%--                    </div>--%>
<%--                    <div class="product-item" data-type="mu34">--%>
<%--                        <img src="images/1-Royal M139 V.5 Đen - đồng.jpg" alt="Sản phẩm 15" class="product-image">--%>
<%--                        <div class="select-size">--%>
<%--                            <button class="size-button selected" data-value="M">M</button>--%>
<%--                            <button class="size-button" data-value="L">L</button>--%>
<%--                            <button class="size-button" data-value="XL">XL</button>--%>
<%--                        </div> --%>
<%--                        <h3 class="product-name">Royal M139 V.5 Đen - đồng</h3>--%>
<%--                        <p class="product-price">Giá: 100.000 đ</p>--%>
<%--                        <button class="buy-button" onclick="addToCart(this)">Thêm vào giỏ hàng</button>--%>
<%--                    </div>--%>
<%--                    <div class="product-item" data-type="mu34">--%>
<%--                        <img src="images/1-Royal M139 V.7 Vàng bóng.jpg" alt="Sản phẩm 16" class="product-image">--%>
<%--                        <div class="select-size">--%>
<%--                            <button class="size-button selected" data-value="M">M</button>--%>
<%--                            <button class="size-button" data-value="L">L</button>--%>
<%--                            <button class="size-button" data-value="XL">XL</button>--%>
<%--                        </div> --%>
<%--                        <h3 class="product-name">Royal M139 V.7 Vàng bóng</h3>--%>
<%--                        <p class="product-price">Giá: 100.000 đ</p>--%>
<%--                        <button class="buy-button" onclick="addToCart(this)">Thêm vào giỏ hàng</button>--%>
<%--                    </div>--%>
<%--                    <div class="product-item" data-type="mu34">--%>
<%--                        <img src="images/1-Royal M125K Chuột Mờ.png" alt="Sản phẩm 17" class="product-image">--%>
<%--                        <div class="select-size">--%>
<%--                            <button class="size-button selected" data-value="M">M</button>--%>
<%--                            <button class="size-button" data-value="L">L</button>--%>
<%--                            <button class="size-button" data-value="XL">XL</button>--%>
<%--                        </div> --%>
<%--                        <h3 class="product-name">Royal M125K Chuột Mờ</h3>--%>
<%--                        <p class="product-price">Giá: 100.000 đ</p>--%>
<%--                        <button class="buy-button" onclick="addToCart(this)">Thêm vào giỏ hàng</button>--%>
<%--                    </div>--%>
<%--                    <div class="product-item" data-type="mu34">--%>
<%--                        <img src="images/1-Royal M139 Xám Xi Măng Bóng.png" alt="Sản phẩm 18" class="product-image">--%>
<%--                        <div class="select-size">--%>
<%--                            <button class="size-button selected" data-value="M">M</button>--%>
<%--                            <button class="size-button" data-value="L">L</button>--%>
<%--                            <button class="size-button" data-value="XL">XL</button>--%>
<%--                        </div> --%>
<%--                        <h3 class="product-name">Royal M139 Xám Xi Măng Bóng</h3>--%>
<%--                        <p class="product-price">Giá: 100.000 đ</p>--%>
<%--                        <button class="buy-button" onclick="addToCart(this)">Thêm vào giỏ hàng</button>--%>
<%--                    </div>--%>
<%--                    <div class="product-item" data-type="fullface">--%>
<%--                        <img src="images/Mũ bảo hiểm Fullface Royal M141K Đen Bóng.png" alt="Sản phẩm 19" class="product-image">--%>
<%--                        <div class="select-size">--%>
<%--                            <button class="size-button selected" data-value="M">M</button>--%>
<%--                            <button class="size-button" data-value="L">L</button>--%>
<%--                            <button class="size-button" data-value="XL">XL</button>--%>
<%--                        </div> --%>
<%--                        <h3 class="product-name">Fullface Royal M141K Đen Bóng</h3>--%>
<%--                        <p class="product-price">Giá: 100.000 đ</p>--%>
<%--                        <button class="buy-button" onclick="addToCart(this)">Thêm vào giỏ hàng</button>--%>
<%--                    </div>--%>
<%--                    <div class="product-item" data-type="fullface">--%>
<%--                        <img src="images/Mũ bảo hiểm Fullface Royal M02 SCHU Đen.jpg" alt="Sản phẩm 20" class="product-image">--%>
<%--                        <div class="select-size">--%>
<%--                            <button class="size-button selected" data-value="M">M</button>--%>
<%--                            <button class="size-button" data-value="L">L</button>--%>
<%--                            <button class="size-button" data-value="XL">XL</button>--%>
<%--                        </div> --%>
<%--                        <h3 class="product-name">Fullface Royal M02 SCHU Đen</h3>--%>
<%--                        <p class="product-price">Giá: 100.000 đ</p>--%>
<%--                        <button class="buy-button" onclick="addToCart(this)">Thêm vào giỏ hàng</button>--%>
<%--                    </div>--%>
<%--                    <div class="product-item" data-type="fullface">--%>
<%--                        <img src="images/Mũ bảo hiểm Fullface Royal M141K Trắng.png" alt="Sản phẩm 21" class="product-image">--%>
<%--                        <div class="select-size">--%>
<%--                            <button class="size-button selected" data-value="M">M</button>--%>
<%--                            <button class="size-button" data-value="L">L</button>--%>
<%--                            <button class="size-button" data-value="XL">XL</button>--%>
<%--                        </div> --%>
<%--                        <h3 class="product-name">Fullface Royal M141K Trắng</h3>--%>
<%--                        <p class="product-price">Giá: 100.000 đ</p>--%>
<%--                        <button class="buy-button" onclick="addToCart(this)">Thêm vào giỏ hàng</button>--%>
<%--                    </div>--%>
<%--                    <div class="product-item" data-type="mu34">--%>
<%--                        <img src="images/1-Royal M139 V.9 Trắng.jpg" alt="Sản phẩm 22" class="product-image">--%>
<%--                        <div class="select-size">--%>
<%--                            <button class="size-button selected" data-value="M">M</button>--%>
<%--                            <button class="size-button" data-value="L">L</button>--%>
<%--                            <button class="size-button" data-value="XL">XL</button>--%>
<%--                        </div> --%>
<%--                        <h3 class="product-name">Royal M139 V.9 Trắng</h3>--%>
<%--                        <p class="product-price">Giá: 100.000 đ</p>--%>
<%--                        <button class="buy-button" onclick="addToCart(this)">Thêm vào giỏ hàng</button>--%>
<%--                    </div>--%>
<%--                    <div class="product-item" data-type="fullface">--%>
<%--                        <img src="images/Mũ bảo hiểm Fullface Royal M02 Đỏ.jpg" alt="Sản phẩm 23" class="product-image">--%>
<%--                        <div class="select-size">--%>
<%--                            <button class="size-button selected" data-value="M">M</button>--%>
<%--                            <button class="size-button" data-value="L">L</button>--%>
<%--                            <button class="size-button" data-value="XL">XL</button>--%>
<%--                        </div> --%>
<%--                        <h3 class="product-name">Fullface Royal M02 Đỏ</h3>--%>
<%--                        <p class="product-price">Giá: 100.000 đ</p>--%>
<%--                        <button class="buy-button" onclick="addToCart(this)">Thêm vào giỏ hàng</button>--%>
<%--                    </div>--%>
<%--                    <div class="product-item" data-type="half">--%>
<%--                        <img src="images/1.2-Asia MT-10-Do-mo.jpg" alt="Sản phẩm 24" class="product-image">--%>
<%--                        <div class="select-size">--%>
<%--                            <button class="size-button selected" data-value="M">M</button>--%>
<%--                            <button class="size-button" data-value="L">L</button>--%>
<%--                            <button class="size-button" data-value="XL">XL</button>--%>
<%--                        </div> --%>
<%--                        <h3 class="product-name">Asia MT-10 Đỏ mờ</h3>--%>
<%--                        <p class="product-price">Giá: 100.000 đ</p>--%>
<%--                        <button class="buy-button" onclick="addToCart(this)">Thêm vào giỏ hàng</button>--%>
<%--                    </div>--%>
<%--                    <div class="product-item" data-type="half">--%>
<%--                        <img src="images/1.2-Asia MT-10-Xanh-mu-bong.jpg" alt="Sản phẩm 25" class="product-image">--%>
<%--                        <div class="select-size">--%>
<%--                            <button class="size-button selected" data-value="M">M</button>--%>
<%--                            <button class="size-button" data-value="L">L</button>--%>
<%--                            <button class="size-button" data-value="XL">XL</button>--%>
<%--                        </div> --%>
<%--                        <h3 class="product-name">Asia MT-10 Xanh mu bóng</h3>--%>
<%--                        <p class="product-price">Giá: 100.000 đ</p>--%>
<%--                        <button class="buy-button" onclick="addToCart(this)">Thêm vào giỏ hàng</button>--%>
<%--                    </div>--%>
<%--                    <div class="product-item" data-type="half">--%>
<%--                        <img src="images/1.2-Asia MT-10-Xanh-mu-bong.jpg" alt="Sản phẩm 25" class="product-image">--%>
<%--                        <div class="select-size">--%>
<%--                            <button class="size-button selected" data-value="M">M</button>--%>
<%--                            <button class="size-button" data-value="L">L</button>--%>
<%--                            <button class="size-button" data-value="XL">XL</button>--%>
<%--                        </div> --%>
<%--                        <h3 class="product-name">Asia MT-10 Xanh mu bóng</h3>--%>
<%--                        <p class="product-price">Giá: 100.000 đ</p>--%>
<%--                        <button class="buy-button" onclick="addToCart(this)">Thêm vào giỏ hàng</button>--%>
<%--                    </div>--%>
<%--                    <div class="product-item" data-type="half">--%>
<%--                        <img src="images/1.2-Asia MT-10-Xanh-mu-bong.jpg" alt="Sản phẩm 25" class="product-image">--%>
<%--                        <div class="select-size">--%>
<%--                            <button class="size-button selected" data-value="M">M</button>--%>
<%--                            <button class="size-button" data-value="L">L</button>--%>
<%--                            <button class="size-button" data-value="XL">XL</button>--%>
<%--                        </div> --%>
<%--                        <h3 class="product-name">Asia MT-10 Xanh mu bóng</h3>--%>
<%--                        <p class="product-price">Giá: 100.000 đ</p>--%>
<%--                        <button class="buy-button" onclick="addToCart(this)">Thêm vào giỏ hàng</button>--%>
<%--                    </div>--%>
                    
                </div>
            </div>
            <div class="pagination">
                <div id="page-numbers">
                    <c:forEach var="i" begin="1" end="${totalPages}">
                        <a href="${pageContext.request.contextPath}/danhmuc?category=${param.category}&page=${i}"
                           class="${i == currentPage ? 'active' : ''}">${i}</a>
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
