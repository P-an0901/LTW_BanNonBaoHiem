<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Trang Khuyến Mãi</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/khuyenmai.css">
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
      <li><a href="#" class="active"> Khuyến Mãi</a></li>
    </ul>
</div>
    <div class="back-to-top active">
        <a href="#"><i class="fa-solid fa-arrow-up"></i></a>
    </div>
    <section id="promotions" class="container my-1">
        <h2 class="text-danger mb-4">Khuyến Mãi</h2>
        <div class="tab-content" id="promotion-tabs-content">
            <div class="tab-pane fade show active" id="product" role="tabpanel" aria-labelledby="product-tab">
                <div class="product-row">
                    <div class="product-item" data-has-discount="true">
                        <img src=" images/Mũ bảo hiểm Fullface Royal M02 SCHU Xanh Dương.jpg" alt="Sản phẩm 6" class="product-image">
                        <div class="select-size">
                            <button class="size-button selected" data-value="M">M</button>
                            <button class="size-button" data-value="L">L</button>
                            <button class="size-button" data-value="XL">XL</button>
                        </div>                        
                        <h3 class="product-name">Fullface Royal M02 SCHU Xanh Dương</h3>
                        <div class="product-price-container">
                            <p class="product-sale-price"><span>120.000 đ</span></p>
                            <p class="product-price"><span>130.000 đ</span></p>
                        </div>
                        <button class="buy-button" onclick="addToCart(this)">Thêm vào giỏ hàng</button>
                    </div>                    
                    <div class="product-item" data-has-discount="true">
                        <img src=" images/Royal-M139-V.10-Trang.jpg" alt="Sản phẩm 7" class="product-image">
                        <div class="select-size">
                            <button class="size-button selected" data-value="M">M</button>
                            <button class="size-button" data-value="L">L</button>
                            <button class="size-button" data-value="XL">XL</button>
                        </div> 
                        <h3 class="product-name">Royal M139 V.10 Trắng</h3>
                        <div class="product-price-container">
                            <p class="product-sale-price"><span>120.000 đ</span></p>
                            <p class="product-price"><span>130.000 đ</span></p>
                        </div>
                        <button class="buy-button" onclick="addToCart(this)">Thêm vào giỏ hàng</button>
                    </div>
                    <div class="product-item" data-has-discount="true">
                        <img src=" images/Royal-M139-V.5-Trang-den.jpg" alt="Sản phẩm 8" class="product-image">
                        <div class="select-size">
                            <button class="size-button selected" data-value="M">M</button>
                            <button class="size-button" data-value="L">L</button>
                            <button class="size-button" data-value="XL">XL</button>
                        </div> 
                        <h3 class="product-name">Royal M139 V.5 Trắng đen</h3>
                        <div class="product-price-container">
                            <p class="product-sale-price"><span>120.000 đ</span></p>
                            <p class="product-price"><span>130.000 đ</span></p>
                        </div>
                        <button class="buy-button" onclick="addToCart(this)">Thêm vào giỏ hàng</button>
                    </div>
                    <div class="product-item" data-has-discount="true">
                        <img src=" images/Royal-M139-V.6-Do-den.jpg" alt="Sản phẩm 9" class="product-image">
                        <div class="select-size">
                            <button class="size-button selected" data-value="M">M</button>
                            <button class="size-button" data-value="L">L</button>
                            <button class="size-button" data-value="XL">XL</button>
                        </div> 
                        <h3 class="product-name">Royal M139 V.6 Đỏ đen</h3>
                        <div class="product-price-container">
                            <p class="product-sale-price"><span>120.000 đ</span></p>
                            <p class="product-price"><span>130.000 đ</span></p>
                        </div>
                        <button class="buy-button" onclick="addToCart(this)">Thêm vào giỏ hàng</button>
                    </div>
                    <div class="product-item" data-has-discount="true">
                        <img src=" images/Royal-M139-V.10-Den.jpg" alt="Sản phẩm 10" class="product-image">
                        <div class="select-size">
                            <button class="size-button selected" data-value="M">M</button>
                            <button class="size-button" data-value="L">L</button>
                            <button class="size-button" data-value="XL">XL</button>
                        </div> 
                        <h3 class="product-name">Royal M139 V.10 Đen</h3>
                        <div class="product-price-container">
                            <p class="product-sale-price"><span>120.000 đ</span></p>
                            <p class="product-price"><span>130.000 đ</span></p>
                        </div>
                        <button class="buy-button" onclick="addToCart(this)">Thêm vào giỏ hàng</button>
                    </div>
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
