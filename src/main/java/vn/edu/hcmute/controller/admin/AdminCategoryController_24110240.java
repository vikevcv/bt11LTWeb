package vn.edu.hcmute.controller.admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import vn.edu.hcmute.model.Category;
import vn.edu.hcmute.service.CategoryService_24110240;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "AdminCategoryController_24110240", urlPatterns = {"/admin/categories", "/admin/categories/*"})
public class AdminCategoryController_24110240 extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private final CategoryService_24110240 categoryService = new CategoryService_24110240();
    private static final int PAGE_SIZE = 5;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String pathInfo = req.getPathInfo();
        if (pathInfo == null) pathInfo = "";

        switch (pathInfo) {
            case "/new":
                showCreateForm(req, resp);
                break;
            case "/edit":
                showEditForm(req, resp);
                break;
            case "/delete":
                deleteCategory(req, resp);
                break;
            default:
                listCategoriesPaginated(req, resp);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String pathInfo = req.getPathInfo();
        if (pathInfo == null) pathInfo = "";

        if ("/save".equals(pathInfo)) {
            saveCategory(req, resp);
        } else {
            resp.sendRedirect(req.getContextPath() + "/admin/categories");
        }
    }

    private void listCategoriesPaginated(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        int page = 1;
        String pageStr = req.getParameter("page");
        if (pageStr != null && !pageStr.isEmpty()) {
            try {
                page = Math.max(1, Integer.parseInt(pageStr));
            } catch (NumberFormatException ignored) {}
        }

        List<Category> categories = categoryService.getCategoriesPaginated(page, PAGE_SIZE);
        int totalPages = categoryService.getTotalPages(PAGE_SIZE);

        req.setAttribute("categories", categories);
        req.setAttribute("currentPage", page);
        req.setAttribute("totalPages", totalPages);
        req.setAttribute("totalCount", categoryService.getTotalCount());
        req.setAttribute("pageTitle", "Quản lý Danh mục (Category)");

        req.getRequestDispatcher("/WEB-INF/views/admin/category-list.jsp").forward(req, resp);
    }

    private void showCreateForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Category category = new Category();
        category.setStatus(1);
        req.setAttribute("category", category);
        req.setAttribute("pageTitle", "Thêm mới Danh mục");
        req.getRequestDispatcher("/WEB-INF/views/admin/category-form.jsp").forward(req, resp);
    }

    private void showEditForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            int id = Integer.parseInt(req.getParameter("id"));
            Category category = categoryService.getCategoryById(id);
            if (category != null) {
                req.setAttribute("category", category);
                req.setAttribute("pageTitle", "Chỉnh sửa Danh mục: " + category.getCategoryName());
                req.getRequestDispatcher("/WEB-INF/views/admin/category-form.jsp").forward(req, resp);
                return;
            }
        } catch (Exception ignored) {}
        resp.sendRedirect(req.getContextPath() + "/admin/categories");
    }

    private void saveCategory(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        try {
            String idStr = req.getParameter("categoryId");
            String categoryName = req.getParameter("categoryName");
            String images = req.getParameter("images");
            String statusStr = req.getParameter("status");

            Integer id = (idStr != null && !idStr.isEmpty()) ? Integer.parseInt(idStr) : null;
            Integer status = (statusStr != null) ? Integer.parseInt(statusStr) : 1;

            Category category = new Category();
            category.setCategoryId(id);
            category.setCategoryName(categoryName != null ? categoryName.trim() : "");
            category.setImages(images != null ? images.trim() : "");
            category.setStatus(status);

            categoryService.saveCategory(category);
            setFlash(req, "success", (id == null) ? "Thêm mới danh mục thành công!" : "Cập nhật danh mục thành công!");
        } catch (Exception e) {
            setFlash(req, "danger", "Lỗi: " + e.getMessage());
        }
        resp.sendRedirect(req.getContextPath() + "/admin/categories");
    }

    private void deleteCategory(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        try {
            int id = Integer.parseInt(req.getParameter("id"));
            categoryService.deleteCategory(id);
            setFlash(req, "success", "Xóa danh mục thành công!");
        } catch (Exception e) {
            setFlash(req, "danger", "Không thể xóa danh mục: Có thể danh mục đang chứa sản phẩm!");
        }
        resp.sendRedirect(req.getContextPath() + "/admin/categories");
    }

    private void setFlash(HttpServletRequest req, String type, String msg) {
        HttpSession session = req.getSession();
        session.setAttribute("flashType", type);
        session.setAttribute("flashMessage", msg);
    }
}
