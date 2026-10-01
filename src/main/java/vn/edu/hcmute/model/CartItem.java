package vn.edu.hcmute.model;

import jakarta.persistence.*;
import java.io.Serializable;

@Entity
@Table(name = "CartItem")
public class CartItem implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "cartItemId")
    private Integer cartItemId;

    @Column(name = "quantity")
    private Integer quantity = 1;

    @Column(name = "unitPrice")
    private Float unitPrice = 0f;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "productId")
    private Product product;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "cartId")
    private Cart cart;

    public CartItem() {
    }

    public Integer getCartItemId() {
        return cartItemId;
    }

    public void setCartItemId(Integer cartItemId) {
        this.cartItemId = cartItemId;
    }

    public Integer getQuantity() {
        return quantity;
    }

    public void setQuantity(Integer quantity) {
        this.quantity = quantity;
    }

    public Float getUnitPrice() {
        return unitPrice;
    }

    public void setUnitPrice(Float unitPrice) {
        this.unitPrice = unitPrice;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    public Cart getCart() {
        return cart;
    }

    public void setCart(Cart cart) {
        this.cart = cart;
    }

    public float getTotalPrice() {
        return (unitPrice != null ? unitPrice : 0f) * (quantity != null ? quantity : 0);
    }

    public long getUnitPriceLong() {
        return unitPrice != null ? Math.round(unitPrice) : 0L;
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
}
