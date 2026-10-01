<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Quản Lý Sản Phẩm (Product)</title>
</head>
<body>

<div class="card shadow-sm border mb-4">
    <div class="card-header bg-white py-3 d-flex justify-content-between align-items-center">
        <h4 class="mb-0 fw-bold text-dark">
            <i class="fa-solid fa-boxes-stacked text-primary me-2"></i>Quản Lý Sản Phẩm (Product)
        </h4>
        <a href="${pageContext.request.contextPath}/admin/products/new" class="btn btn-primary shadow-sm">
            <i class="fa-solid fa-plus-circle me-1"></i> Thêm Sản Phẩm Mới
        </a>
    </div>

    <div class="card-body p-0">
        <div class="table-responsive">
            <table class="table table-hover table-striped align-middle mb-0">
                <thead class="table-light">
                    <tr>
                        <th class="ps-3">#ID</th>
                        <th>Ảnh</th>
                        <th>Tên sản phẩm</th>
                        <th>Mã Code</th>
                        <th>Danh mục</th>
                        <th>Seller</th>
                        <th>Giá</th>
                        <th>Số lượng</th>
                        <th>Trạng thái</th>
                        <th class="text-center" style="width: 140px;">Hành động</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${not empty products}">
                            <c:forEach var="p" items="${products}">
                                <tr>
                                    <td class="ps-3 fw-bold text-muted">${p.productId}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${not empty p.images}">
                                                <img src="${p.images}" alt="${p.productName}" class="rounded" style="width: 45px; height: 45px; object-fit: cover;">
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge bg-light text-muted border">No img</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <div class="fw-semibold text-dark">${p.productName}</div>
                                        <small class="text-muted text-truncate d-block" style="max-width: 200px;">
                                            ${p.description}
                                        </small>
                                    </td>
                                    <td><code>${p.productCode}</code></td>
                                    <td><span class="badge bg-secondary-subtle text-secondary border">${p.category != null ? p.category.categoryName : 'N/A'}</span></td>
                                    <td><span class="badge bg-info-subtle text-info border">${p.seller != null ? p.seller.sellername : 'N/A'}</span></td>
                                    <td class="text-danger fw-bold"><fmt:formatNumber value="${p.price}" pattern="#,###" /> ₫</td>
                                    <td>
                                        <span class="badge bg-light text-dark border">Kho: ${p.stock}</span>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${p.status == 1}">
                                                <span class="badge bg-success-subtle text-success border">Hoạt động</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge bg-secondary-subtle text-secondary border">Ngừng bán</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="text-center">
                                        <a href="${pageContext.request.contextPath}/admin/products/edit?id=${p.productId}" 
                                           class="btn btn-outline-warning btn-sm" title="Sửa">
                                            <i class="fa-solid fa-pen-to-square"></i>
                                        </a>
                                        <a href="${pageContext.request.contextPath}/admin/products/delete?id=${p.productId}" 
                                           class="btn btn-outline-danger btn-sm" title="Xóa"
                                           onclick="return confirm('Bạn có chắc muốn xóa sản phẩm này?');">
                                            <i class="fa-solid fa-trash-can"></i>
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <tr>
                                <td colspan="10" class="text-center py-4 text-muted">Chưa có sản phẩm nào!</td>
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
                Hiển thị trang <strong>${currentPage}</strong> / <strong>${totalPages}</strong> (Tổng: ${totalCount} sản phẩm)
            </span>
            <nav aria-label="Product Pagination">
                <ul class="pagination pagination-sm mb-0">
                    <li class="page-item ${currentPage <= 1 ? 'disabled' : ''}">
                        <a class="page-link" href="${pageContext.request.contextPath}/admin/products?page=${currentPage - 1}">Trước</a>
                    </li>
                    <c:forEach var="i" begin="1" end="${totalPages}">
                        <li class="page-item ${currentPage == i ? 'active' : ''}">
                            <a class="page-link" href="${pageContext.request.contextPath}/admin/products?page=${i}">${i}</a>
                        </li>
                    </c:forEach>
                    <li class="page-item ${currentPage >= totalPages ? 'disabled' : ''}">
                        <a class="page-link" href="${pageContext.request.contextPath}/admin/products?page=${currentPage + 1}">Sau</a>
                    </li>
                </ul>
            </nav>
        </div>
    </c:if>
</div>

</body>
</html>
