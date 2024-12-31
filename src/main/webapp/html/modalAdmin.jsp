<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
        <form id="addProForm" action="${pageContext.request.contextPath}/add-tab-product" method="POST" enctype="multipart/form-data">
          <input type="hidden" name="action" value="addProduct">
          <div class="form-row">
            <div class="form-group col-md-6">
              <label for="productName">Tên Sản Phẩm</label>
              <input type="text" class="form-control" id="editProductName" name="productName">
            </div>
          </div>
          <div class="form-group">
            <label for="productDescription">Miêu Tả</label>
            <textarea class="form-control" id="editProductDescription" name="productDescription" rows="4"></textarea>
          </div>
          <div class="form-row">
            <div class="form-group col-md-6">
              <label for="brand">Thương Hiệu</label>
              <select class="form-control " id="editBrand" name="brand">
                <option value="">Chọn Thương Hiệu</option>
                <c:forEach var="brand" items="${brands}">
                  <option value="${brand.id}">${brand.name}</option>
                </c:forEach>
              </select>
            </div>
            <div class="form-group col-md-6">
              <label for="category">Danh Mục</label>
              <select class="form-control" id="editCategory" name="category">
                <option value="">Chọn Danh Mục</option>
                <c:forEach var="cate" items="${categories}">
                  <option value="${cate.id}">${cate.name}</option>
                </c:forEach>
              </select>
            </div>
          </div>
          <button type="submit" class="btn btn-addO">Thêm Sản Phẩm</button>
        </form>

        <form id="editProForm" action="${pageContext.request.contextPath}/edit-tab-product" method="POST" enctype="multipart/form-data" style="display: none">
          <input type="hidden" name="action" value="editProduct">
          <input type="hidden" id="editProductId" name="productId" value="">
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
                <c:forEach var="cate" items="${categories}">
                  <option value="${cate.id}">${cate.name}</option>
                </c:forEach>
              </select>
            </div>
          </div>
          <button type="submit" class="btn btn-editO">Cập nhật Sản Phẩm</button>
        </form>
      </div>
    </div>
  </div>
</div>

<!-- Modal Thêm Thương Hiệu -->
<div class="modal" id="addBrandModal">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span>&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <!-- Modal Title -->
        <h2 class="modal-title" id="addModalTitle">Thêm Thương Hiệu</h2>

        <!-- Form Thêm Thương Hiệu -->
        <form id="addBrandForm" action="${pageContext.request.contextPath}/add-tab-product" method="POST" enctype="multipart/form-data">
          <input type="hidden" name="action" value="addBrand">
          <div class="form-group col-md-6">
            <label for="brandName">Tên Thương Hiệu</label>
            <input type="text" class="form-control" id="brandName" name="brandName" placeholder="Nhập tên thương hiệu" required>
          </div>
          <div class="form-group col-md-6">
            <label for="brandImage">Chọn Hình Ảnh</label>
            <input type="file" class="form-control" id="brandImage" name="brandImage" required>
          </div>
          <button type="submit" class="btn btn-addO">Thêm Thương Hiệu</button>
        </form>
      </div>
    </div>
  </div>
</div>


<!-- Modal Chỉnh Sửa Thương Hiệu -->
<div class="modal" id="editBrandModal">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span>&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <!-- Modal Title -->
        <h2 class="modal-title" id="editModalTitle">Cập Nhật Thương Hiệu</h2>

        <!-- Form Chỉnh Sửa Thương Hiệu -->
        <form id="editBrandForm" action="${pageContext.request.contextPath}/edit-tab-product" method="POST" enctype="multipart/form-data">
          <input type="hidden" name="action" value="editBrand">
          <input type="hidden" id="editBrandId" name="brandId" value="">
          <div class="form-group col-md-6">
            <label for="editBrandName">Tên Thương Hiệu</label>
            <input type="text" class="form-control" id="editBrandName" name="brandName" value="" placeholder="Nhập tên thương hiệu" required>
          </div>
          <div class="form-group">
            <label for="editBrandImage">Hình ảnh hiện tại:</label>
            <img id="editBrandImagePreview" src="" alt="Hình ảnh thương hiệu" style="width: 100px;">
          </div>
          <div class="form-group">
            <label for="editBrandImage">Tải lên hình ảnh mới:</label>
            <input type="file" id="editBrandImage" name="brandImage" class="form-control">
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
        <form action="${pageContext.request.contextPath}/add-tab-product" method="post">
          <input type="hidden" name="action" value="addCate">
          <div class="form-group col-md-6">
            <label for="categoryName">Tên Danh Mục</label>
            <input type="text" class="form-control" id="categoryName" name="categoryName" placeholder="Nhập tên danh mục" required>
          </div>
          <div class="form-group col-md-6">
            <label for="brandImage">Chọn Hình Ảnh</label>
            <input type="file" class="form-control" id="cateImage" name="cateImage" required>
          </div>
          <button type="submit" class="btn btn-addO">Thêm Danh Mục</button>
        </form>
      </div>
    </div>
  </div>
</div>

<div class="modal" id="addVariantModal">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span>&times;</span>
        </button>
      </div>
      <!-- Modal Body -->
      <div class="modal-body">
        <h2 class="modal-title" id="addVariantModalLabel">Thêm biến thể sản phẩm</h2>

        <form id="addVariantForm" action="${pageContext.request.contextPath}/add-tab-product" method="post" enctype="multipart/form-data">
          <input type="hidden" name="action" value="addProductVariant">
          <div class="mb-3">
            <label for="productParent" class="form-label">Sản phẩm mẹ</label>
            <select class="form-select" id="productParent" name="product_id" required>
              <option value="" disabled selected>Chọn sản phẩm</option>
              <c:forEach var="product" items="${products}">
                <option value="${product.id}">${product.name}</option>
              </c:forEach>
            </select>
          </div>

          <!-- Tên biến thể -->
          <div class="mb-3">
            <label for="variantName" class="form-label">Tên biến thể</label>
            <input type="text" class="form-control" id="variantName" name="name" placeholder="Nhập tên biến thể" required>
          </div>

          <!-- Màu sắc -->
          <div class="mb-3">
            <label for="variantColor" class="form-label">Màu sắc</label>
            <input type="text" class="form-control" id="variantColor" name="color" placeholder="Nhập màu sắc" required>
          </div>

          <!-- Giá -->
          <div class="mb-3">
            <label for="variantPrice" class="form-label">Giá</label>
            <input type="number" class="form-control" id="variantPrice" name="price" placeholder="Nhập giá" required>
          </div>

          <!-- Hình ảnh -->
          <div class="mb-3">
            <label for="variantImage" class="form-label">Hình ảnh</label>
            <input type="file" class="form-control" id="variantImage" name="image" accept="image/*">
          </div>

          <!-- Trạng thái -->
          <div class="mb-3">
            <label for="variantActive" class="form-label">Trạng thái</label>
            <select class="form-select" id="variantActive" name="is_active" required>
              <option value="1" selected>Hoạt động</option>
              <option value="0">Không hoạt động</option>
            </select>
          </div>

          <!-- Nút Lưu -->
          <div class="modal-footer">
            <button type="submit" class="btn btn-addO">Lưu</button>
          </div>
        </form>


        <form id="editVariantForm" action="${pageContext.request.contextPath}/edit-tab-product" method="post" enctype="multipart/form-data" style="display: none">
          <input type="hidden" name="action" value="editProductVariant">
          <input type="hidden" id="editVariantId" name="variantId" value="">
          <div class="mb-3">
            <label for="productParent" class="form-label">Sản phẩm mẹ</label>
            <select class="form-select" id="editProductParent" name="product_id" required>
              <option value="" disabled selected>Chọn sản phẩm</option>
              <c:forEach var="product" items="${products}">
                <option value="${product.id}">${product.name}</option>
              </c:forEach>
            </select>
          </div>

          <!-- Tên biến thể -->
          <div class="mb-3">
            <label for="variantName" class="form-label">Tên biến thể</label>
            <input type="text" class="form-control" id="editVariantName" name="name" placeholder="Nhập tên biến thể" required>
          </div>

          <!-- Màu sắc -->
          <div class="mb-3">
            <label for="variantColor" class="form-label">Màu sắc</label>
            <input type="text" class="form-control" id="editVariantColor" name="color" placeholder="Nhập màu sắc" required>
          </div>

          <!-- Giá -->
          <div class="mb-3">
            <label for="variantPrice" class="form-label">Giá</label>
            <input type="number" class="form-control" id="editVariantPrice" name="price" placeholder="Nhập giá" required>
          </div>

          <!-- Hình ảnh -->
          <div class="mb-3">
            <label for="variantImage" class="form-label">Hình ảnh hiện tại:</label>
            <img id="editVariantImagePreview" src="" alt="Hình ảnh biến thể" style="width: 100px;">
          </div>

          <div class="mb-3">
            <label for="variantImage" class="form-label">Hình ảnh</label>
            <input type="file" class="form-control" id="editVariantImage" name="image" accept="image/*">
          </div>

          <!-- Trạng thái -->
          <div class="mb-3">
            <label for="variantActive" class="form-label">Trạng thái</label>
            <select class="form-select" id="editVariantActive" name="is_active" required>
              <option value="1" selected>Hoạt động</option>
              <option value="0">Không hoạt động</option>
            </select>
          </div>

          <!-- Nút Lưu -->
          <div class="modal-footer">
            <button type="submit" class="btn btn-editO">Lưu</button>
          </div>
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
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span>&times;</span>
        </button>
      </div>
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
          </div>

          <div class="form-row">
            <div class="form-group col-md-6">
              <label for="role">Vai Trò</label>
              <select class="form-control" id="role" name="role">
                <option value="0">Khách Hàng</option>
                <option value="1">Quản Trị Viên</option>
              </select>
            </div>
            <div class="form-group col-md-6">
              <label for="active">Vai Trò</label>
              <select class="form-control" id="active" name="active">
                <option value="0">Không hoạt động</option>
                <option value="1">Hoạt động</option>
              </select>
            </div>
          </div>
          <button type="submit" class="btn btn-addO">Thêm Người Dùng</button>
        </form>
      </div>
    </div>
  </div>
</div>
