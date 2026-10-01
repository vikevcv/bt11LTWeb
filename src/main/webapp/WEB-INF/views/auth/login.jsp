<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Đăng Nhập</title>
</head>
<body>

<div class="row justify-content-center">
    <div class="col-md-6 col-lg-5">
        <div class="card shadow-sm border">
            <div class="card-header bg-primary text-white text-center py-3">
                <h4 class="mb-0 fw-bold"><i class="fa-solid fa-right-to-bracket me-2"></i>Đăng Nhập</h4>
            </div>
            <div class="card-body p-4">
                <form action="${pageContext.request.contextPath}/login" method="post">
                    <div class="mb-3">
                        <label for="username" class="form-label fw-semibold">Tên đăng nhập</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fa-solid fa-user"></i></span>
                            <input type="text" class="form-control" id="username" name="username" 
                                   value="${username}" placeholder="Nhập username..." required autofocus>
                        </div>
                    </div>

                    <div class="mb-3">
                        <label for="password" class="form-label fw-semibold">Mật khẩu</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fa-solid fa-lock"></i></span>
                            <input type="password" class="form-control" id="password" name="password" 
                                   placeholder="Nhập mật khẩu..." required>
                        </div>
                    </div>

                    <div class="d-grid mb-3">
                        <button type="submit" class="btn btn-primary fw-semibold py-2">
                            <i class="fa-solid fa-right-to-bracket me-2"></i>Đăng Nhập
                        </button>
                    </div>

                    <div class="text-center small">
                        Chưa có tài khoản? <a href="${pageContext.request.contextPath}/register" class="fw-bold">Đăng ký ngay</a>
                    </div>
                </form>

            </div>
        </div>
    </div>
</div>

</body>
</html>
