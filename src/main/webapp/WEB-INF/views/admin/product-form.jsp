<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <title>${product.productId != null ? 'Cập Nhật Sản Phẩm' : 'Thêm Mới Sản Phẩm'}</title>
</head>
<body>

<div class="row justify-content-center">
    <div class="col-lg-10">
        <div class="card shadow-sm border">
            <div class="card-header bg-white py-3 border-bottom">
                <h5 class="mb-0 fw-bold text-primary">
                    <i class="fa-solid ${product.productId != null ? 'fa-pen-to-square' : 'fa-plus-circle'} me-2"></i>
                    ${product.productId != null ? 'Cập Nhật Sản Phẩm' : 'Thêm Mới Sản Phẩm'}
                </h5>
            </div>
            <div class="card-body p-4">
                <form action="${pageContext.request.contextPath}/admin/products/save" method="post">
                    <input type="hidden" name="productId" value="${product.productId}" />

                    <div class="row">
                        <div class="col-md-8 mb-3">
                            <label for="productName" class="form-label fw-semibold">Tên sản phẩm <span class="text-danger">*</span></label>
                            <input type="text" class="form-control" id="productName" name="productName" 
                                   value="${product.productName}" placeholder="Nhập tên sản phẩm..." required autofocus>
                        </div>
                        <div class="col-md-4 mb-3">
                            <label for="productCode" class="form-label fw-semibold">Mã sản phẩm (Code)</label>
                            <input type="number" class="form-control" id="productCode" name="productCode" 
                                   value="${product.productCode}" placeholder="Ví dụ: 100101">
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="categoryId" class="form-label fw-semibold">Danh mục (Category) <span class="text-danger">*</span></label>
                            <select class="form-select" id="categoryId" name="categoryId" required>
                                <option value="">-- Chọn danh mục --</option>
                                <c:forEach var="c" items="${categories}">
                                    <option value="${c.categoryId}" ${product.category != null && product.category.categoryId == c.categoryId ? 'selected' : ''}>
                                        ${c.categoryName}
                                    </option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label for="sellerId" class="form-label fw-semibold">Cửa hàng (Seller) <span class="text-danger">*</span></label>
                            <select class="form-select" id="sellerId" name="sellerId" required>
                                <option value="">-- Chọn cửa hàng --</option>
                                <c:forEach var="s" items="${sellers}">
                                    <option value="${s.sellerId}" ${product.seller != null && product.seller.sellerId == s.sellerId ? 'selected' : ''}>
                                        Mã ${s.sellerId} - ${s.sellername}
                                    </option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-4 mb-3">
                            <label for="price" class="form-label fw-semibold">Đơn giá (VNĐ) <span class="text-danger">*</span></label>
                            <input type="number" step="any" class="form-control" id="price" name="price" 
                                   value="${product.price}" required>
                        </div>
                        <div class="col-md-4 mb-3">
                            <label for="amount" class="form-label fw-semibold">Số lượng (Amount)</label>
                            <input type="number" class="form-control" id="amount" name="amount" 
                                   value="${product.amount != null ? product.amount : 0}">
                        </div>
                        <div class="col-md-4 mb-3">
                            <label for="stock" class="form-label fw-semibold">Tồn kho (Stock)</label>
                            <input type="number" class="form-control" id="stock" name="stock" 
                                   value="${product.stock != null ? product.stock : 0}">
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-8 mb-3">
                            <label for="images" class="form-label fw-semibold">Đường dẫn hình ảnh (URL)</label>
                            <input type="text" class="form-control" id="images" name="images" 
                                   value="${product.images}" placeholder="https://example.com/product.jpg">
                        </div>
                        <div class="col-md-4 mb-3">
                            <label for="status" class="form-label fw-semibold">Trạng thái</label>
                            <select class="form-select" id="status" name="status">
                                <option value="1" ${product.status == 1 ? 'selected' : ''}>Hoạt động (Hiển thị)</option>
                                <option value="0" ${product.status == 0 ? 'selected' : ''}>Tạm khóa (Ngừng bán)</option>
                            </select>
                        </div>
                    </div>

                    <div class="mb-4">
                        <label for="description" class="form-label fw-semibold">Mô tả sản phẩm (Description)</label>
                        <textarea class="form-control" id="description" name="description" rows="3" 
                                  placeholder="Nhập thông tin mô tả chi tiết sản phẩm...">${product.description}</textarea>
                    </div>

                    <div class="d-flex justify-content-between pt-3 border-top">
                        <a href="${pageContext.request.contextPath}/admin/products" class="btn btn-outline-secondary">
                            <i class="fa-solid fa-arrow-left me-1"></i> Quay lại
                        </a>
                        <button type="submit" class="btn btn-primary px-4">
                            <i class="fa-solid fa-floppy-disk me-1"></i> Lưu Sản Phẩm
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

</body>
</html>
