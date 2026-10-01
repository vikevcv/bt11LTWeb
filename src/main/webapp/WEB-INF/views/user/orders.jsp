<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Lịch Sử Đơn Hàng - HCMUTE Store</title>
    <style>
        .order-status-nav {
            overflow-x: auto;
            white-space: nowrap;
            flex-wrap: nowrap;
            scrollbar-width: thin;
        }
        .order-status-nav .nav-link {
            border-radius: 8px;
            padding: 8px 16px;
            font-weight: 500;
            color: #495057;
            white-space: nowrap;
            transition: all 0.2s ease-in-out;
        }
        .order-status-nav .nav-link:hover {
            background-color: #f1f3f5;
            color: #0d6efd;
        }
        .order-status-nav .nav-link.active {
            background-color: #0d6efd;
            color: #ffffff !important;
            font-weight: 600;
            box-shadow: 0 2px 6px rgba(13, 110, 253, 0.3);
        }
        .order-status-nav .nav-link.active .badge {
            background-color: #ffffff !important;
            color: #0d6efd !important;
        }
    </style>
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
        <div class="d-flex flex-wrap justify-content-between align-items-center gap-2">
            <div>
                <h3 class="fw-bold text-primary mb-1">
                    <i class="fa-solid fa-clock-rotate-left me-2"></i>Lịch Sử Đơn Hàng
                </h3>
                <p class="text-muted small mb-0">Theo dõi tiến trình xử lý và lộ trình vận chuyển của từng đơn hàng.</p>
            </div>
            <a href="${pageContext.request.contextPath}/products" class="btn btn-outline-primary btn-sm">
                <i class="fa-solid fa-store me-1"></i> Khám phá sản phẩm
            </a>
        </div>
    </div>
</div>

<!-- Thanh Tabs Lọc Trạng Thái Đơn Hàng (8 trạng thái theo yêu cầu) -->
<div class="card border-0 shadow-sm mb-4">
    <div class="card-body p-2">
        <ul class="nav nav-pills order-status-nav gap-1">
            <!-- 0. Tất cả -->
            <li class="nav-item">
                <a class="nav-link ${currentStatus == 'all' ? 'active' : ''}" 
                   href="${pageContext.request.contextPath}/cart/my-orders?status=all">
                    <i class="fa-solid fa-border-all me-1"></i> Tất cả
                    <span class="badge rounded-pill bg-light text-dark ms-1">${totalOrders}</span>
                </a>
            </li>

            <!-- 1. Đơn hàng mới (0) -->
            <li class="nav-item">
                <a class="nav-link ${currentStatus == '0' ? 'active' : ''}" 
                   href="${pageContext.request.contextPath}/cart/my-orders?status=0">
                    <i class="fa-solid fa-file-circle-plus me-1 text-info"></i> Đơn hàng mới
                    <span class="badge rounded-pill bg-light text-dark ms-1">${not empty counts['0'] ? counts['0'] : 0}</span>
                </a>
            </li>

            <!-- 2. Đã xác nhận (1) -->
            <li class="nav-item">
                <a class="nav-link ${currentStatus == '1' ? 'active' : ''}" 
                   href="${pageContext.request.contextPath}/cart/my-orders?status=1">
                    <i class="fa-solid fa-clipboard-check me-1 text-primary"></i> Đã xác nhận
                    <span class="badge rounded-pill bg-light text-dark ms-1">${not empty counts['1'] ? counts['1'] : 0}</span>
                </a>
            </li>

            <!-- 3. Chuẩn bị hàng (2) -->
            <li class="nav-item">
                <a class="nav-link ${currentStatus == '2' ? 'active' : ''}" 
                   href="${pageContext.request.contextPath}/cart/my-orders?status=2">
                    <i class="fa-solid fa-boxes-packing me-1 text-warning"></i> Chuẩn bị hàng
                    <span class="badge rounded-pill bg-light text-dark ms-1">${not empty counts['2'] ? counts['2'] : 0}</span>
                </a>
            </li>

            <!-- 4. Vận chuyển (3) -->
            <li class="nav-item">
                <a class="nav-link ${currentStatus == '3' ? 'active' : ''}" 
                   href="${pageContext.request.contextPath}/cart/my-orders?status=3">
                    <i class="fa-solid fa-truck-moving me-1 text-secondary"></i> Vận chuyển
                    <span class="badge rounded-pill bg-light text-dark ms-1">${not empty counts['3'] ? counts['3'] : 0}</span>
                </a>
            </li>

            <!-- 5. Giao hàng (4) -->
            <li class="nav-item">
                <a class="nav-link ${currentStatus == '4' ? 'active' : ''}" 
                   href="${pageContext.request.contextPath}/cart/my-orders?status=4">
                    <i class="fa-solid fa-motorcycle me-1 text-info"></i> Giao hàng
                    <span class="badge rounded-pill bg-light text-dark ms-1">${not empty counts['4'] ? counts['4'] : 0}</span>
                </a>
            </li>

            <!-- 6. Đã giao (5) -->
            <li class="nav-item">
                <a class="nav-link ${currentStatus == '5' ? 'active' : ''}" 
                   href="${pageContext.request.contextPath}/cart/my-orders?status=5">
                    <i class="fa-solid fa-circle-check me-1 text-success"></i> Đã giao
                    <span class="badge rounded-pill bg-light text-dark ms-1">${not empty counts['5'] ? counts['5'] : 0}</span>
                </a>
            </li>

            <!-- 7. Đơn hàng hủy (6) -->
            <li class="nav-item">
                <a class="nav-link ${currentStatus == '6' ? 'active' : ''}" 
                   href="${pageContext.request.contextPath}/cart/my-orders?status=6">
                    <i class="fa-solid fa-ban me-1 text-danger"></i> Đơn hàng hủy
                    <span class="badge rounded-pill bg-light text-dark ms-1">${not empty counts['6'] ? counts['6'] : 0}</span>
                </a>
            </li>

            <!-- 8. Đơn hàng hoàn (7) -->
            <li class="nav-item">
                <a class="nav-link ${currentStatus == '7' ? 'active' : ''}" 
                   href="${pageContext.request.contextPath}/cart/my-orders?status=7">
                    <i class="fa-solid fa-rotate-left me-1 text-dark"></i> Đơn hàng hoàn
                    <span class="badge rounded-pill bg-light text-dark ms-1">${not empty counts['7'] ? counts['7'] : 0}</span>
                </a>
            </li>
        </ul>
    </div>
</div>

<!-- Danh sách đơn hàng -->
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
                                    <i class="fa-solid fa-money-bill-wave me-1"></i> ${order.paymentMethod}
                                </span>
                            </div>
                            <div>
                                <span class="badge ${order.statusBadgeClass} fs-6 px-3 py-2">
                                    <i class="${order.statusIconClass} me-1"></i> ${order.statusText}
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
                                        <h6 class="fw-bold text-secondary mb-1 small text-uppercase">Tổng thanh toán (${order.paymentMethod})</h6>
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
                                            <i class="fa-solid fa-circle-info me-1"></i> Xem hóa đơn chi tiết
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
        <!-- Khi không tìm thấy đơn hàng nào ở trạng thái lọc -->
        <div class="row justify-content-center py-5">
            <div class="col-md-7 col-lg-5 text-center">
                <div class="card border-0 shadow-sm p-5">
                    <div class="mb-4">
                        <i class="fa-solid fa-box-open text-primary opacity-50" style="font-size: 80px;"></i>
                    </div>
                    <h4 class="fw-bold text-dark mb-2">Không tìm thấy đơn hàng nào!</h4>
                    <p class="text-muted mb-4">
                        Hiện tại không có đơn hàng nào trong mục này. Quý khách có thể chuyển qua các trạng thái khác hoặc mua sắm sản phẩm mới.
                    </p>
                    <c:choose>
                        <c:when test="${currentStatus != 'all'}">
                            <a href="${pageContext.request.contextPath}/cart/my-orders?status=all" class="btn btn-primary px-4 py-2 fw-semibold shadow-sm">
                                <i class="fa-solid fa-border-all me-2"></i>Xem Tất Cả Đơn Hàng
                            </a>
                        </c:when>
                        <c:otherwise>
                            <a href="${pageContext.request.contextPath}/products" class="btn btn-primary px-4 py-2 fw-semibold shadow-sm">
                                <i class="fa-solid fa-bag-shopping me-2"></i>Mua Sắm Ngay
                            </a>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </c:otherwise>
</c:choose>

</body>
</html>
