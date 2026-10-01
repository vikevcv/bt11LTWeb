package vn.edu.hcmute.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vn.edu.hcmute.model.Product;
import vn.edu.hcmute.model.Seller;
import vn.edu.hcmute.service.ProductService_24110240;

import java.io.IOException;
import java.util.List;
import java.util.Map;

@WebServlet(name = "ProductPublicController_24110240", urlPatterns = {"/products", "/product/detail"})
public class ProductPublicController_24110240 extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private final ProductService_24110240 productService = new ProductService_24110240();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String servletPath = req.getServletPath();

        if ("/product/detail".equals(servletPath)) {
            showProductDetail(req, resp); // Câu 4
        } else {
            showProductsGroupedBySeller(req, resp); // Câu 3
        }
    }

    /**
     * Câu 3: Trang hiển thị tất cả sản phẩm gom theo từng seller (theo mã cửa hàng SellerID)
     */
    private void showProductsGroupedBySeller(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        Map<Seller, List<Product>> sellerProductMap = productService.getProductsGroupedBySeller();
        req.setAttribute("sellerProductMap", sellerProductMap);
        req.setAttribute("pageTitle", "Sản phẩm theo từng Cửa Hàng (Seller)");
        req.getRequestDispatcher("/WEB-INF/views/user/products-by-seller.jsp").forward(req, resp);
    }

    /**
     * Câu 4: Trang chi tiết 01 sản phẩm khi bấm vào sản phẩm ở Câu 3
     */
    private void showProductDetail(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            int productId = Integer.parseInt(req.getParameter("id"));
            Product product = productService.getProductById(productId);

            if (product != null) {
                req.setAttribute("product", product);
                req.setAttribute("pageTitle", "Chi tiết: " + product.getProductName());
                req.getRequestDispatcher("/WEB-INF/views/user/product-detail.jsp").forward(req, resp);
            } else {
                resp.sendRedirect(req.getContextPath() + "/products");
            }
        } catch (Exception e) {
            resp.sendRedirect(req.getContextPath() + "/products");
        }
    }
}
