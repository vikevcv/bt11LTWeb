<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><sitemesh:write property='title'/> - Quản Trị Hệ Thống</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- FontAwesome 6 -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <style>
        body {
            background-color: #f4f6f9;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }
        .admin-sidebar {
            background-color: #212529;
            color: #fff;
            min-height: calc(100vh - 120px);
            border-radius: 8px;
            padding: 20px 10px;
        }
        .admin-sidebar a {
            color: #adb5bd;
            text-decoration: none;
            padding: 10px 15px;
            display: block;
            border-radius: 6px;
            margin-bottom: 5px;
            transition: all 0.2s ease;
        }
        .admin-sidebar a:hover, .admin-sidebar a.active {
            color: #fff;
            background-color: #0d6efd;
        }
        .main-content {
            flex: 1 0 auto;
        }
        .footer-exam {
            flex-shrink: 0;
            background-color: #111417;
            color: #adb5bd;
            padding: 20px 0;
            margin-top: 40px;
        }
    </style>
    <sitemesh:write property='head'/>
</head>
<body>

<!-- Admin Navbar -->
<nav class="navbar navbar-dark bg-dark shadow-sm py-2">
    <div class="container-fluid px-4">
        <a class="navbar-brand fw-bold text-warning" href="${pageContext.request.contextPath}/admin/categories">
            <i class="fa-solid fa-shield-halved me-2"></i>HCMUTE SHOP - QUẢN TRỊ HỆ THỐNG
        </a>
        <div class="d-flex align-items-center">
            <span class="text-light me-3">
                <i class="fa-solid fa-user-gear me-1"></i> ${sessionScope.currentUser != null ? sessionScope.currentUser.fullname : 'Admin'}
            </span>
            <a href="${pageContext.request.contextPath}/home" class="btn btn-outline-info btn-sm me-2">
                <i class="fa-solid fa-arrow-up-right-from-square me-1"></i> Xem Trang Web
            </a>
            <a href="${pageContext.request.contextPath}/logout" class="btn btn-outline-danger btn-sm">
                <i class="fa-solid fa-power-off me-1"></i> Đăng xuất
            </a>
        </div>
    </div>
</nav>

<div class="main-content container-fluid px-4 py-4">
    <div class="row">
        <!-- Sidebar điều hướng Admin -->
        <div class="col-md-3 col-lg-2 mb-3">
            <div class="admin-sidebar shadow-sm">
                <div class="px-3 pb-3 mb-3 border-bottom border-secondary text-uppercase fw-bold small text-muted">
                    Quản lý dữ liệu
                </div>
                <a href="${pageContext.request.contextPath}/admin/categories">
                    <i class="fa-solid fa-tags me-2"></i> Quản lý Category
                </a>
                <a href="${pageContext.request.contextPath}/admin/products">
                    <i class="fa-solid fa-box-open me-2"></i> Quản lý Product
                </a>
                <hr class="border-secondary my-3">
                <a href="${pageContext.request.contextPath}/home">
                    <i class="fa-solid fa-house me-2"></i> Về Trang Chủ
                </a>
            </div>
        </div>

        <!-- Vùng nội dung chính -->
        <div class="col-md-9 col-lg-10">
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

            <!-- Nội dung trang Admin được SiteMesh tiêm vào đây -->
            <sitemesh:write property='body'/>
        </div>
    </div>
</div>

<!-- Footer Decorator: Họ tên, MSSV, Mã đề -->
<footer class="footer-exam">
    <div class="container-fluid px-4 text-center">
        <div class="row align-items-center">
            <div class="col-md-4 text-md-start mb-2 mb-md-0">
                <i class="fa-solid fa-user me-2 text-warning"></i>
                <strong>Họ và tên:</strong> Hoa Vĩ Khang
            </div>
            <div class="col-md-4 mb-2 mb-md-0">
                <i class="fa-solid fa-id-card me-2 text-warning"></i>
                <strong>MSSV:</strong> 24110240
            </div>
            <div class="col-md-4 text-md-end">
                <i class="fa-solid fa-file-lines me-2 text-warning"></i>
                <strong>Mã đề:</strong> <span class="badge bg-danger fs-6">Đề số 05</span>
            </div>
        </div>
        <hr class="border-secondary my-3">
        <small class="text-white-50">
            Hệ Thống Quản Trị - HCMUTE Shop
        </small>
    </div>
</footer>

<!-- Bootstrap 5 JS Bundle -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
