<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Chi Tiết Sản Phẩm: ${product.productName}</title>
</head>
<body>

<div class="row justify-content-center">
    <div class="col-lg-10">
        <nav aria-label="breadcrumb" class="mb-3">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/home">Trang chủ</a></li>
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/products">Sản phẩm</a></li>
                <li class="breadcrumb-item active" aria-current="page">${product.productName}</li>
            </ol>
        </nav>

        <div class="card shadow-sm border mb-4">
            <div class="card-header bg-primary text-white py-3">
                <h4 class="mb-0 fw-bold">
                    <i class="fa-solid fa-circle-info me-2"></i>Thông Tin Chi Tiết Sản Phẩm
                </h4>
            </div>
            <div class="card-body p-4">
                <!-- Bảng chi tiết sản phẩm chuẩn -->
                <div class="table-responsive">
                    <table class="table table-bordered align-middle mb-0">
                        <tr>
                            <!-- [imageLink] bên trái -->
                            <td rowspan="6" class="text-center align-middle bg-light" style="width: 250px;">
                                <c:choose>
                                    <c:when test="${not empty product.images}">
                                        <img src="${product.images}" alt="${product.productName}" 
                                             class="img-fluid rounded shadow-sm" style="max-height: 250px; object-fit: contain;">
                                    </c:when>
                                    <c:otherwise>
                                        <div class="text-muted py-5">
                                            <i class="fa-regular fa-image fa-3x d-block mb-2"></i>
                                            [imageLink]
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </td>

                            <!-- Tên sản phẩm -->
                            <td class="fw-bold bg-light" style="width: 140px;">Tên sản phẩm:</td>
                            <td><h5 class="fw-bold text-dark mb-0">${product.productName}</h5></td>
                        </tr>
                        <tr>
                            <!-- Mã sản phẩm -->
                            <td class="fw-bold bg-light">Mã sản phẩm:</td>
                            <td><span class="badge bg-secondary fs-6">${product.productCode}</span></td>
                        </tr>
                        <tr>
                            <!-- Danh mục -->
                            <td class="fw-bold bg-light">Danh mục:</td>
                            <td>
                                <span class="badge bg-primary-subtle text-primary border">
                                    ${product.category != null ? product.category.categoryName : 'Chưa phân loại'}
                                </span>
                            </td>
                        </tr>
                        <tr>
                            <!-- Giá -->
                            <td class="fw-bold bg-light">Giá:</td>
                            <td>
                                <span class="text-danger fw-bold fs-4">
                                    ${product.formattedPrice} VNĐ
                                </span>
                            </td>
                        </tr>
                        <tr>
                            <!-- Amount -->
                            <td class="fw-bold bg-light">Amount:</td>
                            <td>
                                <span class="badge bg-info text-dark fs-6">${product.amount}</span>
                                <span class="text-muted small ms-2">(Tồn kho: ${product.stock})</span>
                            </td>
                        </tr>
                        <tr>
                            <!-- Description -->
                            <td class="fw-bold bg-light">Description:</td>
                            <td>
                                <div class="text-secondary" style="line-height: 1.6;">
                                    ${not empty product.description ? product.description : '<em class="text-muted">Không có mô tả chi tiết.</em>'}
                                </div>
                            </td>
                        </tr>
                    </table>
                </div>

                <!-- Khối thêm vào giỏ hàng với giới hạn số lượng -->
                <div class="mt-4 p-3 bg-light rounded border">
                    <form action="${pageContext.request.contextPath}/cart/add" method="post" class="row g-3 align-items-center">
                        <input type="hidden" name="productId" value="${product.productId}" />
                        <div class="col-auto">
                            <label class="form-label fw-bold mb-0">Số lượng:</label>
                        </div>
                        <div class="col-auto">
                            <input type="number" name="quantity" value="1" min="1" 
                                   max="${(product.stock != null && product.stock > 0) ? product.stock : (product.amount != null && product.amount > 0 ? product.amount : 99)}" 
                                   class="form-control text-center fw-bold" style="width: 80px;" required />
                        </div>
                        <div class="col-auto">
                            <span class="text-muted small">
                                (Tối đa: ${(product.stock != null && product.stock > 0) ? product.stock : (product.amount != null && product.amount > 0 ? product.amount : 99)} sản phẩm trong kho)
                            </span>
                        </div>
                        <div class="col-auto ms-md-auto">
                            <button type="submit" class="btn btn-primary px-3 py-2 fw-semibold shadow-sm">
                                <i class="fa-solid fa-cart-plus me-1"></i> Thêm vào giỏ
                            </button>
                            <button type="submit" name="redirect" value="cart" class="btn btn-danger px-3 py-2 fw-semibold shadow-sm ms-2">
                                <i class="fa-solid fa-bag-shopping me-1"></i> Mua ngay
                            </button>
                        </div>
                    </form>
                </div>

                <div class="d-flex justify-content-between align-items-center mt-4 pt-3 border-top">
                    <a href="${pageContext.request.contextPath}/products" class="btn btn-outline-secondary">
                        <i class="fa-solid fa-arrow-left me-1"></i> Quay lại danh sách sản phẩm
                    </a>
                    <div>
                        <span class="text-muted small me-2">Cửa hàng: <strong>${product.seller != null ? product.seller.sellername : 'N/A'}</strong></span>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

</body>
</html>
