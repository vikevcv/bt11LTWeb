<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><sitemesh:write property='title'/> - HCMUTE Store</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- FontAwesome 6 -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <style>
        body {
            background-color: #f8f9fa;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }
        .main-content {
            flex: 1 0 auto;
        }
        .footer-exam {
            flex-shrink: 0;
            background-color: #212529;
            color: #f8f9fa;
            padding: 20px 0;
            margin-top: 40px;
        }
    </style>
    <sitemesh:write property='head'/>
</head>
<body>

<!-- Header Decorator (Câu 1: Trang Chủ, Sản phẩm, Đăng nhập, Trang quản trị) -->
<nav class="navbar navbar-expand-lg navbar-dark bg-primary shadow-sm">
    <div class="container">
        <a class="navbar-brand fw-bold" href="${pageContext.request.contextPath}/home">
            <i class="fa-solid fa-store me-2"></i>HCMUTE STORE
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#userNav">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="userNav">
            <ul class="navbar-nav me-auto">
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/home">
                        <i class="fa-solid fa-house me-1"></i> Trang Chủ
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/products">
                        <i class="fa-solid fa-boxes-stacked me-1"></i> Sản phẩm
                    </a>
                </li>

                <!-- Trang quản trị: Chỉ hiển thị khi vai trò là Admin (Yêu cầu Câu 1) -->
                <c:if test="${not empty sessionScope.currentUser and sessionScope.currentUser.role.roleName == 'ADMIN'}">
                    <li class="nav-item">
                        <a class="nav-link text-warning fw-bold" href="${pageContext.request.contextPath}/admin/categories">
                            <i class="fa-solid fa-screwdriver-wrench me-1"></i> Trang Quản Trị
                        </a>
                    </li>
                </c:if>

                <!-- Nếu là Seller thì hiển thị thêm menu Cửa hàng -->
                <c:if test="${not empty sessionScope.currentUser and sessionScope.currentUser.role.roleName == 'SELLER'}">
                    <li class="nav-item">
                        <a class="nav-link text-info fw-bold" href="${pageContext.request.contextPath}/seller/home">
                            <i class="fa-solid fa-shop me-1"></i> Cửa Hàng Của Tôi
                        </a>
                    </li>
                </c:if>
            </ul>

            <ul class="navbar-nav align-items-center">
                <!-- Menu Giỏ Hàng có số lượng badge -->
                <li class="nav-item me-2">
                    <a class="nav-link btn btn-outline-light btn-sm px-3 text-white position-relative" href="${pageContext.request.contextPath}/cart">
                        <i class="fa-solid fa-cart-shopping me-1"></i> Giỏ hàng
                        <span class="badge rounded-pill bg-warning text-dark ms-1 fw-bold">
                            ${sessionScope.cart != null ? sessionScope.cart.totalQuantity : 0}
                        </span>
                    </a>
                </li>

                <c:choose>
                    <c:when test="${not empty sessionScope.currentUser}">
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle text-white fw-semibold" href="#" role="button" data-bs-toggle="dropdown">
                                <i class="fa-solid fa-circle-user me-1"></i> ${sessionScope.currentUser.fullname}
                                <span class="badge bg-light text-dark ms-1">${sessionScope.currentUser.role.roleName}</span>
                            </a>
                            <ul class="dropdown-menu dropdown-menu-end shadow">
                                <li>
                                    <span class="dropdown-item-text text-muted small">
                                        Email: ${sessionScope.currentUser.email}
                                    </span>
                                </li>
                                <li>
                                    <a class="dropdown-item" href="${pageContext.request.contextPath}/cart/my-orders">
                                        <i class="fa-solid fa-clock-rotate-left me-2 text-primary"></i> Đơn hàng của tôi
                                    </a>
                                </li>
                                <li><hr class="dropdown-divider"></li>
                                <li>
                                    <a class="dropdown-item text-danger" href="${pageContext.request.contextPath}/logout">
                                        <i class="fa-solid fa-right-from-bracket me-2"></i> Đăng xuất
                                    </a>
                                </li>
                            </ul>
                        </li>
                    </c:when>
                    <c:otherwise>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/login">
                                <i class="fa-solid fa-right-to-bracket me-1"></i> Đăng nhập
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link btn btn-outline-light btn-sm ms-2 px-3 text-white" href="${pageContext.request.contextPath}/register">
                                <i class="fa-solid fa-user-plus me-1"></i> Đăng ký
                            </a>
                        </li>
                    </c:otherwise>
                </c:choose>
            </ul>
        </div>
    </div>
</nav>

<div class="main-content container py-4">
    <!-- Flash message alerts -->
    <c:if test="${not empty sessionScope.flashMessage}">
        <div class="alert alert-${sessionScope.flashType != null ? sessionScope.flashType : 'info'} alert-dismissible fade show shadow-sm" role="alert">
            <i class="fa-solid ${sessionScope.flashType == 'danger' ? 'fa-triangle-exclamation' : 'fa-circle-check'} me-2"></i>
            <strong>${sessionScope.flashMessage}</strong>
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
        <c:remove var="flashMessage" scope="session" />
        <c:remove var="flashType" scope="session" />
    </c:if>

    <!-- Nội dung trang được SiteMesh tự động tiêm vào đây -->
    <sitemesh:write property='body'/>
</div>

<!-- Footer Decorator: Họ tên, MSSV, Mã đề -->
<footer class="footer-exam">
    <div class="container text-center">
        <div class="row align-items-center">
            <div class="col-md-4 text-md-start mb-2 mb-md-0">
                <i class="fa-solid fa-user me-2 text-primary"></i>
                <strong>Họ và tên:</strong> Hoa Vĩ Khang
            </div>
            <div class="col-md-4 mb-2 mb-md-0">
                <i class="fa-solid fa-id-card me-2 text-warning"></i>
                <strong>MSSV:</strong> 24110240
            </div>
            <div class="col-md-4 text-md-end">
                <i class="fa-solid fa-file-lines me-2 text-info"></i>
                <strong>Mã đề:</strong> <span class="badge bg-danger fs-6">Đề số 05</span>
            </div>
        </div>
        <hr class="border-secondary my-3">
        <small class="text-white-50">
            Trường ĐH Công Nghệ Kỹ Thuật TP.HCM (HCMUTE)
        </small>
    </div>
</footer>

<!-- Bootstrap 5 JS Bundle -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
