package vn.edu.hcmute.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import vn.edu.hcmute.model.Cart;
import vn.edu.hcmute.model.Cart_24110240;
import vn.edu.hcmute.model.User;
import vn.edu.hcmute.service.CartService_24110240;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "CartController_24110240", urlPatterns = {"/cart", "/cart/*"})
public class CartController_24110240 extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private final CartService_24110240 cartService = new CartService_24110240();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String pathInfo = req.getPathInfo();
        if (pathInfo == null) pathInfo = "";

        switch (pathInfo) {
            case "/add":
                handleAdd(req, resp);
                break;
            case "/increase":
                handleIncrease(req, resp);
                break;
            case "/decrease":
                handleDecrease(req, resp);
                break;
            case "/delete":
                handleDelete(req, resp);
                break;
            case "/clear":
                handleClear(req, resp);
                break;
            case "/checkout":
                showCheckout(req, resp);
                break;
            case "/order-success":
                showOrderSuccess(req, resp);
                break;
            case "/my-orders":
                showMyOrders(req, resp);
                break;
            default:
                showCart(req, resp);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String pathInfo = req.getPathInfo();
        if (pathInfo == null) pathInfo = "";

        switch (pathInfo) {
            case "/add":
                handleAdd(req, resp);
                break;
            case "/update":
                handleUpdate(req, resp);
                break;
            case "/checkout":
                handleCheckoutCOD(req, resp);
                break;
            default:
                resp.sendRedirect(req.getContextPath() + "/cart");
                break;
        }
    }

    private void showCart(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Cart_24110240 cart = cartService.getCart(req.getSession());
        req.setAttribute("cart", cart);
        req.setAttribute("pageTitle", "Giỏ Hàng Của Bạn");
        req.getRequestDispatcher("/WEB-INF/views/user/cart.jsp").forward(req, resp);
    }

    private void handleAdd(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        try {
            int productId = Integer.parseInt(req.getParameter("productId"));
            int quantity = 1;
            String qtyStr = req.getParameter("quantity");
            if (qtyStr != null && !qtyStr.trim().isEmpty()) {
                quantity = Math.max(1, Integer.parseInt(qtyStr.trim()));
            }

            Cart_24110240 cart = cartService.getCart(req.getSession());
            int result = cartService.addToCart(cart, productId, quantity);

            if (result == 1) {
                setFlash(req, "success", "Đã thêm sản phẩm vào giỏ hàng thành công!");
            } else if (result == 0) {
                setFlash(req, "warning", "Số lượng sản phẩm trong giỏ đã được điều chỉnh về giới hạn tồn kho tối đa!");
            } else {
                setFlash(req, "danger", "Sản phẩm hiện không khả dụng hoặc đã hết hàng!");
            }
        } catch (Exception e) {
            setFlash(req, "danger", "Lỗi thêm sản phẩm vào giỏ hàng!");
        }

        String redirect = req.getParameter("redirect");
        if ("cart".equalsIgnoreCase(redirect)) {
            resp.sendRedirect(req.getContextPath() + "/cart");
        } else {
            String referer = req.getHeader("referer");
            if (referer != null && !referer.isEmpty()) {
                resp.sendRedirect(referer);
            } else {
                resp.sendRedirect(req.getContextPath() + "/cart");
            }
        }
    }

    private void handleUpdate(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        try {
            int productId = Integer.parseInt(req.getParameter("productId"));
            int quantity = Integer.parseInt(req.getParameter("quantity"));

            Cart_24110240 cart = cartService.getCart(req.getSession());
            int result = cartService.updateQuantity(cart, productId, quantity);

            if (result == 1) {
                setFlash(req, "success", "Cập nhật số lượng sản phẩm thành công!");
            } else if (result == 0) {
                setFlash(req, "warning", "Số lượng yêu cầu vượt quá tồn kho. Đã tự động điều chỉnh về số lượng tối đa cho phép!");
            } else if (result == -1) {
                setFlash(req, "info", "Đã xóa sản phẩm khỏi giỏ hàng vì số lượng đặt bằng 0.");
            }
        } catch (Exception e) {
            setFlash(req, "danger", "Lỗi cập nhật số lượng sản phẩm!");
        }
        resp.sendRedirect(req.getContextPath() + "/cart");
    }

    private void handleIncrease(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        try {
            int productId = Integer.parseInt(req.getParameter("id"));
            Cart_24110240 cart = cartService.getCart(req.getSession());
            boolean success = cartService.increaseQuantity(cart, productId);
            if (!success) {
                setFlash(req, "warning", "Không thể tăng thêm vì đã đạt số lượng tồn kho tối đa!");
            }
        } catch (Exception ignored) {}
        resp.sendRedirect(req.getContextPath() + "/cart");
    }

    private void handleDecrease(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        try {
            int productId = Integer.parseInt(req.getParameter("id"));
            Cart_24110240 cart = cartService.getCart(req.getSession());
            boolean success = cartService.decreaseQuantity(cart, productId);
            if (!success) {
                setFlash(req, "warning", "Số lượng tối thiểu là 1. Nếu muốn xóa, hãy bấm nút Xóa!");
            }
        } catch (Exception ignored) {}
        resp.sendRedirect(req.getContextPath() + "/cart");
    }

    private void handleDelete(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        try {
            int productId = Integer.parseInt(req.getParameter("id"));
            Cart_24110240 cart = cartService.getCart(req.getSession());
            cartService.removeFromCart(cart, productId);
            setFlash(req, "success", "Đã xóa sản phẩm khỏi giỏ hàng thành công!");
        } catch (Exception ignored) {}
        resp.sendRedirect(req.getContextPath() + "/cart");
    }

    private void handleClear(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        Cart_24110240 cart = cartService.getCart(req.getSession());
        cartService.clearCart(cart);
        setFlash(req, "info", "Đã làm trống giỏ hàng!");
        resp.sendRedirect(req.getContextPath() + "/cart");
    }

    private void showCheckout(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User currentUser = (User) session.getAttribute("currentUser");

        if (currentUser == null) {
            setFlash(req, "warning", "Vui lòng đăng nhập tài khoản để tiến hành thanh toán!");
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        Cart_24110240 cart = cartService.getCart(session);
        if (cart == null || cart.isEmpty()) {
            setFlash(req, "danger", "Giỏ hàng của bạn đang trống! Vui lòng chọn sản phẩm trước khi thanh toán.");
            resp.sendRedirect(req.getContextPath() + "/cart");
            return;
        }

        req.setAttribute("cart", cart);
        req.setAttribute("currentUser", currentUser);
        req.setAttribute("pageTitle", "Thanh Toán Đơn Hàng (COD)");
        req.getRequestDispatcher("/WEB-INF/views/user/checkout.jsp").forward(req, resp);
    }

    private void handleCheckoutCOD(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User currentUser = (User) session.getAttribute("currentUser");

        if (currentUser == null) {
            setFlash(req, "warning", "Vui lòng đăng nhập tài khoản để hoàn tất đặt hàng!");
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        Cart_24110240 cart = cartService.getCart(session);
        if (cart == null || cart.isEmpty()) {
            setFlash(req, "danger", "Giỏ hàng của bạn đang trống, không thể thanh toán!");
            resp.sendRedirect(req.getContextPath() + "/cart");
            return;
        }

        String receiverName = req.getParameter("receiverName");
        String receiverPhone = req.getParameter("receiverPhone");
        String shippingAddress = req.getParameter("shippingAddress");
        String note = req.getParameter("note");

        if (receiverName == null || receiverName.trim().isEmpty() ||
            receiverPhone == null || receiverPhone.trim().isEmpty() ||
            shippingAddress == null || shippingAddress.trim().isEmpty()) {
            setFlash(req, "danger", "Vui lòng điền đầy đủ Họ tên, Số điện thoại và Địa chỉ giao hàng!");
            req.setAttribute("cart", cart);
            req.setAttribute("receiverName", receiverName);
            req.setAttribute("receiverPhone", receiverPhone);
            req.setAttribute("shippingAddress", shippingAddress);
            req.setAttribute("note", note);
            req.setAttribute("pageTitle", "Thanh Toán Đơn Hàng (COD)");
            req.getRequestDispatcher("/WEB-INF/views/user/checkout.jsp").forward(req, resp);
            return;
        }

        Cart savedOrder = cartService.checkoutCOD(cart, currentUser, receiverName, receiverPhone, shippingAddress, note);
        if (savedOrder != null && savedOrder.getCartId() != null) {
            setFlash(req, "success", "🎉 Đặt hàng thành công bằng phương thức Thanh toán khi nhận hàng (COD)!");
            resp.sendRedirect(req.getContextPath() + "/cart/order-success?id=" + savedOrder.getCartId());
        } else {
            setFlash(req, "danger", "Có lỗi xảy ra trong quá trình xử lý đơn hàng. Vui lòng thử lại!");
            resp.sendRedirect(req.getContextPath() + "/cart/checkout");
        }
    }

    private void showOrderSuccess(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            int orderId = Integer.parseInt(req.getParameter("id"));
            Cart order = cartService.getOrderById(orderId);
            if (order != null) {
                req.setAttribute("order", order);
                req.setAttribute("pageTitle", "Đặt Hàng Thành Công - Mã Đơn #" + order.getCartId());
                req.getRequestDispatcher("/WEB-INF/views/user/order-success.jsp").forward(req, resp);
                return;
            }
        } catch (Exception ignored) {}
        resp.sendRedirect(req.getContextPath() + "/home");
    }

    private void showMyOrders(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User currentUser = (User) session.getAttribute("currentUser");

        if (currentUser == null) {
            setFlash(req, "warning", "Vui lòng đăng nhập để xem lịch sử đơn hàng!");
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String statusParam = req.getParameter("status");
        Integer filterStatus = null;
        if (statusParam != null && !statusParam.trim().isEmpty() && !"all".equalsIgnoreCase(statusParam.trim())) {
            try {
                filterStatus = Integer.parseInt(statusParam.trim());
            } catch (NumberFormatException ignored) {}
        }

        List<Cart> orders;
        if (filterStatus != null) {
            orders = cartService.getOrdersByUserIdAndStatus(currentUser.getUserId(), filterStatus);
        } else {
            orders = cartService.getOrdersByUserId(currentUser.getUserId());
        }

        java.util.Map<String, Long> counts = cartService.getOrderCountsByStatus(currentUser.getUserId());
        long totalOrders = counts.values().stream().mapToLong(Long::longValue).sum();

        req.setAttribute("orders", orders);
        req.setAttribute("counts", counts);
        req.setAttribute("totalOrders", totalOrders);
        req.setAttribute("currentStatus", filterStatus != null ? String.valueOf(filterStatus) : "all");
        req.setAttribute("pageTitle", "Lịch Sử Đơn Hàng Của Bạn");
        req.getRequestDispatcher("/WEB-INF/views/user/orders.jsp").forward(req, resp);
    }

    private void setFlash(HttpServletRequest req, String type, String msg) {
        HttpSession session = req.getSession();
        session.setAttribute("flashType", type);
        session.setAttribute("flashMessage", msg);
    }
}
