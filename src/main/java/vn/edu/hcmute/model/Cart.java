package vn.edu.hcmute.model;

import jakarta.persistence.*;
import java.io.Serializable;
import java.util.Date;
import java.util.List;

@Entity
@Table(name = "Cart")
public class Cart implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "cartId")
    private Integer cartId;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "userId")
    private User user;

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "buyDate")
    private Date buyDate = new Date();

    @Column(name = "status")
    private Integer status = 0;

    @Column(name = "receiverName", length = 100)
    private String receiverName;

    @Column(name = "receiverPhone", length = 20)
    private String receiverPhone;

    @Column(name = "shippingAddress", length = 300)
    private String shippingAddress;

    @Column(name = "note", length = 500)
    private String note;

    @Column(name = "paymentMethod", length = 50)
    private String paymentMethod = "COD";

    @Column(name = "totalAmount")
    private Float totalAmount = 0f;

    @OneToMany(mappedBy = "cart", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<CartItem> cartItems;

    public Cart() {
    }

    public Integer getCartId() {
        return cartId;
    }

    public void setCartId(Integer cartId) {
        this.cartId = cartId;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Date getBuyDate() {
        return buyDate;
    }

    public void setBuyDate(Date buyDate) {
        this.buyDate = buyDate;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public String getReceiverName() {
        return receiverName;
    }

    public void setReceiverName(String receiverName) {
        this.receiverName = receiverName;
    }

    public String getReceiverPhone() {
        return receiverPhone;
    }

    public void setReceiverPhone(String receiverPhone) {
        this.receiverPhone = receiverPhone;
    }

    public String getShippingAddress() {
        return shippingAddress;
    }

    public void setShippingAddress(String shippingAddress) {
        this.shippingAddress = shippingAddress;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public String getPaymentMethod() {
        return paymentMethod;
    }

    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

    public Float getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(Float totalAmount) {
        this.totalAmount = totalAmount;
    }

    public List<CartItem> getCartItems() {
        return cartItems;
    }

    public void setCartItems(List<CartItem> cartItems) {
        this.cartItems = cartItems;
    }

    public long getTotalAmountLong() {
        return totalAmount != null ? Math.round(totalAmount) : 0L;
    }

    public String getFormattedTotalAmount() {
        return String.format(java.util.Locale.US, "%,d", getTotalAmountLong()).replace(',', '.');
    }

    public static final int STATUS_NEW = 0;         // Đơn hàng mới
    public static final int STATUS_CONFIRMED = 1;   // Đã xác nhận
    public static final int STATUS_PREPARING = 2;   // Chuẩn bị hàng
    public static final int STATUS_SHIPPING = 3;    // Vận chuyển
    public static final int STATUS_DELIVERING = 4;  // Giao hàng
    public static final int STATUS_DELIVERED = 5;   // Đã giao
    public static final int STATUS_CANCELLED = 6;   // Đơn hàng hủy
    public static final int STATUS_RETURNED = 7;    // Đơn hàng hoàn

    public String getStatusText() {
        if (status == null) return "Đơn hàng mới";
        switch (status) {
            case 0: return "Đơn hàng mới";
            case 1: return "Đã xác nhận";
            case 2: return "Chuẩn bị hàng";
            case 3: return "Vận chuyển";
            case 4: return "Giao hàng";
            case 5: return "Đã giao";
            case 6: return "Đơn hàng hủy";
            case 7: return "Đơn hàng hoàn";
            default: return "Đơn hàng mới";
        }
    }

    public String getStatusBadgeClass() {
        if (status == null) return "bg-info text-dark";
        switch (status) {
            case 0: return "bg-info text-dark";
            case 1: return "bg-primary";
            case 2: return "bg-warning text-dark";
            case 3: return "bg-secondary";
            case 4: return "bg-primary-subtle text-primary border border-primary";
            case 5: return "bg-success";
            case 6: return "bg-danger";
            case 7: return "bg-dark";
            default: return "bg-secondary";
        }
    }

    public String getStatusIconClass() {
        if (status == null) return "fa-solid fa-file-lines";
        switch (status) {
            case 0: return "fa-solid fa-file-circle-plus";
            case 1: return "fa-solid fa-clipboard-check";
            case 2: return "fa-solid fa-boxes-packing";
            case 3: return "fa-solid fa-truck-moving";
            case 4: return "fa-solid fa-motorcycle";
            case 5: return "fa-solid fa-circle-check";
            case 6: return "fa-solid fa-ban";
            case 7: return "fa-solid fa-rotate-left";
            default: return "fa-solid fa-clock";
        }
    }
}
