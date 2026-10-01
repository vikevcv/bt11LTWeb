package vn.edu.hcmute.dao;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;
import vn.edu.hcmute.model.Cart;
import vn.edu.hcmute.model.CartItem;
import vn.edu.hcmute.util.JpaUtil_24110240;

import java.util.List;

public class CartDAO_24110240 {

    public Cart saveOrder(Cart cart, List<CartItem> items) {
        EntityManager em = JpaUtil_24110240.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            em.persist(cart);
            if (items != null) {
                for (CartItem item : items) {
                    item.setCart(cart);
                    em.persist(item);
                }
            }
            trans.commit();
            return cart;
        } catch (Exception ex) {
            if (trans.isActive()) trans.rollback();
            throw new RuntimeException("Lỗi lưu đơn hàng vào CSDL: " + ex.getMessage(), ex);
        } finally {
            em.close();
        }
    }

    public Cart findById(Integer cartId) {
        if (cartId == null) return null;
        EntityManager em = JpaUtil_24110240.getEntityManager();
        try {
            TypedQuery<Cart> query = em.createQuery(
                "SELECT DISTINCT c FROM Cart c LEFT JOIN FETCH c.cartItems ci LEFT JOIN FETCH ci.product WHERE c.cartId = :id",
                Cart.class);
            query.setParameter("id", cartId);
            List<Cart> list = query.getResultList();
            return list.isEmpty() ? null : list.get(0);
        } finally {
            em.close();
        }
    }

    public List<Cart> findCartsByUserId(Integer userId) {
        if (userId == null) return List.of();
        EntityManager em = JpaUtil_24110240.getEntityManager();
        try {
            TypedQuery<Cart> query = em.createQuery(
                "SELECT DISTINCT c FROM Cart c LEFT JOIN FETCH c.cartItems ci LEFT JOIN FETCH ci.product WHERE c.user.userId = :uid ORDER BY c.buyDate DESC",
                Cart.class);
            query.setParameter("uid", userId);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    public List<Cart> findCartsByUserIdAndStatus(Integer userId, Integer status) {
        if (userId == null) return List.of();
        if (status == null) return findCartsByUserId(userId);
        EntityManager em = JpaUtil_24110240.getEntityManager();
        try {
            TypedQuery<Cart> query = em.createQuery(
                "SELECT DISTINCT c FROM Cart c LEFT JOIN FETCH c.cartItems ci LEFT JOIN FETCH ci.product WHERE c.user.userId = :uid AND c.status = :st ORDER BY c.buyDate DESC",
                Cart.class);
            query.setParameter("uid", userId);
            query.setParameter("st", status);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    public java.util.Map<String, Long> countOrdersByStatus(Integer userId) {
        java.util.Map<String, Long> map = new java.util.HashMap<>();
        if (userId == null) return map;
        EntityManager em = JpaUtil_24110240.getEntityManager();
        try {
            List<Object[]> results = em.createQuery(
                "SELECT c.status, COUNT(c) FROM Cart c WHERE c.user.userId = :uid GROUP BY c.status",
                Object[].class)
                .setParameter("uid", userId)
                .getResultList();
            for (Object[] row : results) {
                if (row[0] != null) {
                    map.put(String.valueOf(row[0]), (Long) row[1]);
                }
            }
            return map;
        } finally {
            em.close();
        }
    }
}
