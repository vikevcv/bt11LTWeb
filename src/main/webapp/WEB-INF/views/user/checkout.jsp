<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Thanh Toán Đơn Hàng (COD) - HCMUTE Store</title>
</head>
<body>

<div class="row mb-4">
    <div class="col-12">
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/home">Trang chủ</a></li>
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/cart">Giỏ hàng</a></li>
                <li class="breadcrumb-item active" aria-current="page">Thanh toán COD</li>
            </ol>
        </nav>
        <h3 class="fw-bold text-primary">
            <i class="fa-solid fa-truck-fast me-2"></i>Thanh Toán Đơn Hàng (COD)
        </h3>
        <p class="text-muted small">Vui lòng kiểm tra thông tin người nhận và phương thức thanh toán tiền mặt khi nhận hàng trước khi xác nhận đặt hàng.</p>
    </div>
</div>

<form action="${pageContext.request.contextPath}/cart/checkout" method="post" id="checkoutForm">
    <div class="row g-4">
        <!-- Cột trái: Thông tin nhận hàng & Phương thức thanh toán -->
        <div class="col-lg-7">
            <!-- Card 1: Thông tin người nhận -->
            <div class="card shadow-sm border mb-4">
                <div class="card-header bg-white py-3">
                    <h5 class="mb-0 fw-bold text-dark">
                        <i class="fa-solid fa-location-dot text-danger me-2"></i>1. Địa Chỉ Nhận Hàng
                    </h5>
                </div>
                <div class="card-body p-4">
                    <div class="mb-3">
                        <label for="receiverName" class="form-label fw-semibold">
                            Họ và tên người nhận <span class="text-danger">*</span>
                        </label>
                        <div class="input-group">
                            <span class="input-group-text bg-light"><i class="fa-solid fa-user text-muted"></i></span>
                            <input type="text" class="form-control" id="receiverName" name="receiverName" 
                                   value="${not empty receiverName ? receiverName : currentUser.fullname}" 
                                   placeholder="Ví dụ: Nguyễn Văn A" required>
                        </div>
                    </div>

                    <div class="mb-3">
                        <label for="receiverPhone" class="form-label fw-semibold">
                            Số điện thoại nhận hàng <span class="text-danger">*</span>
                        </label>
                        <div class="input-group">
                            <span class="input-group-text bg-light"><i class="fa-solid fa-phone text-muted"></i></span>
                            <input type="tel" class="form-control" id="receiverPhone" name="receiverPhone" 
                                   value="${not empty receiverPhone ? receiverPhone : currentUser.phone}" 
                                   placeholder="Ví dụ: 0901234567" required>
                        </div>
                    </div>

                    <div class="mb-3">
                        <label for="shippingAddress" class="form-label fw-semibold">
                            Địa chỉ nhận hàng chi tiết <span class="text-danger">*</span>
                        </label>
                        <div class="input-group">
                            <span class="input-group-text bg-light"><i class="fa-solid fa-house text-muted"></i></span>
                            <input type="text" class="form-control" id="shippingAddress" name="shippingAddress" 
                                   value="${shippingAddress}" 
                                   placeholder="Số nhà, tên đường, phường/xã, quận/huyện, tỉnh/thành phố" required>
                        </div>
                        <div class="form-text text-muted">Vui lòng ghi rõ địa chỉ để shipper giao hàng nhanh chóng nhất.</div>
                    </div>

                    <div class="mb-0">
                        <label for="note" class="form-label fw-semibold">
                            Ghi chú cho đơn hàng / Shipper <span class="text-muted small">(Không bắt buộc)</span>
                        </label>
                        <textarea class="form-control" id="note" name="note" rows="2" 
                                  placeholder="Ví dụ: Giao giờ hành chính, gọi điện trước khi giao hàng 15 phút...">${note}</textarea>
                    </div>
                </div>
            </div>

            <!-- Card 2: Phương thức thanh toán COD -->
            <div class="card shadow-sm border mb-4">
                <div class="card-header bg-white py-3">
                    <h5 class="mb-0 fw-bold text-dark">
                        <i class="fa-solid fa-credit-card text-primary me-2"></i>2. Phương Thức Thanh Toán
                    </h5>
                </div>
                <div class="card-body p-4">
                    <div class="border rounded p-3 bg-light border-success">
                        <div class="form-check d-flex align-items-center mb-0">
                            <input class="form-check-input me-3" type="radio" name="paymentMethod" id="paymentCOD" value="COD" checked>
                            <label class="form-check-label w-100 cursor-pointer" for="paymentCOD">
                                <div class="d-flex justify-content-between align-items-center">
                                    <div class="d-flex align-items-center">
                                        <i class="fa-solid fa-money-bill-wave text-success fs-3 me-3"></i>
                                        <div>
                                            <span class="fw-bold text-dark fs-6">Thanh toán khi nhận hàng (COD)</span>
                                            <span class="badge bg-success-subtle text-success border border-success ms-2">Khuyên dùng</span>
                                            <p class="text-muted small mb-0 mt-1">
                                                Quý khách chỉ phải thanh toán tiền mặt trực tiếp cho nhân viên giao hàng khi đã nhận và kiểm tra kiện hàng.
                                            </p>
                                        </div>
                                    </div>
                                    <i class="fa-solid fa-circle-check text-success fs-4"></i>
                                </div>
                            </label>
                        </div>
                    </div>

                    <div class="alert alert-info border-0 mt-3 mb-0 small">
                        <i class="fa-solid fa-circle-info me-1"></i> <strong>Cam kết từ HCMUTE Store:</strong> Đồng kiểm khi nhận hàng. Được hoàn trả hoặc từ chối nhận nếu sản phẩm bị hư hại hoặc không đúng mô tả.
                    </div>
                </div>
            </div>
        </div>

        <!-- Cột phải: Tóm tắt đơn hàng & Xác nhận -->
        <div class="col-lg-5">
            <div class="card shadow-sm border mb-4">
                <div class="card-header bg-primary text-white py-3">
                    <h5 class="mb-0 fw-bold">
                        <i class="fa-solid fa-receipt me-2"></i>Đơn Hàng (${cart.totalQuantity} sản phẩm)
                    </h5>
                </div>
                <div class="card-body p-4">
                    <!-- Danh sách tóm tắt mặt hàng -->
                    <div class="list-group list-group-flush mb-3">
                        <c:forEach var="item" items="${cart.items}">
                            <div class="list-group-item px-0 py-2 d-flex justify-content-between align-items-center">
                                <div class="d-flex align-items-center me-2">
                                    <c:choose>
                                        <c:when test="${not empty item.product.images}">
                                            <img src="${item.product.images}" alt="${item.product.productName}" 
                                                 class="rounded border me-2" style="width: 48px; height: 48px; object-fit: cover;">
                                        </c:when>
                                        <c:otherwise>
                                            <div class="bg-light rounded border d-flex align-items-center justify-content-center me-2" 
                                                 style="width: 48px; height: 48px;">
                                                <i class="fa-solid fa-box text-muted"></i>
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                    <div>
                                        <h6 class="mb-0 small fw-bold text-dark text-truncate" style="max-width: 190px;">
                                            ${item.product.productName}
                                        </h6>
                                        <small class="text-muted">SL: <strong class="text-primary">${item.quantity}</strong> x ${item.formattedUnitPrice} ₫</small>
                                    </div>
                                </div>
                                <span class="fw-semibold text-dark small">
                                    ${item.formattedTotalPrice} ₫
                                </span>
                            </div>
                        </c:forEach>
                    </div>

                    <hr>

                    <div class="d-flex justify-content-between mb-2">
                        <span class="text-muted">Tạm tính hàng hóa:</span>
                        <span class="fw-semibold">${cart.formattedTotalAmount} ₫</span>
                    </div>

                    <div class="d-flex justify-content-between mb-2">
                        <span class="text-muted">Phí giao hàng toàn quốc:</span>
                        <span class="text-success fw-semibold">Miễn phí (0 ₫)</span>
                    </div>

                    <div class="d-flex justify-content-between mb-3">
                        <span class="text-muted">Phí thu hộ COD:</span>
                        <span class="text-success fw-semibold">Miễn phí (0 ₫)</span>
                    </div>

                    <hr>

                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <span class="fs-5 fw-bold text-dark">Tổng cần thanh toán:</span>
                        <span class="fs-4 fw-bold text-danger">
                            ${cart.formattedTotalAmount} ₫
                        </span>
                    </div>

                    <button type="submit" class="btn btn-success btn-lg w-100 fw-bold shadow-sm py-3 mb-2"
                            onclick="return confirm('Quý khách xác nhận đặt mua đơn hàng này bằng hình thức thanh toán khi nhận hàng (COD)?');">
                        <i class="fa-solid fa-check-to-slot me-2"></i>Xác Nhận Đặt Hàng COD
                    </button>

                    <a href="${pageContext.request.contextPath}/cart" class="btn btn-outline-secondary w-100 py-2">
                        <i class="fa-solid fa-arrow-left me-1"></i> Quay lại chỉnh sửa giỏ hàng
                    </a>
                </div>
            </div>

            <div class="card border-0 bg-light p-3 rounded shadow-sm">
                <h6 class="fw-bold text-dark mb-2">
                    <i class="fa-solid fa-handshake-angle text-primary me-2"></i>Quyền lợi người mua COD:
                </h6>
                <ul class="text-muted small ps-3 mb-0">
                    <li>Chỉ thanh toán khi nhận đúng hàng, đủ số lượng.</li>
                    <li>Đổi trả miễn phí trong 7 ngày nếu sản phẩm lỗi.</li>
                    <li>Có hóa đơn/biên nhận điện tử lưu trong tài khoản.</li>
                </ul>
            </div>
        </div>
    </div>
</form>

</body>
</html>
