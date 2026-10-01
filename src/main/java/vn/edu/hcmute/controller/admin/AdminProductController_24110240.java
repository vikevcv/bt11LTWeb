package vn.edu.hcmute.controller.admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import vn.edu.hcmute.dao.CategoryDAO_24110240;
import vn.edu.hcmute.dao.SellerDAO_24110240;
import vn.edu.hcmute.model.Category;
import vn.edu.hcmute.model.Product;
import vn.edu.hcmute.model.Seller;
import vn.edu.hcmute.service.ProductService_24110240;

import java.io.IOException;
import java.util.Date;
import java.util.List;

@WebServlet(name = "AdminProductController_24110240", urlPatterns = {"/admin/products", "/admin/products/*"})
public class AdminProductController_24110240 extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private final ProductService_24110240 productService = new ProductService_24110240();
    private final CategoryDAO_24110240 categoryDAO = new CategoryDAO_24110240();
    private final SellerDAO_24110240 sellerDAO = new SellerDAO_24110240();
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
                deleteProduct(req, resp);
                break;
            default:
                listProductsPaginated(req, resp);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String pathInfo = req.getPathInfo();
        if (pathInfo == null) pathInfo = "";

        if ("/save".equals(pathInfo)) {
            saveProduct(req, resp);
        } else {
            resp.sendRedirect(req.getContextPath() + "/admin/products");
        }
    }

    private void listProductsPaginated(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        int page = 1;
        String pageStr = req.getParameter("page");
        if (pageStr != null && !pageStr.isEmpty()) {
            try {
                page = Math.max(1, Integer.parseInt(pageStr));
            } catch (NumberFormatException ignored) {}
        }

        List<Product> products = productService.getProductsPaginated(page, PAGE_SIZE);
        int totalPages = productService.getTotalPages(PAGE_SIZE);

        req.setAttribute("products", products);
        req.setAttribute("currentPage", page);
        req.setAttribute("totalPages", totalPages);
        req.setAttribute("totalCount", productService.getTotalCount());
        req.setAttribute("pageTitle", "Quản lý Sản phẩm (Product)");

        req.getRequestDispatcher("/WEB-INF/views/admin/product-list.jsp").forward(req, resp);
    }

    private void showCreateForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Product product = new Product();
        product.setStatus(1);

        req.setAttribute("product", product);
        req.setAttribute("categories", categoryDAO.findAll());
        req.setAttribute("sellers", sellerDAO.findAll());
        req.setAttribute("pageTitle", "Thêm mới Sản phẩm");

        req.getRequestDispatcher("/WEB-INF/views/admin/product-form.jsp").forward(req, resp);
    }

    private void showEditForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            int id = Integer.parseInt(req.getParameter("id"));
            Product product = productService.getProductById(id);
            if (product != null) {
                req.setAttribute("product", product);
                req.setAttribute("categories", categoryDAO.findAll());
                req.setAttribute("sellers", sellerDAO.findAll());
                req.setAttribute("pageTitle", "Chỉnh sửa Sản phẩm: " + product.getProductName());

                req.getRequestDispatcher("/WEB-INF/views/admin/product-form.jsp").forward(req, resp);
                return;
            }
        } catch (Exception ignored) {}
        resp.sendRedirect(req.getContextPath() + "/admin/products");
    }

    private void saveProduct(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        try {
            String idStr = req.getParameter("productId");
            String productName = req.getParameter("productName");
            String productCodeStr = req.getParameter("productCode");
            String categoryIdStr = req.getParameter("categoryId");
            String sellerIdStr = req.getParameter("sellerId");
            String description = req.getParameter("description");
            String priceStr = req.getParameter("price");
            String amountStr = req.getParameter("amount");
            String stockStr = req.getParameter("stock");
            String images = req.getParameter("images");
            String statusStr = req.getParameter("status");

            Integer id = (idStr != null && !idStr.isEmpty()) ? Integer.parseInt(idStr) : null;
            Long productCode = (productCodeStr != null && !productCodeStr.isEmpty()) ? Long.parseLong(productCodeStr) : null;
            Float price = (priceStr != null && !priceStr.isEmpty()) ? Float.parseFloat(priceStr) : 0f;
            Integer amount = (amountStr != null && !amountStr.isEmpty()) ? Integer.parseInt(amountStr) : 0;
            Integer stock = (stockStr != null && !stockStr.isEmpty()) ? Integer.parseInt(stockStr) : 0;
            Integer status = (statusStr != null) ? Integer.parseInt(statusStr) : 1;

            Product product = new Product();
            product.setProductId(id);
            product.setProductName(productName != null ? productName.trim() : "");
            product.setProductCode(productCode);
            product.setDescription(description);
            product.setPrice(price);
            product.setAmount(amount);
            product.setStock(stock);
            product.setImages(images != null ? images.trim() : "");
            product.setStatus(status);
            product.setCreateDate(new Date());

            if (categoryIdStr != null && !categoryIdStr.isEmpty()) {
                Category cat = categoryDAO.findById(Integer.parseInt(categoryIdStr));
                product.setCategory(cat);
            }

            if (sellerIdStr != null && !sellerIdStr.isEmpty()) {
                Seller seller = sellerDAO.findById(Integer.parseInt(sellerIdStr));
                product.setSeller(seller);
            }

            productService.saveProduct(product);
            setFlash(req, "success", (id == null) ? "Thêm mới sản phẩm thành công!" : "Cập nhật sản phẩm thành công!");
        } catch (Exception e) {
            setFlash(req, "danger", "Lỗi: " + e.getMessage());
        }
        resp.sendRedirect(req.getContextPath() + "/admin/products");
    }

    private void deleteProduct(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        try {
            int id = Integer.parseInt(req.getParameter("id"));
            productService.deleteProduct(id);
            setFlash(req, "success", "Xóa sản phẩm thành công!");
        } catch (Exception e) {
            setFlash(req, "danger", "Lỗi khi xóa sản phẩm: " + e.getMessage());
        }
        resp.sendRedirect(req.getContextPath() + "/admin/products");
    }

    private void setFlash(HttpServletRequest req, String type, String msg) {
        HttpSession session = req.getSession();
        session.setAttribute("flashType", type);
        session.setAttribute("flashMessage", msg);
    }
}
