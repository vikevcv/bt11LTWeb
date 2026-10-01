<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Quản Lý Danh Mục (Category)</title>
</head>
<body>

<div class="card shadow-sm border mb-4">
    <div class="card-header bg-white py-3 d-flex justify-content-between align-items-center">
        <h4 class="mb-0 fw-bold text-dark">
            <i class="fa-solid fa-tags text-primary me-2"></i>Quản Lý Danh Mục (Category)
        </h4>
        <a href="${pageContext.request.contextPath}/admin/categories/new" class="btn btn-primary shadow-sm">
            <i class="fa-solid fa-plus-circle me-1"></i> Thêm Danh Mục
        </a>
    </div>

    <div class="card-body p-0">
        <div class="table-responsive">
            <table class="table table-hover table-striped align-middle mb-0">
                <thead class="table-light">
                    <tr>
                        <th class="ps-3" style="width: 80px;">#ID</th>
                        <th style="width: 80px;">Hình ảnh</th>
                        <th>Tên danh mục</th>
                        <th>Trạng thái</th>
                        <th class="text-center" style="width: 150px;">Hành động</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${not empty categories}">
                            <c:forEach var="c" items="${categories}">
                                <tr>
                                    <td class="ps-3 fw-bold text-muted">${c.categoryId}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${not empty c.images}">
                                                <img src="${c.images}" alt="${c.categoryName}" class="rounded" style="width: 45px; height: 45px; object-fit: cover;">
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge bg-light text-muted border">No img</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="fw-semibold text-dark">${c.categoryName}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${c.status == 1}">
                                                <span class="badge bg-success-subtle text-success border">Hoạt động</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge bg-secondary-subtle text-secondary border">Tạm ẩn</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="text-center">
                                        <a href="${pageContext.request.contextPath}/admin/categories/edit?id=${c.categoryId}" 
                                           class="btn btn-outline-warning btn-sm" title="Sửa">
                                            <i class="fa-solid fa-pen-to-square"></i>
                                        </a>
                                        <a href="${pageContext.request.contextPath}/admin/categories/delete?id=${c.categoryId}" 
                                           class="btn btn-outline-danger btn-sm" title="Xóa"
                                           onclick="return confirm('Bạn có chắc muốn xóa danh mục này?');">
                                            <i class="fa-solid fa-trash-can"></i>
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <tr>
                                <td colspan="5" class="text-center py-4 text-muted">Chưa có danh mục nào!</td>
                            </tr>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
        </div>
    </div>

    <!-- Phân trang Pagination -->
    <c:if test="${totalPages > 1}">
        <div class="card-footer bg-white py-3 d-flex justify-content-between align-items-center">
            <span class="text-muted small">
                Hiển thị trang <strong>${currentPage}</strong> / <strong>${totalPages}</strong> (Tổng: ${totalCount} danh mục)
            </span>
            <nav aria-label="Category Pagination">
                <ul class="pagination pagination-sm mb-0">
                    <li class="page-item ${currentPage <= 1 ? 'disabled' : ''}">
                        <a class="page-link" href="${pageContext.request.contextPath}/admin/categories?page=${currentPage - 1}">Trước</a>
                    </li>
                    <c:forEach var="i" begin="1" end="${totalPages}">
                        <li class="page-item ${currentPage == i ? 'active' : ''}">
                            <a class="page-link" href="${pageContext.request.contextPath}/admin/categories?page=${i}">${i}</a>
                        </li>
                    </c:forEach>
                    <li class="page-item ${currentPage >= totalPages ? 'disabled' : ''}">
                        <a class="page-link" href="${pageContext.request.contextPath}/admin/categories?page=${currentPage + 1}">Sau</a>
                    </li>
                </ul>
            </nav>
        </div>
    </c:if>
</div>

</body>
</html>
