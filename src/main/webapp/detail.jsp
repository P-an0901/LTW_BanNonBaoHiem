<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix = "f" uri = "http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <title>Cửa hàng Mũ Bảo Hiểm</title>
    <link rel="icon" href="images/HELMET.png">
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/detail.css">
    <link rel="stylesheet" href="css/header.css">
    <link rel="stylesheet" href="css/danhmuc.css">
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
          <li><a href="./danhmuc">Danh mục </a></li>
          <li><span>/</span></li>
          <li><a href="#" class="active">${productVariant.name}</a></li>
        </ul>
    </div>
    <div class="back-to-top active">
        <a href="#"><i class="fa-solid fa-arrow-up"></i></a>
    </div>
    <div id="imageModal" class="img-modal">
        <div class="modal-content">
            <button type="button" class="close" data-dismiss="modal" aria-label="Close" onclick="closeModal();">
                <span aria-hidden="true">&times;</span>
            </button>
            <img class="modal-image" id="modal-image" src="" alt="Hình ảnh lớn">
        </div>
    </div>
    <section class="product-detail">
        <div class="container">
            <div class="row">
                <!-- Hình ảnh sản phẩm -->
                <div class="col-md-4 detail-img-container">
                    <div class="main-image-wrapper">
                        <img src="${productVariant.image}" class="product-image" id="main-product-image">
                    </div>
                    <div class="product-thumbnails">
                        <c:forEach var="im" items="${listImages}">
                            <img src="${im.imageUrl}" class="thumbnail" data-src="${im.imageUrl}">
                        </c:forEach>
                    </div>
                </div>

                <!-- Thông tin sản phẩm -->
                <div class="col-md-8 product-info">
                    <div class="product-name" id="detail-t">
                        <h1 >${productVariant.name}</h1>
                    </div>
                    <div class="product-details">
                        <span>Thương hiệu: </span><a href="${pageContext.request.contextPath}/danhmuc?brand=${product.brand.id}" class="product-brand">${product.brand.name}</a>
                        <span> | Loại nón: </span><a href="${pageContext.request.contextPath}/danhmuc?category=${product.category.id}" class="product-type">${product.category.name}</a>
                        <div class="rating mt-1">
                            <img src="images/stars.original.png" class="stars">
                            <span class="number-rated">( 99 lượt đánh giá.)</span>
                        </div>
                    </div>
                    <form action="${pageContext.request.contextPath}/add-cart" method="POST" id="addToCartForm">
                        <input type="hidden" name="productId" value="${productVariant.id}">
                    <div class="d-flex justify-content-between">
                        <div class=" col-md-6 session-left p-0">
                            <!-- Thông số kỹ thuật -->
                            <c:choose>
                                <c:when test="${productVariant.sale == true}">
                                    <span class="product-price">Giá <f:formatNumber value="${productVariant.salePrice}" pattern="#,###.###"/> đ</span>
                                    <span class="product-price" style="text-decoration: line-through; color: #7f8c8d; font-size: 0.9em; margin-left: 10px;"><f:formatNumber value="${productVariant.price}" pattern="#,###.###"/> đ</span>
                                    <input type="hidden" name="price" value="${productVariant.salePrice}">
                                </c:when>
                                <c:otherwise>
                                    <p class="product-price"> Giá <f:formatNumber value="${productVariant.price}" pattern="#,###.###"/> đ</p>
                                    <input type="hidden" name="price" value="${productVariant.price}">
                                </c:otherwise>
                            </c:choose>
                            <table class="session-left">
                                <tbody>
                                    <tr>
                                        <td><strong>Kích thước:</strong></td>
                                        <td>${technical.lstSize}</td>
                                    </tr>
                                    <tr>
                                        <td><strong>Trọng lượng:</strong></td>
                                        <td>${technical.weight}</td>
                                    </tr>
                                    <tr>
                                        <td><strong>Màu sắc:</strong></td>
                                        <td>${technical.lstColor}</td>
                                    </tr>
                                    <tr>
                                        <td><strong>Đạt chuẩn:</strong></td>
                                        <td>${technical.standards}</td>
                                    </tr>
                                    <tr>
                                        <td><strong>Chất liệu:</strong></td>
                                        <td>${technical.material}</td>
                                    </tr>
                                    <tr>
                                        <td><strong>Mũ lót:</strong></td>
                                        <td>${technical.innerLining}</td>
                                    </tr>
                                    <tr>
                                        <td><strong>Kính</strong></td>
                                        <td>${technical.visorType}</td>
                                    </tr>
                                    <tr>
                                        <td><strong>Sản xuất tại:</strong></td>
                                        <td>${technical.madeIn}</td>
                                    </tr>
                                    <tr>
                                        <td><strong>Tình trạng:</strong></td>
                                        <td>${technical.condition}</td>
                                    </tr>
                                    <tr>
                                        <td><strong>Bảo hành:</strong></td>
                                        <td>${technical.warranty}</td>
                                    </tr>
                                    <tr>
                                        <td><strong>Đổi trả:</strong></td>
                                        <td>${technical.returns}</td>
                                    </tr>
                                </tbody>
                            </table>
                       </div>
                        <div class="col-md-6 session-right pl-2">
                            <h5>Màu sắc</h5>
                            <div class="product-thumbnails">
                                <div class="thumbnail-container">
                                    <c:forEach var="variant" items="${lstProVariant}">
                                        <a href="${pageContext.request.contextPath}/detail?pvId=${variant.id}">
                                            <img src="${pageContext.request.contextPath}/${fn:escapeXml(variant.image)}" alt="${variant.id}" class="thumbnails">
                                        </a>
                                    </c:forEach>
                                </div>
                            </div>
                            <!-- Chọn size và số lượng -->
                            <div class="product-options">
                                <label for="size">Kích thước:</label>
                                <div id="size" class="form-group mb-3 pl-2">
                                    <c:forEach var="size" items="${sizes}">
                                        <label>
                                            <input type="checkbox" name="sizeId" value="${size.id}" class="checkbox-size" onclick="selectOnlyOne(this)">
                                                ${size.size.name}
                                        </label>
                                    </c:forEach>
                                </div>
                                <label for="quantity">Số lượng:</label>
                                <div class="quantity-selector">
                                    <button type="button" onclick="decreaseQuantity()">-</button>
                                    <input type="number" id="quantity" name="quantity" value="1" min="1" required>
                                    <button type="button" onclick="increaseQuantity()">+</button>
                                </div>
                                <button class="buy-button" type="submit" onclick="return validateForm()">Thêm vào giỏ hàng</button>
                            </div>
                        </div> 
                    </div>
                  </form>
                </div>
            </div>
            <div class="product-description">
                <div class="container">
                    <h3><Strong>Mô tả sản phẩm</Strong></h3>
                    
                    <!-- Mô tả ngắn gọn ban đầu -->
                    <div class="short-description">
                        <h>Nón bảo hiểm 3/4 Royal M139 mang tới sự an toàn cho bạn trên mọi cung đường.</h>5
                        <p>
                            Royal M139 được sản xuất trên những công nghệ tiên tiến, mang đến chất lượng và sự an toàn cao nhất cho người sử dụng.
                        </p>
                        <div class="overlay"></div>
                    </div>
                    
                    <!-- Mô tả đầy đủ, có lớp phủ mờ -->
                    <div class="full-description">
                        <p>Là sản phẩm mới nhất của Royal Helmet, thương hiệu nón bảo hiểm hàng đầu Việt Nam.
                            Royal M139 được sản xuất trên những công nghệ tiên tiến nhất,
                            mang đến chất lượng và sự an toàn cao nhất cho người sử dụng.
                            mang lại cho bạn trải nghiệm dễ chịu nhưng vẫn an toàn khi đội trên mình nón bảo hiểm Royal M139.
                        </p>
                        <p>
                            -Vỏ nón bảo hiểm Royal M139 được chế tạo bằng nhựa ABS nguyên sinh - loại nhựa tinh khiết chưa qua sử dụng,
                            được sử dụng cho các sản phẩm có tiêu chuẩn an toàn cao như vỏ thiết bị y tế, dược phẩm,
                            vỏ máy bay... giúp sản phẩm có độ bền cao và chịu va đập tốt.
                            Royal M139 có trọng lượng chỉ 950g mang đến sự nhẹ nhàng,
                            thoải mái nhưng vẫn đảm bảo được sự an toàn cho người sử dụng.
                        </p>
                        <p>
                            -Phần đệm lót bên trong nón còn có lớp vải kháng khuẩn, chống ẩm,
                            thấm hút mồ hôi rất tốt cho việc bảo vệ chiếc nón khỏi mùi hôi, ẩm mốc.
                            Đây là tính năng đặc biệt phù hợp với khí hậu nhiệt đới của Việt Nam.
                            -Khóa nón được thiết kế chắc chắn, có khả năng điều chỉnh linh hoạt
                        </p>
                        <p> -Phần lót nón có thể tháo rời dễ dàng để tiện vệ sinh, mang tới sự sạch sẽ, dễ chịu cho người sử dụng.</p>
                    </div>
                    <!-- Nút Xem thêm -->
                    <div class="text-center">
                        <button id="toggleDescription" class="btn">Xem thêm</button>
                    </div>
                </div>
        </div>
           
        <div class="container">
                    <!-- Gợi ý sản phẩm cùng loại -->
            <h3>Sản phẩm cùng loại</h3>
            <div class="related-products">
                <c:forEach var="proV" items="${lstProVariant}" varStatus="status">
                    <c:if test="${status.index < 5}">
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
                    </c:if>
                </c:forEach>
            </div>

            <!-- Sản phẩm đã xem -->
            <h3>Sản phẩm đã xem</h3>
            <div class="related-products">
                <div class="related-product-item">
                    <img src="images/Royal-M139-Chuot-xuoc-bong.jpg" alt="Sản phẩm 2" class="related-product-image">
                        <h3 class="related-product-name">Royal M139 Chuột xước bóng</h3>
                        <p class="product-price">Giá: 200.000 đ</p>
                        <button class="buy-button related-product-btn" onclick="addToCart(this)">Thêm vào giỏ hàng</button>
                </div>
                <div class="related-product-item">
                   <img src="images/Royal-M139-Den-mo.jpg" alt="Sản phẩm 3" class="related-product-image">
                        <h3 class="related-product-name">Royal M139 Đen mờ</h3>
                        <p class="product-price">Giá: 150.000 đ</p>
                        <button class="buy-button related-product-btn" onclick="addToCart(this)">Thêm vào giỏ hàng</button>
                </div>
            </div>
        </div>
    </div>
    <div class="container mt-5">
        <h3>Bình luận</h3>
        <!-- Form bình luận -->
        <div class="comment-form">
            <form action="#" method="post" enctype="multipart/form-data">
                <div class="form-group">
                    <label>Đánh giá:</label>
                    <span class="star">&#9734;</span>
                    <span class="star">&#9734;</span>
                    <span class="star">&#9734;</span>
                    <span class="star">&#9734;</span>
                    <span class="star">&#9734;</span>
                </div>
                <div class="form-group">
                    <label for="name">Tên của bạn:</label>
                    <input type="text" class="form-control" id="name" placeholder="Nhập tên của bạn" required>
                </div>
                <div class="form-group">
                    <label for="comment">Bình luận:</label>
                    <textarea class="form-control" id="comment" rows="4" placeholder="Nhập bình luận của bạn" required></textarea>
                </div>
                <div class="form-group">
                    <label for="image">Gửi ảnh:</label>
                    <input type="file" class="form-control" id="image" accept="image/*">
                </div>
                <button type="submit" class="btn btn-primary">Gửi bình luận</button>
            </form>
        </div>
    
        <!-- Danh sách bình luận -->
        <div class="comment-list mt-4">
            <div class="filter-sort">
                <label for="sort">Sắp xếp theo:</label>
                <select id="sort" class="form-control w-auto" onchange="sortComments()">
                    <option value="default">Mặc định</option>
                    <option value="name">Tên người bình luận</option>
                    <option value="date">Ngày tạo</option>
                </select>
            </div>
        
            <!-- Danh sách bình luận -->
            <div id="comment-list-container">
                <!-- Bình luận sẽ hiển thị ở đây -->
                <div class="comment-item">
                    <h6 class="comment-name">Nguyễn Văn A</h6>  <span class="comment-date ml-2">20/11/2024</span>
                    <div class="comment-rating mb-2">
                        <span class="star filled">&#9733;</span>
                        <span class="star filled">&#9733;</span>
                        <span class="star filled">&#9733;</span>
                        <span class="star filled">&#9733;</span>
                        <span class="star filled">&#9733;</span>
                    </div>
                    <p class="comment-text">Nón bảo hiểm này rất đẹp và chất lượng, tôi rất thích!</p>
                    <div class="d-flex justify-content-end">
                        <button class="btn btn-sm mr-3" onclick="likeComment(this)">
                            <i class="fas fa-thumbs-up"></i>
                        </button>
                        <button class="btn btn-sm" onclick="dislikeComment(this)">
                            <i class="fas fa-thumbs-down"></i>
                        </button>
                    </div>
                    <label class="ml-2" onclick="reportComment(this)">Báo cáo</label>
                    <label class="ml-2" onclick="replyComment(this)">Trả lời</label>
                </div>
    
                <!-- Bình luận khác -->
                <div class="comment-item">
                    <h6 class="comment-name">Trần Thị B</h6>  <span class="comment-date ml-2">20/11/2024</span>
                    <div class="comment-rating mb-2">
                        <span class="star filled">&#9733;</span>
                        <span class="star filled">&#9733;</span>
                        <span class="star filled">&#9733;</span>
                        <span class="star filled">&#9733;</span>
                        <span class="star">&#9734;</span>
                    </div>
                    <p class="comment-text">Sản phẩm rất an toàn, tôi đã sử dụng và cảm thấy rất hài lòng.</p>
                    <div class="d-flex justify-content-end">
                        <button class="btn btn-sm mr-3">
                            <i class="fas fa-thumbs-up"></i>
                        </button>
                        <button class="btn btn-sm">
                            <i class="fas fa-thumbs-down"></i>
                        </button>
                        
                    </div>
                    <label class="ml-2" onclick="reportComment(this)">Báo cáo</label>
                    <label class="ml-2" onclick="replyComment(this)">Trả lời</label>
                </div>
            </div>
        
            <!-- Mục "Xem thêm" -->
            <div class="text-center mt-3">
                <button class="btn btn-link" onclick="loadMoreComments()">Xem thêm</button>
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
<script src="js/detail.js"></script>
</body>
</html>
