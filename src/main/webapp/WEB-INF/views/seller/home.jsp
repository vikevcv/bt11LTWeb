<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Trang Chủ Người Bán</title>
</head>
<body>

<div class="row">
    <div class="col-12 mb-4">
        <div class="card bg-info text-white shadow-sm border-0">
            <div class="card-body p-4 d-flex justify-content-between align-items-center">
                <div>
                    <h3 class="fw-bold mb-1"><i class="fa-solid fa-store me-2"></i>Trang Chủ Người Bán (Seller Dashboard)</h3>
                    <p class="mb-0 text-white-50">
                        Cửa hàng: <strong>${seller != null ? seller.sellername : 'Chưa liên kết cửa hàng'}</strong>
                        (Mã cửa hàng: ${seller != null ? seller.sellerId : 'N/A'})
                    </p>
                </div>
                <div>
                    <span class="badge bg-light text-dark fs-6 px-3 py-2">
                        <i class="fa-solid fa-circle-check text-success me-1"></i> Trạng thái: Đang hoạt động
                    </span>
                </div>
            </div>
        </div>
    </div>

    <!-- Danh sách sản phẩm thuộc seller -->
    <div class="col-12">
        <div class="card shadow-sm border">
            <div class="card-header bg-white py-3 d-flex justify-content-between align-items-center">
                <h5 class="mb-0 fw-bold text-primary">
                    <i class="fa-solid fa-boxes-stacked me-2"></i>Sản Phẩm Của Cửa Hàng
                </h5>
                <span class="badge bg-primary">${products != null ? products.size() : 0} sản phẩm</span>
            </div>
            <div class="card-body p-0">
                <div class="table-responsive">
                    <table class="table table-hover table-striped align-middle mb-0">
                        <thead class="table-light">
                            <tr>
                                <th class="ps-3">#ID</th>
                                <th>Ảnh</th>
                                <th>Tên sản phẩm</th>
                                <th>Mã sản phẩm</th>
                                <th>Danh mục</th>
                                <th>Đơn giá</th>
                                <th>Số lượng</th>
                                <th>Tồn kho</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:choose>
                                <c:when test="${not empty products}">
                                    <c:forEach var="p" items="${products}">
                                        <tr>
                                            <td class="ps-3 fw-bold text-muted">${p.productId}</td>
                                            <td>
                                                <img src="${p.images}" alt="${p.productName}" class="rounded" style="width: 50px; height: 50px; object-fit: cover;">
                                            </td>
                                            <td>
                                                <a href="${pageContext.request.contextPath}/product/detail?id=${p.productId}" class="text-decoration-none fw-semibold">
                                                    ${p.productName}
                                                </a>
                                            </td>
                                            <td><code>${p.productCode}</code></td>
                                            <td>${p.category != null ? p.category.categoryName : 'N/A'}</td>
                                            <td class="text-danger fw-bold"><fmt:formatNumber value="${p.price}" pattern="#,###" /> ₫</td>
                                            <td><span class="badge bg-info">${p.amount}</span></td>
                                            <td><span class="badge bg-secondary">${p.stock}</span></td>
                                        </tr>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <tr>
                                        <td colspan="8" class="text-center py-4 text-muted">
                                            Chưa có sản phẩm nào thuộc cửa hàng này!
                                        </td>
                                    </tr>
                                </c:otherwise>
                            </c:choose>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>

</body>
</html>
