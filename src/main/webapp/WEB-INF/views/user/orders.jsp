<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Lịch Sử Đơn Hàng - HCMUTE Store</title>
</head>
<body>

<div class="row mb-4">
    <div class="col-12">
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/home">Trang chủ</a></li>
                <li class="breadcrumb-item active" aria-current="page">Lịch sử đơn hàng</li>
            </ol>
        </nav>
        <div class="d-flex justify-content-between align-items-center">
            <div>
                <h3 class="fw-bold text-primary mb-1">
                    <i class="fa-solid fa-clock-rotate-left me-2"></i>Lịch Sử Đơn Hàng Của Bạn
                </h3>
                <p class="text-muted small mb-0">Theo dõi tiến độ giao hàng và thông tin các đơn hàng đã đặt thanh toán COD.</p>
            </div>
            <a href="${pageContext.request.contextPath}/products" class="btn btn-outline-primary btn-sm">
                <i class="fa-solid fa-store me-1"></i> Mua thêm sản phẩm
            </a>
        </div>
    </div>
</div>

<c:choose>
    <c:when test="${not empty orders}">
        <div class="row g-4">
            <c:forEach var="order" items="${orders}">
                <div class="col-12">
                    <div class="card shadow-sm border">
                        <div class="card-header bg-light py-3 d-flex flex-wrap justify-content-between align-items-center gap-2">
                            <div>
                                <span class="fw-bold text-dark fs-6 me-3">
                                    <i class="fa-solid fa-receipt text-primary me-1"></i> Mã đơn: #<strong>${order.cartId}</strong>
                                </span>
                                <span class="text-muted small me-3">
                                    <i class="fa-regular fa-calendar-days me-1"></i>
                                    <fmt:formatDate value="${order.buyDate}" pattern="dd/MM/yyyy HH:mm" />
                                </span>
                                <span class="badge bg-success-subtle text-success border border-success me-2">
                                    <i class="fa-solid fa-money-bill-wave me-1"></i> COD
                                </span>
                            </div>
                            <div>
                                <span class="badge ${order.statusBadgeClass} fs-6 px-3 py-2">
                                    ${order.statusText}
                                </span>
                            </div>
                        </div>

                        <div class="card-body p-4">
                            <div class="row g-3">
                                <!-- Thông tin giao hàng -->
                                <div class="col-md-4 border-end">
                                    <h6 class="fw-bold text-secondary mb-2 small text-uppercase">Địa chỉ giao hàng</h6>
                                    <p class="mb-1 fw-bold text-dark">${order.receiverName}</p>
                                    <p class="mb-1 text-muted small"><i class="fa-solid fa-phone me-1"></i> ${order.receiverPhone}</p>
                                    <p class="mb-2 text-muted small"><i class="fa-solid fa-location-dot me-1"></i> ${order.shippingAddress}</p>
                                    <c:if test="${not empty order.note}">
                                        <p class="mb-0 text-muted fst-italic small">Ghi chú: ${order.note}</p>
                                    </c:if>
                                </div>

                                <!-- Danh sách sản phẩm -->
                                <div class="col-md-5 border-end">
                                    <h6 class="fw-bold text-secondary mb-2 small text-uppercase">Sản phẩm đã đặt</h6>
                                    <div class="list-group list-group-flush">
                                        <c:forEach var="item" items="${order.cartItems}">
                                            <div class="list-group-item px-0 py-2 d-flex justify-content-between align-items-center border-0">
                                                <div class="d-flex align-items-center">
                                                    <c:choose>
                                                        <c:when test="${not empty item.product.images}">
                                                            <img src="${item.product.images}" alt="${item.product.productName}" 
                                                                 class="rounded border me-2" style="width: 40px; height: 40px; object-fit: cover;">
                                                        </c:when>
                                                        <c:otherwise>
                                                            <div class="bg-light rounded border d-flex align-items-center justify-content-center me-2" 
                                                                 style="width: 40px; height: 40px;">
                                                                <i class="fa-solid fa-box text-muted"></i>
                                                            </div>
                                                        </c:otherwise>
                                                    </c:choose>
                                                    <div>
                                                        <span class="d-block small fw-bold text-dark text-truncate" style="max-width: 220px;">
                                                            ${item.product.productName}
                                                        </span>
                                                        <span class="text-muted small">x${item.quantity} (${item.formattedUnitPrice} ₫)</span>
                                                    </div>
                                                </div>
                                                <span class="fw-semibold small text-dark">${item.formattedTotalPrice} ₫</span>
                                            </div>
                                        </c:forEach>
                                    </div>
                                </div>

                                <!-- Tổng tiền & Chi tiết -->
                                <div class="col-md-3 d-flex flex-column justify-content-between text-md-end">
                                    <div>
                                        <h6 class="fw-bold text-secondary mb-1 small text-uppercase">Tổng thanh toán COD</h6>
                                        <div class="fs-4 fw-bold text-danger mb-2">
                                            ${order.formattedTotalAmount} ₫
                                        </div>
                                        <span class="badge bg-light text-success border">
                                            <i class="fa-solid fa-truck me-1"></i> Miễn phí giao hàng
                                        </span>
                                    </div>
                                    <div class="mt-3">
                                        <a href="${pageContext.request.contextPath}/cart/order-success?id=${order.cartId}" 
                                           class="btn btn-outline-primary btn-sm w-100">
                                            <i class="fa-solid fa-circle-info me-1"></i> Xem chi tiết
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </c:when>
    <c:otherwise>
        <!-- Khi chưa có đơn hàng nào -->
        <div class="row justify-content-center py-5">
            <div class="col-md-7 col-lg-5 text-center">
                <div class="card border-0 shadow-sm p-5">
                    <div class="mb-4">
                        <i class="fa-solid fa-clipboard-question text-primary opacity-50" style="font-size: 80px;"></i>
                    </div>
                    <h4 class="fw-bold text-dark mb-2">Bạn chưa có đơn hàng nào!</h4>
                    <p class="text-muted mb-4">
                        Khám phá ngay hàng trăm mặt hàng hấp dẫn và đặt mua đơn giản với hình thức thanh toán COD tận nhà.
                    </p>
                    <a href="${pageContext.request.contextPath}/products" class="btn btn-primary px-4 py-2 fw-semibold shadow-sm">
                        <i class="fa-solid fa-bag-shopping me-2"></i>Mua Sắm Ngay
                    </a>
                </div>
            </div>
        </div>
    </c:otherwise>
</c:choose>

</body>
</html>
