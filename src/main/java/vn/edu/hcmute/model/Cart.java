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

    public String getStatusText() {
        if (status == null) return "Chờ xử lý";
        switch (status) {
            case 0: return "Chờ xác nhận COD";
            case 1: return "Đang giao hàng (COD)";
            case 2: return "Giao thành công & Đã thanh toán";
            case -1: return "Đã hủy đơn";
            default: return "Đang xử lý";
        }
    }

    public String getStatusBadgeClass() {
        if (status == null) return "bg-secondary";
        switch (status) {
            case 0: return "bg-warning text-dark";
            case 1: return "bg-primary";
            case 2: return "bg-success";
            case -1: return "bg-danger";
            default: return "bg-info text-dark";
        }
    }
}
