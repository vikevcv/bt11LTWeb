<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Giỏ Hàng Của Bạn</title>
</head>
<body>

<div class="row mb-4">
    <div class="col-12">
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/home">Trang chủ</a></li>
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/products">Sản phẩm</a></li>
                <li class="breadcrumb-item active" aria-current="page">Giỏ hàng</li>
            </ol>
        </nav>
        <h3 class="fw-bold text-primary">
            <i class="fa-solid fa-cart-shopping me-2"></i>Giỏ Hàng Của Bạn
        </h3>
        <p class="text-muted small">Quản lý các sản phẩm bạn đã chọn, tùy chỉnh số lượng trong giới hạn tồn kho trước khi đặt hàng.</p>
    </div>
</div>

<c:choose>
    <c:when test="${not empty cart and not empty cart.items}">
        <div class="row g-4">
            <!-- Cột trái: Danh sách sản phẩm trong giỏ -->
            <div class="col-lg-8">
                <div class="card shadow-sm border">
                    <div class="card-header bg-white py-3 d-flex justify-content-between align-items-center">
                        <span class="fw-bold text-dark">
                            Danh sách mặt hàng (<span class="text-primary">${cart.totalItems}</span> loại sản phẩm)
                        </span>
                        <a href="${pageContext.request.contextPath}/cart/clear" 
                           class="btn btn-outline-danger btn-sm"
                           onclick="return confirm('Bạn có chắc muốn xóa sạch toàn bộ giỏ hàng?');">
                            <i class="fa-solid fa-trash-can me-1"></i> Xóa tất cả
                        </a>
                    </div>

                    <div class="table-responsive">
                        <table class="table table-hover align-middle mb-0">
                            <thead class="table-light">
                                <tr>
                                    <th class="ps-3" style="width: 100px;">Sản phẩm</th>
                                    <th>Thông tin</th>
                                    <th class="text-center" style="width: 130px;">Đơn giá</th>
                                    <th class="text-center" style="width: 180px;">Số lượng</th>
                                    <th class="text-center" style="width: 140px;">Thành tiền</th>
                                    <th class="text-center" style="width: 60px;">Xóa</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="item" items="${cart.items}">
                                    <tr>
                                        <!-- Hình ảnh -->
                                        <td class="ps-3">
                                            <c:choose>
                                                <c:when test="${not empty item.product.images}">
                                                    <img src="${item.product.images}" alt="${item.product.productName}" 
                                                         class="img-fluid rounded border" style="width: 70px; height: 70px; object-fit: cover;">
                                                </c:when>
                                                <c:otherwise>
                                                    <div class="bg-light rounded border text-center py-3 text-muted small" style="width: 70px; height: 70px;">
                                                        <i class="fa-regular fa-image fa-2x"></i>
                                                    </div>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>

                                        <!-- Tên & Người bán -->
                                        <td>
                                            <a href="${pageContext.request.contextPath}/product/detail?id=${item.product.productId}" 
                                               class="text-decoration-none fw-bold text-dark d-block">
                                                ${item.product.productName}
                                            </a>
                                            <small class="text-muted d-block">
                                                Mã: <code>${item.product.productCode}</code>
                                            </small>
                                            <small class="text-muted d-block">
                                                Cửa hàng: <span class="badge bg-light text-secondary border">${item.product.seller != null ? item.product.seller.sellername : 'N/A'}</span>
                                            </small>
                                        </td>

                                        <!-- Đơn giá -->
                                        <td class="text-center fw-semibold text-danger">
                                            ${item.formattedUnitPrice} ₫
                                        </td>

                                        <!-- Bộ điều khiển số lượng (Tăng, Giảm, Nhập trực tiếp có giới hạn) -->
                                        <td class="text-center">
                                            <div class="d-flex align-items-center justify-content-center">
                                                <!-- Nút Giảm -->
                                                <a href="${pageContext.request.contextPath}/cart/decrease?id=${item.product.productId}" 
                                                   class="btn btn-outline-secondary btn-sm px-2 ${item.quantity <= 1 ? 'disabled' : ''}" 
                                                   title="Giảm 1">
                                                    <i class="fa-solid fa-minus"></i>
                                                </a>

                                                <!-- Form nhập số lượng trực tiếp -->
                                                <form action="${pageContext.request.contextPath}/cart/update" method="post" class="mx-1 my-0">
                                                    <input type="hidden" name="productId" value="${item.product.productId}" />
                                                    <input type="number" name="quantity" value="${item.quantity}" 
                                                           min="1" max="${item.maxLimit}" 
                                                           class="form-control form-control-sm text-center fw-bold" 
                                                           style="width: 60px;" 
                                                           onchange="this.form.submit()" 
                                                           title="Nhập số lượng rồi nhấn Enter để cập nhật" />
                                                </form>

                                                <!-- Nút Tăng -->
                                                <a href="${pageContext.request.contextPath}/cart/increase?id=${item.product.productId}" 
                                                   class="btn btn-outline-secondary btn-sm px-2 ${item.quantity >= item.maxLimit ? 'disabled' : ''}" 
                                                   title="Tăng 1">
                                                    <i class="fa-solid fa-plus"></i>
                                                </a>
                                            </div>
                                            <div class="small text-muted mt-1" style="font-size: 11px;">
                                                (Tối đa: <strong class="text-primary">${item.maxLimit}</strong>)
                                            </div>
                                        </td>

                                        <!-- Thành tiền -->
                                        <td class="text-center fw-bold text-primary">
                                            ${item.formattedTotalPrice} ₫
                                        </td>

                                        <!-- Nút Xóa -->
                                        <td class="text-center">
                                            <a href="${pageContext.request.contextPath}/cart/delete?id=${item.product.productId}" 
                                               class="btn btn-outline-danger btn-sm" 
                                               title="Xóa sản phẩm này"
                                               onclick="return confirm('Bạn có chắc muốn xóa ${item.product.productName} khỏi giỏ hàng?');">
                                                <i class="fa-solid fa-trash-can"></i>
                                            </a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>

                    <div class="card-footer bg-white py-3 d-flex justify-content-between align-items-center">
                        <a href="${pageContext.request.contextPath}/products" class="btn btn-outline-secondary">
                            <i class="fa-solid fa-arrow-left me-1"></i> Tiếp tục chọn sản phẩm
                        </a>
                        <span class="text-muted small">
                            Thay đổi số lượng sẽ tự động cập nhật tổng tiền
                        </span>
                    </div>
                </div>
            </div>

            <!-- Cột phải: Tóm tắt đơn hàng & Nút Thanh toán -->
            <div class="col-lg-4">
                <div class="card shadow-sm border mb-4">
                    <div class="card-header bg-primary text-white py-3">
                        <h5 class="mb-0 fw-bold">
                            <i class="fa-solid fa-receipt me-2"></i>Tóm Tắt Đơn Hàng
                        </h5>
                    </div>
                    <div class="card-body p-4">
                        <div class="d-flex justify-content-between mb-2">
                            <span class="text-muted">Tổng số lượng hàng:</span>
                            <span class="fw-bold">${cart.totalQuantity} món</span>
                        </div>
                        <div class="d-flex justify-content-between mb-2">
                            <span class="text-muted">Tạm tính:</span>
                            <span class="fw-semibold">
                                ${cart.formattedTotalAmount} ₫
                            </span>
                        </div>
                        <div class="d-flex justify-content-between mb-3">
                            <span class="text-muted">Phí giao hàng:</span>
                            <span class="text-success fw-semibold">Miễn phí</span>
                        </div>
                        <hr>
                        <div class="d-flex justify-content-between align-items-center mb-4">
                            <span class="fs-5 fw-bold text-dark">Tổng thanh toán:</span>
                            <span class="fs-4 fw-bold text-danger">
                                ${cart.formattedTotalAmount} ₫
                            </span>
                        </div>

                        <c:choose>
                            <c:when test="${not empty sessionScope.currentUser}">
                                <div class="alert alert-light border small mb-3">
                                    <i class="fa-solid fa-user-check text-success me-1"></i> Tài khoản: <strong>${sessionScope.currentUser.fullname}</strong>
                                </div>
                                <a href="${pageContext.request.contextPath}/cart/checkout" class="btn btn-success w-100 py-2 fw-bold shadow-sm">
                                    <i class="fa-solid fa-truck-fast me-2"></i>Tiến Hành Thanh Toán COD
                                </a>
                            </c:when>
                            <c:otherwise>
                                <div class="alert alert-warning small mb-3">
                                    <i class="fa-solid fa-triangle-exclamation me-1"></i> Bạn cần đăng nhập để thanh toán.
                                </div>
                                <a href="${pageContext.request.contextPath}/login" class="btn btn-primary w-100 py-2 fw-bold shadow-sm">
                                    <i class="fa-solid fa-right-to-bracket me-2"></i>Đăng Nhập Để Thanh Toán
                                </a>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>

                <div class="card border-0 bg-light p-3 rounded shadow-sm">
                    <h6 class="fw-bold text-dark mb-2"><i class="fa-solid fa-shield-halved text-primary me-2"></i>Chính sách mua hàng:</h6>
                    <ul class="text-muted small ps-3 mb-0">
                        <li>Được kiểm tra hàng trước khi nhận.</li>
                        <li>Đổi trả trong vòng 7 ngày nếu lỗi từ nhà sản xuất.</li>
                        <li>Hỗ trợ khách hàng 24/7 qua hệ thống.</li>
                    </ul>
                </div>
            </div>
        </div>
    </c:when>
    <c:otherwise>
        <!-- Giao diện khi giỏ hàng trống -->
        <div class="row justify-content-center py-5">
            <div class="col-md-7 col-lg-5 text-center">
                <div class="card border-0 shadow-sm p-5">
                    <div class="mb-4">
                        <i class="fa-solid fa-cart-arrow-down text-primary opacity-50" style="font-size: 80px;"></i>
                    </div>
                    <h4 class="fw-bold text-dark mb-2">Giỏ hàng của bạn đang trống!</h4>
                    <p class="text-muted mb-4">
                        Hãy khám phá danh mục hàng ngàn sản phẩm đa dạng và thêm các mặt hàng yêu thích vào giỏ hàng ngay hôm nay.
                    </p>
                    <a href="${pageContext.request.contextPath}/products" class="btn btn-primary px-4 py-2 fw-semibold shadow-sm">
                        <i class="fa-solid fa-store me-2"></i>Khám Phá Sản Phẩm Ngay
                    </a>
                </div>
            </div>
        </div>
    </c:otherwise>
</c:choose>

</body>
</html>
