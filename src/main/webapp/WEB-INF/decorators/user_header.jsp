<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${pageTitle != null ? pageTitle : "HCMUTE Store - Hệ Thống Bán Hàng Trực Tuyến"}</title>
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
        .seller-badge {
            background: #e7f1ff;
            color: #0d6efd;
            font-weight: 600;
            border-radius: 6px;
            padding: 4px 10px;
        }
    </style>
</head>
<body>

<!-- Header Navigation -->
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

                <!-- Trang quản trị: Chỉ hiển thị khi vai trò là Admin -->
                <c:if test="${not empty sessionScope.currentUser and sessionScope.currentUser.role.roleName == 'ADMIN'}">
                    <li class="nav-item">
                        <a class="nav-link text-warning fw-bold" href="${pageContext.request.contextPath}/admin/categories">
                            <i class="fa-solid fa-screwdriver-wrench me-1"></i> Trang Quản Trị
                        </a>
                    </li>
                </c:if>

                <!-- Nếu là Seller thì hiện thêm menu cửa hàng -->
                <c:if test="${not empty sessionScope.currentUser and sessionScope.currentUser.role.roleName == 'SELLER'}">
                    <li class="nav-item">
                        <a class="nav-link text-info fw-bold" href="${pageContext.request.contextPath}/seller/home">
                            <i class="fa-solid fa-shop me-1"></i> Cửa Hàng Của Tôi
                        </a>
                    </li>
                </c:if>
            </ul>

            <ul class="navbar-nav">
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
