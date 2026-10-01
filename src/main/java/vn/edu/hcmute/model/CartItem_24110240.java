package vn.edu.hcmute.model;

import java.io.Serializable;

/**
 * Model biểu diễn một mục hàng hóa trong giỏ hàng (Session Shopping Cart Item).
 * Tuân thủ quy tắc đặt tên: TênClass_MSSV.java
 */
public class CartItem_24110240 implements Serializable {

    private static final long serialVersionUID = 1L;

    private Product product;
    private int quantity;
    private float unitPrice;

    public CartItem_24110240() {
    }

    public CartItem_24110240(Product product, int quantity) {
        this.product = product;
        this.quantity = quantity;
        this.unitPrice = (product != null && product.getPrice() != null) ? product.getPrice() : 0f;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public float getUnitPrice() {
        return unitPrice;
    }

    public void setUnitPrice(float unitPrice) {
        this.unitPrice = unitPrice;
    }

    /**
     * Thành tiền cho sản phẩm này = đơn giá * số lượng
     */
    public float getTotalPrice() {
        return this.unitPrice * this.quantity;
    }

    public long getUnitPriceLong() {
        return Math.round(this.unitPrice);
    }

    public long getTotalPriceLong() {
        return Math.round(getTotalPrice());
    }

    public String getFormattedUnitPrice() {
        return String.format(java.util.Locale.US, "%,d", getUnitPriceLong()).replace(',', '.');
    }

    public String getFormattedTotalPrice() {
        return String.format(java.util.Locale.US, "%,d", getTotalPriceLong()).replace(',', '.');
    }

    /**
     * Giới hạn số lượng tối đa được phép đặt dựa trên tồn kho sản phẩm
     */
    public int getMaxLimit() {
        if (product == null) return 99;
        if (product.getStock() != null && product.getStock() > 0) {
            return product.getStock();
        }
        if (product.getAmount() != null && product.getAmount() > 0) {
            return product.getAmount();
        }
        return 99;
    }
}
