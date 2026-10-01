package vn.edu.hcmute.service;

import jakarta.servlet.http.HttpSession;
import vn.edu.hcmute.dao.CartDAO_24110240;
import vn.edu.hcmute.dao.ProductDAO_24110240;
import vn.edu.hcmute.model.*;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class CartService_24110240 {

    private final ProductDAO_24110240 productDAO = new ProductDAO_24110240();
    private final CartDAO_24110240 cartDAO = new CartDAO_24110240();

    /**
     * Lấy hoặc khởi tạo giỏ hàng từ Session
     */
    public Cart_24110240 getCart(HttpSession session) {
        Cart_24110240 cart = (Cart_24110240) session.getAttribute("cart");
        if (cart == null) {
            cart = new Cart_24110240();
            session.setAttribute("cart", cart);
        }
        return cart;
    }

    /**
     * Thêm sản phẩm vào giỏ hàng
     * @return 1: thành công; 0: thành công nhưng số lượng bị giới hạn do tồn kho; -1: không tìm thấy sản phẩm hoặc sản phẩm hết hàng
     */
    public int addToCart(Cart_24110240 cart, int productId, int quantity) {
        Product product = productDAO.findById(productId);
        if (product == null) {
            return -1;
        }

        int maxLimit = (product.getStock() != null && product.getStock() > 0)
                ? product.getStock()
                : (product.getAmount() != null && product.getAmount() > 0 ? product.getAmount() : 99);

        if (maxLimit <= 0) {
            return -1; // Hết hàng
        }

        boolean withinLimit = cart.addItem(product, quantity);
        return withinLimit ? 1 : 0;
    }

    /**
     * Cập nhật số lượng sản phẩm
     * @return 1: thành công; 0: bị giới hạn về mức tối đa; -1: xóa sản phẩm; -2: không tìm thấy
     */
    public int updateQuantity(Cart_24110240 cart, int productId, int quantity) {
        return cart.updateQuantity(productId, quantity);
    }

    /**
     * Tăng 1 đơn vị
     */
    public boolean increaseQuantity(Cart_24110240 cart, int productId) {
        return cart.increaseQuantity(productId);
    }

    /**
     * Giảm 1 đơn vị
     */
    public boolean decreaseQuantity(Cart_24110240 cart, int productId) {
        return cart.decreaseQuantity(productId);
    }

    /**
     * Xóa sản phẩm khỏi giỏ
     */
    public void removeFromCart(Cart_24110240 cart, int productId) {
        cart.removeItem(productId);
    }

    /**
     * Làm trống giỏ hàng
     */
    public void clearCart(Cart_24110240 cart) {
        cart.clear();
    }

    /**
     * Tiến hành thanh toán đơn hàng bằng COD (Cash On Delivery - Thanh toán khi nhận hàng)
     * @return Cart đơn hàng đã lưu vào CSDL (có cartId), hoặc null nếu thất bại
     */
    public Cart checkoutCOD(Cart_24110240 sessionCart, User user, 
                            String receiverName, String receiverPhone, 
                            String shippingAddress, String note) {
        if (sessionCart == null || sessionCart.isEmpty() || user == null) {
            return null;
        }

        Cart dbCart = new Cart();
        dbCart.setUser(user);
        dbCart.setBuyDate(new Date());
        dbCart.setStatus(0); // 0: Chờ xác nhận COD (đơn hàng thanh toán khi nhận)
        dbCart.setReceiverName(receiverName != null && !receiverName.trim().isEmpty() ? receiverName.trim() : user.getFullname());
        dbCart.setReceiverPhone(receiverPhone != null && !receiverPhone.trim().isEmpty() ? receiverPhone.trim() : user.getPhone());
        dbCart.setShippingAddress(shippingAddress != null ? shippingAddress.trim() : "");
        dbCart.setNote(note != null ? note.trim() : "");
        dbCart.setPaymentMethod("COD");
        dbCart.setTotalAmount(sessionCart.getTotalAmount());

        List<CartItem> dbItems = new ArrayList<>();
        for (CartItem_24110240 item : sessionCart.getItems()) {
            CartItem dbItem = new CartItem();
            dbItem.setProduct(item.getProduct());
            dbItem.setQuantity(item.getQuantity());
            dbItem.setUnitPrice(item.getUnitPrice());
            dbItems.add(dbItem);
        }

        Cart savedOrder = cartDAO.saveOrder(dbCart, dbItems);
        sessionCart.clear();
        return savedOrder;
    }

    /**
     * Phương thức checkout tương thích cũ
     */
    public boolean checkout(Cart_24110240 sessionCart, User user) {
        Cart order = checkoutCOD(sessionCart, user, 
                user != null ? user.getFullname() : null, 
                user != null ? user.getPhone() : null, 
                "Địa chỉ mặc định", 
                "Đặt hàng COD");
        return order != null;
    }

    public Cart getOrderById(Integer cartId) {
        return cartDAO.findById(cartId);
    }

    public List<Cart> getOrdersByUserId(Integer userId) {
        return cartDAO.findCartsByUserId(userId);
    }
}
