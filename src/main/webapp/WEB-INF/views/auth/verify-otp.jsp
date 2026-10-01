<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Kích Hoạt Tài Khoản (OTP)</title>
</head>
<body>

<div class="row justify-content-center">
    <div class="col-md-6 col-lg-5">
        <div class="card shadow-sm border">
            <div class="card-header bg-info text-white text-center py-3">
                <h4 class="mb-0 fw-bold"><i class="fa-solid fa-shield-halved me-2"></i>Kích Hoạt Tài Khoản (OTP)</h4>
            </div>
            <div class="card-body p-4">
                <p class="text-center text-muted small">
                    Hệ thống đã gửi mã OTP 6 chữ số đến email của bạn.<br>
                    Vui lòng kiểm tra hộp thư (hoặc xem dòng log trong <strong>Console STS</strong>) và nhập vào ô dưới đây:
                </p>

                <form action="${pageContext.request.contextPath}/verify-otp" method="post">
                    <div class="mb-3">
                        <label for="username" class="form-label fw-semibold">Tài khoản cần kích hoạt</label>
                        <input type="text" class="form-control bg-light" id="username" name="username" 
                               value="${param.username != null ? param.username : username}" required readonly>
                    </div>

                    <div class="mb-4">
                        <label for="otpCode" class="form-label fw-semibold text-primary">Nhập mã OTP (6 số) <span class="text-danger">*</span></label>
                        <input type="text" class="form-control form-control-lg text-center fw-bold fs-3 letter-spacing-2" 
                               id="otpCode" name="otpCode" placeholder="______" maxlength="6" required autofocus>
                    </div>

                    <div class="d-grid mb-3">
                        <button type="submit" class="btn btn-primary fw-semibold py-2">
                            <i class="fa-solid fa-circle-check me-2"></i>Xác Nhận Kích Hoạt
                        </button>
                    </div>

                    <div class="text-center small">
                        <a href="${pageContext.request.contextPath}/login" class="text-muted">Quay lại trang Đăng nhập</a>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

</body>
</html>
