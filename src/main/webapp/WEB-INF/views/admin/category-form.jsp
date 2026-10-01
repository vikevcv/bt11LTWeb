<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <title>${category.categoryId != null ? 'Cập Nhật Danh Mục' : 'Thêm Mới Danh Mục'}</title>
</head>
<body>

<div class="row justify-content-center">
    <div class="col-lg-8">
        <div class="card shadow-sm border">
            <div class="card-header bg-white py-3 border-bottom">
                <h5 class="mb-0 fw-bold text-primary">
                    <i class="fa-solid ${category.categoryId != null ? 'fa-pen-to-square' : 'fa-plus-circle'} me-2"></i>
                    ${category.categoryId != null ? 'Cập Nhật Danh Mục' : 'Thêm Mới Danh Mục'}
                </h5>
            </div>
            <div class="card-body p-4">
                <form action="${pageContext.request.contextPath}/admin/categories/save" method="post">
                    <input type="hidden" name="categoryId" value="${category.categoryId}" />

                    <div class="mb-3">
                        <label for="categoryName" class="form-label fw-semibold">Tên danh mục <span class="text-danger">*</span></label>
                        <input type="text" class="form-control" id="categoryName" name="categoryName" 
                               value="${category.categoryName}" placeholder="Nhập tên danh mục..." required autofocus>
                    </div>

                    <div class="mb-3">
                        <label for="images" class="form-label fw-semibold">Đường dẫn hình ảnh (URL)</label>
                        <input type="text" class="form-control" id="images" name="images" 
                               value="${category.images}" placeholder="https://example.com/image.jpg">
                    </div>

                    <div class="mb-4">
                        <label for="status" class="form-label fw-semibold">Trạng thái</label>
                        <select class="form-select" id="status" name="status">
                            <option value="1" ${category.status == 1 ? 'selected' : ''}>Hoạt động</option>
                            <option value="0" ${category.status == 0 ? 'selected' : ''}>Tạm ẩn</option>
                        </select>
                    </div>

                    <div class="d-flex justify-content-between pt-3 border-top">
                        <a href="${pageContext.request.contextPath}/admin/categories" class="btn btn-outline-secondary">
                            <i class="fa-solid fa-arrow-left me-1"></i> Quay lại
                        </a>
                        <button type="submit" class="btn btn-primary px-4">
                            <i class="fa-solid fa-floppy-disk me-1"></i> Lưu Danh Mục
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

</body>
</html>
