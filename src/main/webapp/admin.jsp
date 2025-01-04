<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

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
                        <a href="${pageContext.request.contextPath}/" class="sidebar-link">
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
                        <a href="${pageContext.request.contextPath}/logout" class="sidebar-link" id="logout-acc">
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
                        <button type="button" class="btn-control-large" id="btn-add-product"><i class="fa-solid fa-plus"></i> Thêm sản phẩm mới</button>
                        <button class="btn-control-large" id="btn-add-category"><i class="fa-solid fa-plus"></i> Thêm danh mục</button> 
                        <button type="button" class="btn-control-large" id="btn-add-brand"><i class="fa-solid fa-plus" ></i> Thêm thương hiệu</button>
                        <button class="btn-control-large" id="btn-add-size"><i class="fa-solid fa-plus"></i> Thêm size</button> 
                    </div>
                </div>
                <ul class="tabs">
                    <li class="tab-item ${activeSubTab == 'product-list' ? 'active' : ''}"
                        onclick="location.href='${pageContext.request.contextPath}/admin/product?subTab=product-list'">
                        Danh sách sản phẩm
                    </li>

                    <li class="tab-item ${activeSubTab == 'variant-list' ? 'active' : ''}"
                        onclick="location.href='${pageContext.request.contextPath}/admin/product?subTab=variant-list'">
                        Mục Khác
                    </li>


                </ul>
                <c:choose>
                <c:when test="${activeSubTab == 'product-list'}">

                <div id="product-list" class="tab-content">
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
                                <td><button class="pdetails-btn" data-id="${product.id}"><i class="fa-solid fa-eye"></i></button></td>
                                <td><button class="edit-btn" onclick="openEditProModal(${product.id})">
                                    <i class="fa-solid fa-pen"></i>
                                </button></td>
                                <td><button class="delete-btn" data-id="${product.id}"><i class="fa-solid fa-trash"></i></button></td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
                <div class="variant-table" id="variant-table">
                    <h4 id="variant-title">Biến thể sản phẩm</h4>
                    <button type="button" class="btn-control-large m-2" id="btn-add-product_variant" ><i class="fa-solid fa-plus"></i> Thêm biến thể</button>
                    <table id="variant-content" style="width:100%">
                        <thead>
                            <tr>
                                <th></th>
                                <th>STT</th>
                                <th>ID sản phẩm</th>
                                <th>Tên biến thể</th>
                                <th>Hình ảnh</th>
                                <th>Màu sắc</th>
                                <th>Giá</th>
                                <th>Chi tiết</th>
                                <th>Sửa</th>
                                <th>Xóa</th>
                            </tr>
                        </thead>
                        <tbody>
                        <c:if test="${empty proVariants}">
                            <tr>
                                <td colspan="5" style="text-align: center; font-style: italic;">Không có dữ liệu</td>
                            </tr>
                        </c:if>
                        <c:forEach var="proV" items="${proVariants}">
                            <tr>
                                <td><input type="checkbox" name="selectedProV" value="${proV.id}"></td>
                                <td>${proV.id}</td>
                                <td>${proV.productId}</td>
                                <td>${proV.name}</td>
                                <td><img src="${pageContext.request.contextPath}/${fn:escapeXml(proV.image)}" alt="${proV.name}" width="50"></td>
                                <td>${proV.color}</td>
                                <td>${proV.price}</td>
                                <td><button class="pvdetails-btn" data-id="${proV.id}"><i class="fa-solid fa-eye"></i></button></td>

                                <td>
                                    <button class="edit-btn" onclick="openEditVariantModal(${proV.id})">
                                        <i class="fa-solid fa-pen"></i>
                                    </button>
                                </td>
                                <td>
                                    <form action="${pageContext.request.contextPath}/delete-tab-product" method="POST" style="display:inline;">
                                        <input type="hidden" name="action" value="deleteProduct">
                                        <input type="hidden" name="id" value="${proV.id}" />
                                        <button type="submit" class="delete-btn">
                                            <i class="fa-solid fa-trash"></i>
                                        </button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>

                <div class="p-size-table" id="p-size-table">
                    <h4 id="p-size-title">Kích thước biến thể sản phẩm</h4>
                    <button class="btn-control-large m-2" id="btn-add-p-size"><i class="fa-solid fa-plus"></i> Thêm kích thước biến thể</button>
                    <table id="p-size-content" style="width:100%">
                        <thead>
                            <tr>
                                <th></th>
                                <th>STT</th>
                                <th>Tên biến thể</th>
                                <th>Kích cỡ</th>
                                <th>Tồn kho</th>
                                <th>Sửa</th>
                                <th>Xóa</th>
                            </tr>
                        </thead>
                        <tbody>
                        <c:if test="${empty productSizes}">
                            <tr>
                                <td colspan="5" style="text-align: center; font-style: italic;">Không có dữ liệu</td>
                            </tr>
                        </c:if>
                        <c:forEach var="proS" items="${productSizes}">
                            <tr>
                                <td><input type="checkbox" name="selectedProV" value="${proS.id}"></td>
                                <td>${proS.id}</td>
                                <td>${proS.variant.name}</td>
                                <td>${proS.size.name}</td>
                                <td>${proS.stock}</td>
                                <td>
                                    <button class="edit-btn" onclick="openEditProSModal(${proS.id})">
                                        <i class="fa-solid fa-pen"></i>
                                    </button>
                                </td>
                                <td>
                                    <form action="${pageContext.request.contextPath}/delete-tab-product" method="POST" style="display:inline;">
                                        <input type="hidden" name="action" value="deletePSize">
                                        <input type="hidden" name="id" value="${proS.id}" />
                                        <button type="submit" class="delete-btn">
                                            <i class="fa-solid fa-trash"></i>
                                        </button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
                </c:when>
                <c:when test="${activeSubTab == 'variant-list'}">
                <div id="variant-list" class="tab-content">
                <!-- Quản lý thương hiệu -->
                <h4>Quản lý Thương hiệu</h4>
                <table id="brand-table" style="width:100%">
                    <thead>
                        <tr>
                            <th></th>
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
                            <td><input type="checkbox" name="selectedBrands" value="${brand.id}"></td>
                            <td>${brand.id}</td>
                            <td>${brand.name}</td>
                            <td><img src="${pageContext.request.contextPath}/${fn:escapeXml(brand.imageUrl)}" alt="${brand.name}" width="50"></td>
                            <td>
                                <!-- Nút sửa, liên kết tới trang chỉnh sửa thương hiệu -->
                                <button class="edit-btn" onclick="openEditBrandModal(${brand.id})">
                                    <i class="fa-solid fa-pen"></i>
                                </button>
                            </td>
                            <td>
                                <form action="${pageContext.request.contextPath}/delete-tab-product" method="POST" style="display:inline;">
                                    <input type="hidden" name="action" value="deleteBrand">
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
                    <c:if test="${empty categories}">
                        <tr>
                            <td colspan="5" style="text-align: center; font-style: italic;">Không có dữ liệu</td>
                        </tr>
                    </c:if>
                    <c:forEach var="cate" items="${categories}">
                    <tr>
                        <td>${cate.id}</td>
                        <td>${cate.name}</td>
                        <td><button class="edit-btn"><i class="fa-solid fa-pen"></i></button></td>
                        <td><button class="delete-btn"><i class="fa-solid fa-trash"></i></button></td>
                    <tr>
                    </c:forEach>
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
                    <c:if test="${empty sizes}">
                        <tr>
                            <td colspan="5" style="text-align: center; font-style: italic;">Không có dữ liệu</td>
                        </tr>
                    </c:if>
                    <c:forEach var="size" items="${sizes}">
                        <tr>
                            <td>${size.id}</td>
                            <td>${size.name}</td>
                            <td><button class="edit-btn"><i class="fa-solid fa-pen"></i></button></td>
                            <td><button class="delete-btn"><i class="fa-solid fa-trash"></i></button></td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
                </c:when>
                </c:choose>

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
                            <th></th>
                            <th>STT</td>
                            <th>Họ và tên</td>
                            <th>SĐT</td>
                            <th>Ngày tham gia</td>
                            <th>Quyền Hạn</td>
                            <th>Tình trạng</td>
                            <th>Chi tiết</th>
                            <th>Sửa</th>
                            <th>Xóa</th>
                        </tr>
                    </thead>
                    <tbody id="show-user">
                    <c:forEach var="u" items="${users}">
                        <tr>
                            <td><input type="checkbox" name="selectedUser" value="${u.id}"></td>
                            <td>${u.id}</td>
                            <td>${u.fullName}</td>
                            <td>${u.phone}</td>
                            <td>${u.createdAt}</td>
                            <td>${u.roleName}</td>
                            <td>${u.activeStatus}</td>
                            <td><button class="detail-btn"><i class="fa-solid fa-pen"></i></button></td>
                            <td><button class="edit-btn"><i class="fa-solid fa-pen"></i></button></td>
                            <td><button class="delete-btn"><i class="fa-solid fa-trash"></i></button></td>
                        </tr>
                    </c:forEach>
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
                            <th></th>
                            <th>Mã đơn</td>
                            <th>Khách hàng</td>
                            <th>Ngày đặt</td>
                            <th>Tổng tiền</td>
                            <th>Trạng thái</td>
                            <th>Chi tiết</th>
                            <th>Xóa</th>
                        </tr>
                    </thead>
                    <tbody id="showOrder">
                    <c:forEach var="o" items="${orders}">
                        <tr>
                            <td><input type="checkbox" name="selectedUser" value="${o.id}"></td>
                            <td>${o.id}</td>
                            <td>${o.user.fullName}</td>
                            <td>${o.createdAt}</td>
                            <td>${o.totalAmount}</td>
                            <td>${o.status}</td>
                            <td><button class="detail-btn"><i class="fa-solid fa-pen"></i></button></td>
                            <td><button class="delete-btn"><i class="fa-solid fa-trash"></i></button></td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty orders}">
                        <tr>
                            <td colspan="9" style="text-align: center;">Không có dữ liệu</td>
                        </tr>
                    </c:if>
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
    <jsp:include page="html/modalAdmin.jsp" />
  
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.13.5/js/jquery.dataTables.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/admin.js"></script>
</body>
</html>