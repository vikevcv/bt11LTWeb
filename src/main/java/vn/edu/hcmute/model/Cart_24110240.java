package vn.edu.hcmute.model;

import java.io.Serializable;
import java.util.Collection;
import java.util.LinkedHashMap;
import java.util.Map;

/**
 * Model quản lý Giỏ hàng (Session Shopping Cart).
 * Hỗ trợ các thao tác: thêm, xóa, sửa, tăng/giảm số lượng trong giới hạn tồn kho.
 * Tuân thủ quy tắc đặt tên: TênClass_MSSV.java
 */
public class Cart_24110240 implements Serializable {

    private static final long serialVersionUID = 1L;

    // Lưu danh sách sản phẩm theo productId
    private final Map<Integer, CartItem_24110240> items = new LinkedHashMap<>();

    public Collection<CartItem_24110240> getItems() {
        return items.values();
    }

    public Map<Integer, CartItem_24110240> getItemMap() {
        return items;
    }

    /**
     * Thêm sản phẩm vào giỏ hàng với số lượng mong muốn.
     * Kiểm tra giới hạn số lượng theo tồn kho (stock / amount).
     * @return true nếu thêm đủ số lượng, false nếu bị giới hạn ở mức tối đa cho phép.
     */
    public boolean addItem(Product product, int addQuantity) {
        if (product == null || product.getProductId() == null) {
            return false;
        }

        int maxLimit = (product.getStock() != null && product.getStock() > 0)
                ? product.getStock()
                : (product.getAmount() != null && product.getAmount() > 0 ? product.getAmount() : 99);

        CartItem_24110240 current = items.get(product.getProductId());
        if (current != null) {
            int newQuantity = current.getQuantity() + addQuantity;
            if (newQuantity > maxLimit) {
                current.setQuantity(maxLimit);
                return false; // Vượt quá tồn kho, đặt về max
            } else if (newQuantity < 1) {
                current.setQuantity(1);
                return true;
            } else {
                current.setQuantity(newQuantity);
                return true;
            }
        } else {
            int initialQty = Math.max(1, addQuantity);
            boolean limitReached = false;
            if (initialQty > maxLimit) {
                initialQty = maxLimit;
                limitReached = true;
            }
            items.put(product.getProductId(), new CartItem_24110240(product, initialQty));
            return !limitReached;
        }
    }

    /**
     * Sửa/Cập nhật số lượng của một sản phẩm trong giỏ hàng.
     * Ràng buộc: Số lượng phải từ 1 đến số lượng tồn kho tối đa.
     * @return 1: thành công bình thường; 0: bị giới hạn về maxLimit; -1: số lượng <= 0 (xóa sản phẩm).
     */
    public int updateQuantity(int productId, int quantity) {
        CartItem_24110240 item = items.get(productId);
        if (item == null) {
            return -2; // Không tìm thấy sản phẩm trong giỏ
        }

        if (quantity <= 0) {
            items.remove(productId);
            return -1; // Đã xóa khỏi giỏ
        }

        int maxLimit = item.getMaxLimit();
        if (quantity > maxLimit) {
            item.setQuantity(maxLimit);
            return 0; // Đạt giới hạn tối đa
        }

        item.setQuantity(quantity);
        return 1; // Cập nhật thành công
    }

    /**
     * Tăng số lượng lên 1 (trong giới hạn tồn kho)
     */
    public boolean increaseQuantity(int productId) {
        CartItem_24110240 item = items.get(productId);
        if (item != null) {
            int maxLimit = item.getMaxLimit();
            if (item.getQuantity() < maxLimit) {
                item.setQuantity(item.getQuantity() + 1);
                return true;
            }
            return false;
        }
        return false;
    }

    /**
     * Giảm số lượng đi 1 (giới hạn tối thiểu là 1)
     */
    public boolean decreaseQuantity(int productId) {
        CartItem_24110240 item = items.get(productId);
        if (item != null) {
            if (item.getQuantity() > 1) {
                item.setQuantity(item.getQuantity() - 1);
                return true;
            }
            return false;
        }
        return false;
    }

    /**
     * Xóa 1 sản phẩm khỏi giỏ hàng
     */
    public void removeItem(int productId) {
        items.remove(productId);
    }

    /**
     * Xóa sạch toàn bộ giỏ hàng
     */
    public void clear() {
        items.clear();
    }

    /**
     * Tổng số lượng sản phẩm có trong giỏ
     */
    public int getTotalQuantity() {
        return items.values().stream().mapToInt(CartItem_24110240::getQuantity).sum();
    }

    /**
     * Số loại sản phẩm khác nhau trong giỏ
     */
    public int getTotalItems() {
        return items.size();
    }

    /**
     * Tổng số tiền cần thanh toán của toàn bộ giỏ hàng
     */
    public float getTotalAmount() {
        return (float) items.values().stream().mapToDouble(CartItem_24110240::getTotalPrice).sum();
    }

    public long getTotalAmountLong() {
        return Math.round(getTotalAmount());
    }

    public String getFormattedTotalAmount() {
        return String.format(java.util.Locale.US, "%,d", getTotalAmountLong()).replace(',', '.');
    }

    /**
     * Kiểm tra giỏ hàng có đang trống không
     */
    public boolean isEmpty() {
        return items.isEmpty();
    }
}
