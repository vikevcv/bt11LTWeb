<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Đăng Ký Tài Khoản</title>
</head>
<body>

<div class="row justify-content-center">
    <div class="col-md-7 col-lg-6">
        <div class="card shadow-sm border">
            <div class="card-header bg-success text-white text-center py-3">
                <h4 class="mb-0 fw-bold"><i class="fa-solid fa-user-plus me-2"></i>Đăng Ký Tài Khoản</h4>
                <small class="text-white-50">Hệ thống sẽ gửi mã xác thực OTP qua Email để kích hoạt tài khoản</small>
            </div>
            <div class="card-body p-4">
                <form action="${pageContext.request.contextPath}/register" method="post">
                    <div class="mb-3">
                        <label for="username" class="form-label fw-semibold">Tên đăng nhập <span class="text-danger">*</span></label>
                        <input type="text" class="form-control" id="username" name="username" 
                               value="${username}" placeholder="Nhập tên đăng nhập..." required autofocus>
                    </div>

                    <div class="mb-3">
                        <label for="email" class="form-label fw-semibold">Địa chỉ Email <span class="text-danger">*</span></label>
                        <input type="email" class="form-control" id="email" name="email" 
                               value="${email}" placeholder="example@gmail.com" required>
                        <div class="form-text small">Mã OTP sẽ được gửi về email này (hoặc in trên console STS).</div>
                    </div>

                    <div class="mb-3">
                        <label for="fullname" class="form-label fw-semibold">Họ và tên</label>
                        <input type="text" class="form-control" id="fullname" name="fullname" 
                               value="${fullname}" placeholder="Nguyễn Văn A">
                    </div>

                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="password" class="form-label fw-semibold">Mật khẩu <span class="text-danger">*</span></label>
                            <input type="password" class="form-control" id="password" name="password" 
                                   placeholder="Tối thiểu 6 ký tự..." required>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label for="phone" class="form-label fw-semibold">Số điện thoại</label>
                            <input type="tel" class="form-control" id="phone" name="phone" 
                                   value="${phone}" placeholder="0901234567">
                        </div>
                    </div>

                    <div class="d-grid mb-3">
                        <button type="submit" class="btn btn-success fw-semibold py-2">
                            <i class="fa-solid fa-paper-plane me-2"></i>Đăng Ký & Nhận Mã OTP
                        </button>
                    </div>

                    <div class="text-center small">
                        Đã có tài khoản? <a href="${pageContext.request.contextPath}/login" class="fw-bold">Đăng nhập</a>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

</body>
</html>
