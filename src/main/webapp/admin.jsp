<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.13.5/css/jquery.dataTables.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
    <title>Admin</title>
</head>
<body>
    <div class="container">
        <aside class="sidebar open">
            <div class="top-sidebar">
                <a href="#" class="channel-logo"><img src="${pageContext.request.contextPath}/images/HELMET.png" alt="Channel Logo"></a>
                <div class="hidden-sidebar your-channel">
                    <img src="" style="height: 30px;" alt="">
                </div>
            </div>
            <c:set var="tabs" value="home,product,promotion,user,order,statistic" />
            <div class="middle-sidebar">
                <ul class="sidebar-list">
                    <c:forEach var="tab" items="${tabs.split(',')}">
                        <li class="sidebar-list-item tab-content ${tab == activeTab ? 'active' : ''}">
                            <a href="${pageContext.request.contextPath}/admin/${tab}" class="sidebar-link">
                                <div class="sidebar-icon">
                                    <i class="fa-solid ${tab == 'home' ? 'fa-house' : (tab == 'product' ? 'fa-tag' :
                                    (tab == 'promotion' ? 'fa-percent' : (tab == 'user' ? 'fa-users' :
                                    (tab == 'order' ? 'fa-cart-shopping' : 'fa-chart-line'))))}"></i>
                                </div>
                                <div class="hidden-sidebar">${tab == 'home' ? 'Trang tổng quan' :
                                (tab == 'product' ? 'Sản Phẩm' : (tab == 'promotion' ? 'Khuyến Mãi' :
                                (tab == 'user' ? 'Khách hàng' : (tab == 'order' ? 'Đơn hàng' : 'Thống kê'))))}</div>
                            </a>
                        </li>
                    </c:forEach>
                </ul>
            </div>
            <div class="bottom-sidebar">
                <ul class="sidebar-list">
                    <li class="sidebar-list-item user-logout">
                        <a href="/" class="sidebar-link">
                            <div class="sidebar-icon"><i class="fa-solid fa-chevron-left"></i></div>
                            <div class="hidden-sidebar">Trang chủ</div>
                        </a>
                    </li>
                    <li class="sidebar-list-item user-logout">
                        <a href="#" class="sidebar-link">
                            <div class="sidebar-icon"><i class="fa-solid fa-user"></i></div>
                            <div class="hidden-sidebar" id="name-acc"></div>
                        </a>
                    </li>
                    <li class="sidebar-list-item user-logout">
                        <a href="#" class="sidebar-link" id="logout-acc">
                            <div class="sidebar-icon"><i class="fa-solid fa-right-from-bracket"></i></div>
                            <div class="hidden-sidebar">Đăng xuất</div>
                        </a>
                    </li>
                </ul>
            </div>
        </aside>
        <main class="content">
            <c:choose>
            <c:when test="${activeTab == 'home'}">
                <p>${products}</p>
            <div class="section active">
                <h1 class="page-title">Helmet Admin Dashboard</h1>
                <div class="cards">

                    <!-- Khách hàng -->
                    <div class="card-single">
                        <div class="box">
                            <h2 id="amount-user">0</h2>
                            <div class="on-box">
                                <h3>Khách hàng</h3>
                                <p>Sản phẩm là bất cứ cái gì có thể đưa vào thị trường để tạo sự chú ý, mua sắm, sử dụng hay tiêu dùng nhằm thỏa mãn một nhu cầu hay ước muốn.</p>
                            </div>
                        </div>
                    </div>
                    <!-- Sản phẩm -->
                    <div class="card-single">
                        <div class="box">
                            <h2 id="amount-product">0</h2>
                            <div class="on-box">
                                <h3>Sản phẩm</h3>
                                <p>Khách hàng mục tiêu là nhóm đối tượng khách hàng trong phân khúc thị trường mục tiêu mà doanh nghiệp bạn đang hướng tới.</p>
                            </div>
                        </div>
                    </div>
                    <!-- Doanh thu -->
                    <div class="card-single">
                        <div class="box">
                            <h2 id="doanh-thu">VNĐ</h2>
                            <div class="on-box">
                                <h3>Doanh thu</h3>
                                <p>Doanh thu của doanh nghiệp là toàn bộ số tiền thu được do tiêu thụ sản phẩm, cung cấp dịch vụ với sản lượng.</p>
                            </div>
                        </div>
                    </div>
                    <!-- Đơn hàng mới -->
                    <div class="card-single">
                        <div class="box">
                            <h2 id="new-orders">45</h2>
                            <div class="on-box">
                                <h3>Đơn hàng mới</h3>
                                <p>Số lượng đơn hàng mới được tạo gần đây, phản ánh nhu cầu mua sắm của khách hàng.</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            </c:when>
                <c:when test="${activeTab == 'product'}">
            <!-- Product -->
            <div class="section product-all active">
                <h1 class="section-title">Quản Lý Sản Phẩm</h1>
                <div class="admin-control">
                    <div class="admin-control-first">
                        <select name="the-loai" id="the-loai">
                            <option>Tất cả</option>
                            <option>3/4 đầu</option>
                            <option>Nửa đầu</option>
                            <option>Full face</option>
                            <option>Nón trẻ em</option>
                            <option>Nón xe đạp</option>
                        </select>
                        <select name="brand">
                            <option>Tất cả</option>
                            <c:forEach var="brand" items="${brands}">
                                <option>${brand.name}</option>
                            </c:forEach>
                        </select>
                            <form action="brandSearch" class="form-search">
                                <span class="search-btn"><i class="fa-solid fa-magnifying-glass"></i></span> 
                                <input id="form-search-product" type="text" class="form-search-input" placeholder="Tìm kiếm tên sản phẩm..." oninput="">
                            </form>
                    </div>
                    <div class="admin-control-right">
                        <button class="btn-control-large" id="btn-cancel-product"><i class="fa-solid fa-rotate-right"></i> Làm mới</button>
                        <button class="btn-control-large" id="btn-add-product"><i class="fa-solid fa-plus"></i> Thêm sản phẩm mới</button> 
                        <button class="btn-control-large" id="btn-add-category"><i class="fa-solid fa-plus"></i> Thêm danh mục</button> 
                        <button type="button" class="btn-control-large" id="btn-add-brand"><i class="fa-solid fa-plus" ></i> Thêm thương hiệu</button>
                        <button class="btn-control-large" id="btn-add-size"><i class="fa-solid fa-plus"></i> Thêm size</button> 
                    </div>
                </div>
                <ul class="tabs">
                    <li class="tab-item active" data-tab="product-list">Danh sách sản phẩm</li>
                    <li class="tab-item" data-tab="variant-list">Mục Khác</li>
                </ul>
                <div id="product-list" class="tab-content active">

                <div>
                    <h2>Danh sách sản phẩm</h2>
                    <table id="product-table" style="width:100%">
                        <thead>
                            <tr>
                                <th>STT</th>
                                <th>Tên sản phẩm</th>
                                <th>Thương hiệu</th>
                                <th>Danh mục</th>
                                <th>Ngày thêm</th>
                                <th>Biến thể</th>
                                <th>Chi tiết</th>
                                <th>Sửa</th>
                                <th>Xóa</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%-- Lặp qua danh sách sản phẩm và hiển thị thông tin --%>
                        <c:forEach var="product" items="${products}">
                            <tr>
                                <td>${product.id}</td>
                                <td>${product.name}</td>
                                <td>${product.brand.name}</td>
                                <td>${product.category.name}</td>
                                <td>${product.createdAt}</td>
                                <td><button class="variant-btn" data-id="${product.id}"><i class="fa-solid fa-cogs"></i></button></td>
                                <td><button class="pdetails-btn" data-id="${product.id}"><i class="fa-solid fa-eye"></i></button></td>
                                <td><button class="edit-btn" data-id="${product.id}"><i class="fa-solid fa-pen"></i></button></td>
                                <td><button class="delete-btn" data-id="${product.id}"><i class="fa-solid fa-trash"></i></button></td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
                <div class="variant-table" id="variant-table">
                    <h4 id="variant-title">Biến thể sản phẩm</h4>
                    <button class="btn-control-large m-2" id="btn-add-product_variant"><i class="fa-solid fa-plus"></i> Thêm biến thể</button> 
                    <table id="variant-content" style="width:100%">
                        <thead>
                            <tr>
                                <th>STT</th>

                                <th>ID sản phẩm</th>


                                <th>Tên biến thể</th>
                                <th>Hình ảnh</th>
                                <th>Màu sắc</th>
                                <th>Giá</th>
                                <th>Chi tiết</th>

                                <th>Thêm ảnh</th>


                                <th>Sửa</th>
                                <th>Xóa</th>
                            </tr>
                        </thead>
                        <tbody>
                            <!-- Nội dung biến thể sẽ được cập nhật tại đây -->
                        </tbody>
                    </table>
                </div>

                <div class="p-size-table" id="p-size-table">
                    <h4 id="p-size-title">Kích thước biến thể sản phẩm</h4>
                    <button class="btn-control-large m-2" id="btn-add-p-size"><i class="fa-solid fa-plus"></i> Thêm kích thước biến thể</button> 
                    <table id="p-size-content" style="width:100%">
                        <thead>
                            <tr>
                                <th>STT</th>
                                <th>Tên biến thể</th>
                                <th>Kích cỡ</th>
                                <th>Tồn kho</th>
                                <th>Sửa</th>
                                <th>Xóa</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>1</td>
                                <td>Royal M139 Trắng</td>
                                <td>M</td>
                                <td>10</td>
                                <td><button class="edit-btn"><i class="fa-solid fa-pen"></i></button></td>
                                <td><button class="delete-btn"><i class="fa-solid fa-trash"></i></button></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
            <div id="variant-list" class="tab-content">
                <!-- Quản lý thương hiệu -->
                <h4>Quản lý Thương hiệu</h4>
                <table id="brand-table" style="width:100%">
                    <thead>
                        <tr>
                            <th>STT</th>
                            <th>Tên thương hiệu</th>
                            <th>Hình Ảnh</th>
                            <th>Sửa</th>
                            <th>Xóa</th>
                        </tr>
                    </thead>
                    <tbody>
                    <c:if test="${empty brands}">
                        <tr>
                            <td colspan="5" style="text-align: center; font-style: italic;">Không có dữ liệu</td>
                        </tr>
                    </c:if>
                    <c:forEach var="brand" items="${brands}">
                        <tr>
                            <td>${brand.id}</td>
                            <td>${brand.name}</td>
                            <td><img src="${pageContext.request.contextPath}/${brand.imageUrl}" alt="${brand.name}" width="50"></td>
                            <td>
                                <!-- Nút sửa, liên kết tới trang chỉnh sửa thương hiệu -->
                                <button class="edit-btn" onclick="openEditModal(${brand.id}, '${brand.name}', '${brand.imageUrl}')">
                                    <i class="fa-solid fa-pen"></i>
                                </button>
                            </td>
                            <td>
                                <!-- Nút xóa, liên kết tới servlet xử lý xóa -->
                                <form action="${pageContext.request.contextPath}/deleteBrand" method="POST" style="display:inline;">
                                    <input type="hidden" name="id" value="${brand.id}" />
                                    <button type="submit" class="delete-btn">
                                        <i class="fa-solid fa-trash"></i>
                                    </button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
        
                <!-- Quản lý danh mục -->
                <h4>Quản lý Danh mục</h4>
                <table id="category-table" style="width:100%">
                    <thead>
                        <tr>
                            <th>STT</th>
                            <th>Tên danh mục</th>
                            <th>Sửa</th>
                            <th>Xóa</th>
                        </tr>
                    </thead>
                    <tbody>
                        <td>1</td>
                        <td>Mũ 3/4</td>
                        <td><button class="edit-btn"><i class="fa-solid fa-pen"></i></button></td>
                        <td><button class="delete-btn"><i class="fa-solid fa-trash"></i></button></td>
                    </tbody>
                </table>
                <!-- Quản lý Size -->
                <h4>Quản lý Kích Thước</h4>
                <table id="size-table" style="width:100%">
                    <thead>
                        <tr>
                            <th>STT</th>
                            <th>Tên</th>
                            <th>Sửa</th>
                            <th>Xóa</th>
                        </tr>
                    </thead>
                    <tbody>
                        <td>1</td>
                        <td>M</td>
                        <td><button class="edit-btn"><i class="fa-solid fa-pen"></i></button></td>
                        <td><button class="delete-btn"><i class="fa-solid fa-trash"></i></button></td>
                    </tbody>
                </table>
            </div>
        </div>
                </c:when>
                <c:when test="${activeTab == 'promotion'}">
            <div class="section promotion active">
                <h1 class="section-title">Quản Lý Khuyến Mãi</h1>
                <div class="admin-control">
                    <div class="admin-control-left">
                            <form action="promotionSearch" class="form-search">
                                <span class="search-btn"><i class="fa-solid fa-magnifying-glass"></i></span> 
                                <input id="form-search-promotion" type="text" class="form-search-input" placeholder="Tìm kiếm khuyến mãi.." oninput="">
                                
                            </form>

                    </div>
                    <div class="admin-control-right">
                        <div>
                            <label for="time-start">Từ</label>
                            <input type="date" class="form-control-date" id="time-start" onchange="">
                        </div>
                        <div>
                            <label for="time-end">Đến</label>
                            <input type="date" class="form-control-date" id="time-end" onchange="">
                        </div>
                        <button class="btn-control-large" id="btn-cancel-promotion"><i class="fa-solid fa-rotate-right"></i> Làm mới</button>
                        <button class="btn-control-large" id="btn-add-promotion"><i class="fa-solid fa-plus"></i> Thêm Khuyến Mãi</button>
                    </div>

                </div>
                <div>
                    <h2>Danh sách Khuyến Mãi</h2>
                    <table id="promotion-table" style="width:100%">
                        <thead>
                            <tr>
                                <th>STT</th>
                                <th>Tên Khuyến mãi</th>
                                <th>Miêu tả</th>
                                <th>Phần trăm giảm</th>
                                <th>Ngày Bắt đầu</th>
                                <th>Ngày Kết Thúc</th>
                                <th>Sửa</th>
                                <th>Xóa</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>1</td>
                                <td>Giảm giá Đầu tháng</td>
                                <td>Giảm giá sốc!</td>
                                <td>10</th>
                                <td>01-12-2024</th>
                                <td>10-12-2024</th>
                                <td><button class="edit-btn"><i class="fa-solid fa-pen"></i></button></td>
                                <td><button class="delete-btn"><i class="fa-solid fa-trash"></i></button></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <div>
                    <h2>Danh sách Áp dụng Khuyến Mãi</h2>
                    <button class="btn-control-large m-2" id="btn-add-promotion2"><i class="fa-solid fa-plus"></i> Thêm Khuyến Mãi cho biến thể sản phẩm</button>
                    <table id="promotion-table2" style="width:100%">
                        <thead>
                            <tr>
                                <th>STT</th>
                                <th>ID Khuyến Mãi</th>
                                <th>ID Biến Thể Sản Phẩm</th>
                                <th>Sửa</th>
                                <th>Xóa</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>1</td>
                                <td>1</td>
                                <td>1</th>
                                <td><button class="edit-btn"><i class="fa-solid fa-pen"></i></button></td>
                                <td><button class="delete-btn"><i class="fa-solid fa-trash"></i></button></td>
                            </tr>

                        </tbody>
                    </table>
                </div>
            </div>
                </c:when>
            <c:when test="${activeTab == 'user'}">
            <!-- Account -->
            <div class="section user active">
                <h1 class="section-title">Quản Lý Người Dùng</h1>
                <div class="admin-control">
                    <div class="admin-control-center">
                        <form action="userSearch" class="form-search">
                            <span class="search-btn"><i class="fa-solid fa-magnifying-glass"></i></span>
                            <input id="form-search-user" type="text" class="form-search-input" placeholder="Tìm kiếm khách hàng..." oninput="">
                        </form>
                    </div>
                    <div class="admin-control-right">
                        <form action="dateSearch" class="fillter-date">
                            <div>
                                <label for="time-start">Từ</label>
                                <input type="date" class="form-control-date" id="time-start-user" onchange="">
                            </div>
                            <div>
                                <label for="time-end">Đến</label>
                                <input type="date" class="form-control-date" id="time-end-user" onchange="">
                            </div>
                        </form>      
                        <button class="btn-reset-order" onclick=""><i class="fa-solid fa-arrow-rotate-right"></i></button>     
                        <button id="btn-add-user" class="btn-control-large"><i class="fa-solid fa-plus"></i> <span>Thêm Người Dùng</span></button>          
                    </div>
                </div>
            <div>
            <h2>Danh Sách Người Dùng</h2>
            <div class="table">
                <table width="100%">
                    <thead>
                        <tr>
                            <th>STT</td>
                            <th>Họ và tên</td>
                            <th>Liên hệ</td>
                            <th>Ngày tham gia</td>
                            <th>Quyền Hạn</td>
                            <th>Chi tiết</th>
                            <th>Sửa</th>
                            <th>Xóa</th>
                        </tr>
                    </thead>
                    <tbody id="show-user">
                    <tr>
                        <td>1</td>
                        <td>Trần Thị B</td>
                        <td>0123456789</td>
                        <td>2024-10-15</td>
                        <td>Admin</td>
                        <td><button class="udetails-btn" data-id="1"><i class="fa-solid fa-eye"></i></button></td>
                        <td><button class="edit-btn"><i class="fa-solid fa-pen"></i></button></td>
                        <td><button class="delete-btn"><i class="fa-solid fa-trash"></i></button></td>
                    </tr>
                    <tr>
                        <td>2</td>
                        <td>Phạm Văn C</td>
                        <td>0981234567</td>
                        <td>2024-09-30</td>
                        <td>Khách hàng</td>
                        <td><button class="udetails-btn" data-id="2"><i class="fa-solid fa-eye"></i></button></td>
                        <td><button class="edit-btn"><i class="fa-solid fa-pen"></i></button></td>
                        <td><button class="delete-btn"><i class="fa-solid fa-trash"></i></button></td>
                    </tr>
                </tbody>
                </table>
            </div>
        </div>
        </div>
        <!-- Order -->
            </c:when>
            <c:when test="${activeTab == 'order'}">
        <div class="section active">
            <h1 class="section-title">Quản Lý Đơn Hàng</h1>
            <div class="admin-control">
                <div class="admin-control-left">
                    <select name="tinh-trang" id="tinh-trang" onchange="">
                        <option value="2">Tất cả</option>
                        <option value="1">Đã xử lý</option>
                        <option value="0">Chưa xử lý</option>
                    </select>
                </div>
                <div class="admin-control-center">
                    <form action="orderSearch" class="form-search">
                        <span class="search-btn"><i class="fa-solid fa-search"></i></span>
                        <input id="form-search-order" type="text" class="form-search-input" placeholder="Tìm kiếm mã đơn, khách hàng...">
                    </form>
                </div>
                <div class="admin-control-right">
                    <form action="dateSearch" class="fillter-date">
                        <div>
                            <label for="time-start">Từ</label>
                            <input type="date" class="form-control-date" id="time-start2" onchange="">
                        </div>
                        <div>
                            <label for="time-end">Đến</label>
                            <input type="date" class="form-control-date" id="time-end2" onchange="">
                        </div>
                    </form>      
                    <button class="btn-reset-order" onclick=""><i class="fa-solid fa-sync-alt"></i></button>     
                    <button class="btn-control-large" id="btn-add-order"><i class="fa-solid fa-plus"></i>Đơn Hàng</button>  
                    <button class="btn-control-large" id="btn-add-payment_method"><i class="fa-solid fa-plus"></i>Phương Thức Thanh Toán</button>            
                </div>
            </div>
            <h2>Danh Sách Đơn Hàng</h2>
            <div class="table">
                <table width="100%">
                    <thead>
                        <tr>
                            <th>Mã đơn</td>
                            <th>Khách hàng</td>
                            <th>Ngày đặt</td>
                            <th>Tổng tiền</td>
                            <th>Trạng thái</td>
                            <th>Chi tiết</th>
                            <th>Sửa</th>
                            <th>Xóa</th>
                        </tr>
                    </thead>
                    <tbody id="showOrder">
                        <tr>
                            <td>#001</td>
                            <td>Nguyễn A</td>
                            <td>2024-11-01</td>
                            <td>500,000 VND</td>
                            <td>Đang xử lý</td>
                            <td><button class="details-btn" data-id="3"><i class="fa-solid fa-eye"></i></button></td>
                            <td><button class="edit-btn"><i class="fa-solid fa-pen"></i></button></td>
                            <td><button class="delete-btn"><i class="fa-solid fa-trash"></i></button></td>
                        </tr>
                        <tr>
                            <td>#002</td>
                            <td>Trần Thị B</td>
                            <td>2024-11-02</td>
                            <td>1,000,000 VND</td>
                            <td>Hoàn thành</td>
                            <td><button class="details-btn" data-id="3"><i class="fa-solid fa-eye"></i></button></td>
                            <td><button class="edit-btn"><i class="fa-solid fa-pen"></i></button></td>
                            <td><button class="delete-btn"><i class="fa-solid fa-trash"></i></button></td>
                        </tr>
                        <tr>
                            <td>#003</td>
                            <td>Phạm Văn C</td>
                            <td>2024-11-03</td>
                            <td>750,000 VND</td>
                            <td>Đang xử lý</td>
                            <td><button class="details-btn" data-id="3"><i class="fa-solid fa-eye"></i></button></td>
                            <td><button class="edit-btn"><i class="fa-solid fa-pen"></i></button></td>
                            <td><button class="delete-btn"><i class="fa-solid fa-trash"></i></button></td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
            </c:when>
            <c:when test="${activeTab == 'statistic'}">
        <div class="section active">
            <h1 class="section-title">Thống Kê</h1>
            <div class="admin-control">
                <div class="admin-control-left">
                    <select name="the-loai-tk" id="the-loai-tk" onchange="">
                        <option>Tất cả</option>
                        <option>3/4 đầu</option>
                        <option>Nửa đầu</option>
                        <option>Full face</option>
                        <option>Nón trẻ em</option>
                        <option>Nón xe đạp</option>
                    </select>
                    <select name="brand-tk" id="brand-tk" onchange="">
                        <option>Tất cả</option>
                        <option>Royal</option>
                        <option>Asia</option>
                        <option>JC</option>
                        <!-- <option>Nón Sơn</option> -->
                    </select>
                </div>
                <div class="admin-control-center">
                    <form action="tksearch" class="form-search">
                        <span class="search-btn"><i class="fa-solid fa-search"></i></span>
                        <input id="form-search-tk" type="text" class="form-search-input" placeholder="Tìm kiếm nón..." oninput="">
                    </form>
                </div>
                <div class="admin-control-right">
                    <form action="s" class="fillter-date">
                        <div>
                            <label for="time-start">Từ</label>
                            <input type="date" class="form-control-date" id="time-start-tk" onchange="">
                        </div>
                        <div>
                            <label for="time-end">Đến</label>
                               <input type="date" class="form-control-date" id="time-end-tk" onchange="">
                        </div>
                    </form> 
                    <button class="btn-reset-order" onclick=""><i class="fa-solid fa-arrow-up-short-wide"></i></button>
                    <button class="btn-reset-order" onclick=""><i class="fa-solid fa-arrow-down-wide-short"></i></button>
                    <button class="btn-reset-order" onclick=""><i class="fa-solid fa-sync-alt"></i></button>                    
                </div>
            </div>
            <div class="order-statistical" id="order-statistical">
                <div class="order-statistical-item">
                    <div class="order-statistical-item-content">
                        <p class="order-statistical-item-content-desc">Sản phẩm được bán ra</p>
                        <h4 class="order-statistical-item-content-h" id="quantity-product"></h4>
                    </div>
                    <div class="order-statistical-item-icon">
                        <i class="fa-solid fa-box"></i>
                    </div>
                </div>
                <div class="order-statistical-item">
                    <div class="order-statistical-item-content">
                        <p class="order-statistical-item-content-desc">Số lượng bán ra</p>
                        <h4 class="order-statistical-item-content-h" id="quantity-order"></h4>
                    </div>
                    <div class="order-statistical-item-icon">
                           <i class= "fa-solid fa-list"></i>
                    </div>
                </div>
                <div class="order-statistical-item">
                    <div class="order-statistical-item-content">
                        <p class="order-statistical-item-content-desc">Doanh thu</p>
                        <h4 class="order-statistical-item-content-h" id="quantity-sale"></h4>
                    </div>
                    <div class="order-statistical-item-icon">
                        <i class="fa-solid fa-dollar-sign fa-2x"></i>
                    </div>
                </div>
                <div class="table">
                    <table>
                        <thead>
                            <tr>
                                <td>STT</td>
                                <td>Tên sản phẩm</td>
                                <td>Số lượng bán</td>
                                <td>Doanh thu</td>
                                <td></td>
                            </tr>
                        </thead>
                        <tbody id="showTk"></tbody>
                        <tr>
                            <td>1</td>
                            <td>Sản phẩm A</td>
                            <td>100</td>
                            <td>2,000,000</td>
                            <td><button>Chi tiết</button></td>
                        </tr>
                        <tr>
                            <td>2</td>
                            <td>Sản phẩm B</td>
                            <td>150</td>
                            <td>3,000,000</td>
                            <td><button>Chi tiết</button></td>
                        </tr>
                        <tr>
                            <td>3</td>
                            <td>Sản phẩm C</td>
                            <td>200</td>
                            <td>4,000,000</td>
                            <td><button>Chi tiết</button></td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
            </c:when>
            </c:choose>
        </main>
    </div>
    <!-- Modal thêm sản phẩm -->
    <div class="modal" id="addProductModal">
        <div class="modal-dialog">
          <div class="modal-content">
            <div class="modal-header">
              <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                <span>&times;</span>
            </button>
            </div>
            <div class="modal-body">
                <h2 class="modal-title">Thêm Sản Phẩm</h2>
              <form id=${pageContext.request.contextPath}/admin/product">
                <div class="form-row">
                  <div class="form-group col-md-6">
                    <label for="productName">Tên Sản Phẩm</label>
                    <input type="text" class="form-control" id="productName" name="productName">
                  </div>
                </div>
                <div class="form-group">
                  <label for="productDescription">Miêu Tả</label>
                  <textarea class="form-control" id="productDescription" name="productDescription" rows="4"></textarea>
                </div>
                <div class="form-row">
                    <div class="form-group col-md-6">
                        <label for="brand">Thương Hiệu</label>
                        <select class="form-control " id="brand" name="brand">
                            <option value="">Chọn Thương Hiệu</option>
                            <c:forEach var="brand" items="${brands}">
                                <option value="${brand.id}">${brand.name}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="form-group col-md-6">
                    <label for="category">Danh Mục</label>
                    <select class="form-control" id="category" name="category">
                      <option value="">Chọn Danh Mục</option>
                      <option value="1">Mũ 3/4</option>
                      <option value="category2">Fullface</option>
                      <option value="category3">Mũ 1/2</option>
                    </select>
                  </div>
                </div>
                <button type="submit" class="btn btn-addO">Thêm Sản Phẩm</button>
              </form>
            </div>
      
          </div>
        </div>
      </div>

<!-- Modal Thêm Thương Hiệu -->
    <div class="modal" id="brandModal">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span>&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <!-- Modal Title -->
                    <h2 class="modal-title" id="modalTitle">Thêm Thương Hiệu</h2>

                    <!-- Add Brand Form (Initially visible) -->
                    <form id="addBrandForm" action="${pageContext.request.contextPath}/addBrand" method="POST">
                        <input type="hidden" name="action" value="addBrand">
                        <div class="form-group col-md-6">
                            <label for="brandName">Tên Thương Hiệu</label>
                            <input type="text" class="form-control" id="brandName" name="brandName" placeholder="Nhập tên thương hiệu" required>
                        </div>
                        <div class="form-group col-md-6">
                            <label for="brandImage">Chọn Hình Ảnh</label>
                            <input type="text" class="form-control" id="brandImage" name="brandImage" required>
                        </div>
                        <button type="submit" class="btn btn-addO">Thêm Thương Hiệu</button>
                    </form>

                    <!-- Edit Brand Form (Initially hidden) -->
                    <form id="editBrandForm" action="${pageContext.request.contextPath}/editBrand" method="POST" style="display:none;">
                        <input type="hidden" name="action" value="editBrand">
                        <input type="hidden" id="brandId" name="brandId" value="">
                        <div class="form-group col-md-6">
                            <label for="editBrandName">Tên Thương Hiệu</label>
                            <input type="text" class="form-control" id="editBrandName" name="brandName" placeholder="Nhập tên thương hiệu" required>
                        </div>
                        <div class="form-group col-md-6">
                            <label for="editBrandImage">Chọn Hình Ảnh</label>
                            <input type="text" class="form-control" id="editBrandImage" name="brandImage" required>
                        </div>
                        <button type="submit" class="btn btn-editO">Cập Nhật Thương Hiệu</button>
                    </form>
                </div>
            </div>
        </div>
    </div>


<div class="modal" id="addCategoryModal">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span>&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <h2 class="modal-title">Thêm Danh Mục</h2>
                <form id="addCategoryForm">
                    <div class="form-group col-md-6">
                        <label for="categoryId">ID Danh Mục</label>
                        <input type="text" class="form-control" id="categoryId" name="categoryId" placeholder="Nhập ID danh mục" required>
                    </div>
                    <div class="form-group col-md-6">
                        <label for="categoryName">Tên Danh Mục</label>
                        <input type="text" class="form-control" id="categoryName" name="categoryName" placeholder="Nhập tên danh mục" required>
                    </div> 
                    <button type="submit" class="btn btn-addO">Thêm Danh Mục</button>
                </form>
            </div>
        </div>
    </div>
</div>
<!-- Modal chi tiết sản phẩm -->
<div id="productDetailModal" class="modal">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span>&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <h2>Chi tiết kỹ thuật sản phẩm</h2>
                <div id="product-id-display"></div>
                <table id="details-table">
                    <thead>
                        <tr>
                            <th>Thông số</th>
                            <th>Giá trị</th>
                            <th>Thao tác</th>
                        </tr>
                    </thead>
                <tbody>
                    <tr>
                        <td>Trọng lượng</td>
                        <td>1.2kg</td>
                        <td>
                            <button class="edit-btn"><i class="fa-solid fa-pen"></i> Sửa</button>
                            <button class="delete-btn"><i class="fa-solid fa-trash"></i> Xóa</button>
                        </td>
                    </tr>
                    <tr>
                        <td>Chất liệu</td>
                        <td>Nhựa ABS</td>
                        <td>
                            <button class="edit-btn"><i class="fa-solid fa-pen"></i> Sửa</button>
                            <button class="delete-btn"><i class="fa-solid fa-trash"></i> Xóa</button>
                        </td>
                    </tr>
          
                </tbody>
            </table>
            <button id="add-detail-btn"><i class="fa-solid fa-plus"></i> Thêm thông số</button>
        </div>
    </div>
  </div>
</div>
  <!-- Modal Thêm Người Dùng -->
  <div class="modal" id="addUserModal">
    <div class="modal-dialog">
      <div class="modal-content">
        
        <!-- Header Modal -->
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span>&times;</span>
          </button>
        </div>
  
        <!-- Body Modal -->
        <div class="modal-body">
            <h2 class="modal-title">Thêm Người Dùng</h2>
          <form id="addUserForm">
            <div class="form-row">
              <div class="form-group col-md-6">
                <label for="username">Tên Người Dùng</label>
                <input type="text" class="form-control" id="username" name="username" required>
              </div>
              <div class="form-group col-md-6">
                <label for="email">Email</label>
                <input type="email" class="form-control" id="email" name="email" required>
              </div>
            </div>
  
            <div class="form-row">
              <div class="form-group col-md-6">
                <label for="password">Mật Khẩu</label>
                <input type="password" class="form-control" id="password" name="password" required>
              </div>
              <div class="form-group col-md-6">
                <label for="password">Xác nhận mật khẩu</label>
                <input type="password" class="form-control" id="password2" name="password" required>
              </div>
              <div class="form-group col-md-6">
                <label for="phone">Số Điện Thoại</label>
                <input type="tel" class="form-control" id="phone" name="phone">
              </div>
            </div>
  
            <div class="form-group">
              <label for="birthday">Ngày Sinh</label>
              <input type="date" class="form-control" id="birthday" name="birthday">
            </div>
  
            <div class="form-row">
              <div class="form-group col-md-12">
                <label for="image">Ảnh Đại Diện</label>
                <input type="file" class="form-control-file" id="image" name="image">
              </div>
            </div>
  
            <div class="form-row">
              <div class="form-group col-md-12">
                <label for="address">Địa Chỉ</label>
                <textarea class="form-control" id="address" name="address" rows="3"></textarea>
              </div>
            </div>
  
            <div class="form-row">
              <div class="form-group col-md-6">
                <label for="role">Vai Trò</label>
                <select class="form-control" id="role" name="role">
                  <option value="0">Khách Hàng</option>
                  <option value="1">Quản Trị Viên</option>
                </select>
              </div>
            </div>
  
            <!-- Nút Thêm Người Dùng -->
            <button type="submit" class="btn btn-addO">Thêm Người Dùng</button>
          </form>
        </div>
      </div>
    </div>
  </div>
  
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.13.5/js/jquery.dataTables.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/admin.js"></script>
</body>
</html>