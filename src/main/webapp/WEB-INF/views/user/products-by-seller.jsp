<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Danh Sách Sản Phẩm Theo Từng Cửa Hàng</title>
</head>
<body>

<div class="d-flex justify-content-between align-items-center mb-4">
    <div>
        <h3 class="fw-bold text-primary mb-1">
            <i class="fa-solid fa-store me-2"></i>Danh Sách Sản Phẩm Theo Từng Cửa Hàng
        </h3>
        <p class="text-muted small mb-0">Các sản phẩm được gom nhóm theo mã cửa hàng (SellerID) và nhà bán hàng tương ứng.</p>
    </div>
</div>

<c:choose>
    <c:when test="${not empty sellerProductMap}">
        <c:forEach var="entry" items="${sellerProductMap}">
            <c:set var="seller" value="${entry.key}" />
            <c:set var="productList" value="${entry.value}" />

            <!-- Khối từng Seller -->
            <div class="card mb-4 shadow-sm border">
                <div class="card-header bg-primary text-white py-3 d-flex justify-content-between align-items-center">
                    <h5 class="mb-0 fw-bold">
                        <i class="fa-solid fa-shop me-2"></i>Mã cửa hàng: ${seller.sellerId} - ${seller.sellername}
                    </h5>
                    <span class="badge bg-light text-primary">
                        ${productList != null ? productList.size() : 0} sản phẩm
                    </span>
                </div>

                <div class="card-body p-3">
                    <c:choose>
                        <c:when test="${not empty productList}">
                            <!-- Hiển thị từng sản phẩm theo đúng mẫu content đề bài -->
                            <div class="row g-3">
                                <c:forEach var="prod" items="${productList}">
                                    <div class="col-lg-6">
                                        <div class="border rounded p-3 h-100 bg-white shadow-sm">
                                            <table class="table table-bordered mb-0 align-middle">
                                                <tr>
                                                    <!-- [imageLink] cột bên trái -->
                                                    <td rowspan="6" class="text-center align-middle bg-light" style="width: 140px;">
                                                        <c:choose>
                                                            <c:when test="${not empty prod.images}">
                                                                <img src="${prod.images}" alt="${prod.productName}" 
                                                                     class="img-fluid rounded" style="max-height: 120px; object-fit: cover;">
                                                            </c:when>
                                                            <c:otherwise>
                                                                <div class="text-muted small py-4">
                                                                    <i class="fa-regular fa-image fa-2x d-block mb-1"></i>
                                                                    [imageLink]
                                                                </div>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                    <!-- Cột thông tin chi tiết -->
                                                    <td class="fw-bold bg-light" style="width: 120px;">Tên sản phẩm:</td>
                                                    <td>
                                                        <a href="${pageContext.request.contextPath}/product/detail?id=${prod.productId}" 
                                                           class="text-decoration-none fw-bold text-primary" title="Xem chi tiết sản phẩm">
                                                            ${prod.productName} <i class="fa-solid fa-arrow-up-right-from-square small ms-1"></i>
                                                        </a>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="fw-bold bg-light">Mã sản phẩm:</td>
                                                    <td><span class="badge bg-secondary-subtle text-secondary border">${prod.productCode}</span></td>
                                                </tr>
                                                <tr>
                                                    <td class="fw-bold bg-light">Danh mục:</td>
                                                    <td>${prod.category != null ? prod.category.categoryName : 'Chưa phân loại'}</td>
                                                </tr>
                                                <tr>
                                                    <td class="fw-bold bg-light">Giá:</td>
                                                    <td class="text-danger fw-bold">
                                                        ${prod.formattedPrice} VNĐ
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="fw-bold bg-light">Amount:</td>
                                                    <td>
                                                        <span class="badge bg-info-subtle text-info border">${prod.amount}</span>
                                                        <span class="text-muted small ms-1">(Kho: ${prod.stock})</span>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="fw-bold bg-light">Đặt hàng:</td>
                                                    <td>
                                                        <div class="d-flex align-items-center gap-2">
                                                            <form action="${pageContext.request.contextPath}/cart/add" method="post" class="d-inline my-0">
                                                                <input type="hidden" name="productId" value="${prod.productId}" />
                                                                <input type="hidden" name="quantity" value="1" />
                                                                <button type="submit" class="btn btn-primary btn-sm py-1 px-2">
                                                                    <i class="fa-solid fa-cart-plus me-1"></i> Thêm vào giỏ
                                                                </button>
                                                            </form>
                                                            <a href="${pageContext.request.contextPath}/product/detail?id=${prod.productId}" 
                                                               class="btn btn-outline-secondary btn-sm py-1 px-2">
                                                                Chi tiết
                                                            </a>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="text-center py-4 text-muted">
                                Cửa hàng này hiện chưa có sản phẩm nào.
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </c:forEach>
    </c:when>
    <c:otherwise>
        <div class="alert alert-warning text-center py-5">
            <i class="fa-solid fa-triangle-exclamation fa-2x mb-2 d-block"></i>
            Chưa có dữ liệu Cửa hàng hoặc Sản phẩm nào trong hệ thống!
        </div>
    </c:otherwise>
</c:choose>

</body>
</html>
