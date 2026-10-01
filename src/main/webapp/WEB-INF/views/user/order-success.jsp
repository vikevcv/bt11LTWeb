<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Đặt Hàng Thành Công - Đơn Hàng #${order.cartId}</title>
</head>
<body>

<div class="row justify-content-center py-3">
    <div class="col-lg-9">
        <!-- Banner thành công -->
        <div class="card border-0 shadow-sm text-center p-4 mb-4 bg-white">
            <div class="mb-3">
                <span class="rounded-circle bg-success text-white d-inline-flex align-items-center justify-content-center shadow" style="width: 80px; height: 80px;">
                    <i class="fa-solid fa-check fs-1"></i>
                </span>
            </div>
            <h3 class="fw-bold text-success mb-2">🎉 Đặt Hàng Thành Công!</h3>
            <p class="text-muted mb-3">
                Cảm ơn bạn đã tin tưởng mua sắm tại <strong>HCMUTE Store</strong>. Đơn hàng của bạn đã được ghi nhận và đang chuẩn bị được đóng gói gửi đi.
            </p>
            <div class="d-inline-flex justify-content-center gap-2">
                <span class="badge bg-primary fs-6 px-3 py-2">
                    Mã đơn hàng: #<strong>${order.cartId}</strong>
                </span>
                <span class="badge bg-success fs-6 px-3 py-2">
                    <i class="fa-solid fa-money-bill-wave me-1"></i> Thanh toán khi nhận hàng (COD)
                </span>
            </div>
        </div>

        <div class="row g-4 mb-4">
            <!-- Thông tin người nhận -->
            <div class="col-md-6">
                <div class="card shadow-sm border h-100">
                    <div class="card-header bg-white py-3 fw-bold text-dark">
                        <i class="fa-solid fa-user-check text-primary me-2"></i>Thông Tin Người Nhận
                    </div>
                    <div class="card-body">
                        <p class="mb-2"><strong>Họ tên:</strong> ${order.receiverName}</p>
                        <p class="mb-2"><strong>Số điện thoại:</strong> ${order.receiverPhone}</p>
                        <p class="mb-2"><strong>Địa chỉ giao:</strong> ${order.shippingAddress}</p>
                        <p class="mb-0 text-muted small"><strong>Ghi chú:</strong> ${not empty order.note ? order.note : 'Không có ghi chú'}</p>
                    </div>
                </div>
            </div>

            <!-- Trạng thái & Thanh toán -->
            <div class="col-md-6">
                <div class="card shadow-sm border h-100">
                    <div class="card-header bg-white py-3 fw-bold text-dark">
                        <i class="fa-solid fa-circle-info text-info me-2"></i>Trạng Thái Đơn Hàng
                    </div>
                    <div class="card-body">
                        <p class="mb-2">
                            <strong>Ngày đặt:</strong> 
                            <fmt:formatDate value="${order.buyDate}" pattern="dd/MM/yyyy HH:mm:ss" />
                        </p>
                        <p class="mb-2">
                            <strong>Trạng thái:</strong> 
                            <span class="badge ${order.statusBadgeClass} fs-6">${order.statusText}</span>
                        </p>
                        <p class="mb-2">
                            <strong>Hình thức:</strong> COD (Thu hộ tiền mặt tận nơi)
                        </p>
                        <p class="mb-0 text-success fw-bold">
                            <i class="fa-solid fa-truck me-1"></i> Miễn phí vận chuyển toàn quốc
                        </p>
                    </div>
                </div>
            </div>
        </div>

        <!-- Bảng chi tiết sản phẩm đã đặt -->
        <div class="card shadow-sm border mb-4">
            <div class="card-header bg-white py-3 fw-bold text-dark">
                <i class="fa-solid fa-box-open text-warning me-2"></i>Danh Sách Sản Phẩm Trong Đơn
            </div>
            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0">
                    <thead class="table-light">
                        <tr>
                            <th class="ps-3" style="width: 80px;">Ảnh</th>
                            <th>Tên sản phẩm</th>
                            <th class="text-center" style="width: 140px;">Đơn giá</th>
                            <th class="text-center" style="width: 100px;">Số lượng</th>
                            <th class="text-end pe-3" style="width: 160px;">Thành tiền</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="item" items="${order.cartItems}">
                            <tr>
                                <td class="ps-3">
                                    <c:choose>
                                        <c:when test="${not empty item.product.images}">
                                            <img src="${item.product.images}" alt="${item.product.productName}" 
                                                 class="rounded border" style="width: 50px; height: 50px; object-fit: cover;">
                                        </c:when>
                                        <c:otherwise>
                                            <div class="bg-light rounded border d-flex align-items-center justify-content-center" 
                                                 style="width: 50px; height: 50px;">
                                                <i class="fa-solid fa-box text-muted"></i>
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <span class="fw-bold text-dark d-block">${item.product.productName}</span>
                                    <small class="text-muted">Mã: <code>${item.product.productCode}</code></small>
                                </td>
                                <td class="text-center text-muted fw-semibold">
                                    ${item.formattedUnitPrice} ₫
                                </td>
                                <td class="text-center">
                                    <span class="badge bg-light text-dark border fs-6 px-3">
                                        x${item.quantity}
                                    </span>
                                </td>
                                <td class="text-end pe-3 fw-bold text-primary">
                                    ${item.formattedTotalPrice} ₫
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                    <tfoot class="table-light">
                        <tr>
                            <td colspan="4" class="text-end fw-bold ps-3">Tổng cộng thanh toán (COD):</td>
                            <td class="text-end pe-3 fs-5 fw-bold text-danger">
                                ${order.formattedTotalAmount} ₫
                            </td>
                        </tr>
                    </tfoot>
                </table>
            </div>
        </div>

        <!-- Các nút hành động -->
        <div class="d-flex justify-content-between align-items-center">
            <a href="${pageContext.request.contextPath}/products" class="btn btn-outline-primary px-4 py-2">
                <i class="fa-solid fa-arrow-left me-2"></i>Tiếp Tục Mua Sắm
            </a>
            <a href="${pageContext.request.contextPath}/cart/my-orders" class="btn btn-primary px-4 py-2 fw-semibold">
                <i class="fa-solid fa-clipboard-list me-2"></i>Xem Lịch Sử Đơn Hàng Của Tôi
            </a>
        </div>
    </div>
</div>

</body>
</html>
