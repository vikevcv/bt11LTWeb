package vn.edu.hcmute.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import vn.edu.hcmute.dao.ProductDAO_24110240;
import vn.edu.hcmute.model.Product;
import vn.edu.hcmute.model.User;
import vn.edu.hcmute.service.ProductService_24110240;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "SellerHomeController_24110240", urlPatterns = {"/seller/home"})
public class SellerHomeController_24110240 extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private final ProductService_24110240 productService = new ProductService_24110240();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User currentUser = (User) session.getAttribute("currentUser");

        if (currentUser != null && currentUser.getSeller() != null) {
            req.setAttribute("seller", currentUser.getSeller());
            List<Product> myProducts = new ProductDAO_24110240().findBySellerId(currentUser.getSeller().getSellerId());
            req.setAttribute("products", myProducts);
        }

        req.setAttribute("pageTitle", "Trang Chủ Người Bán (Seller)");
        req.getRequestDispatcher("/WEB-INF/views/seller/home.jsp").forward(req, resp);
    }
}
