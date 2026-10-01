package vn.edu.hcmute.dao;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;
import vn.edu.hcmute.model.Product;
import vn.edu.hcmute.util.JpaUtil_24110240;

import java.util.List;

public class ProductDAO_24110240 {

    public List<Product> findAll() {
        EntityManager em = JpaUtil_24110240.getEntityManager();
        try {
            TypedQuery<Product> query = em.createQuery(
                "SELECT p FROM Product p LEFT JOIN FETCH p.category LEFT JOIN FETCH p.seller ORDER BY p.productId DESC", 
                Product.class);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    public Product findById(Integer id) {
        if (id == null) return null;
        EntityManager em = JpaUtil_24110240.getEntityManager();
        try {
            TypedQuery<Product> query = em.createQuery(
                "SELECT p FROM Product p LEFT JOIN FETCH p.category LEFT JOIN FETCH p.seller WHERE p.productId = :pid", 
                Product.class);
            query.setParameter("pid", id);
            return query.getSingleResult();
        } catch (Exception e) {
            return null;
        } finally {
            em.close();
        }
    }

    public List<Product> findBySellerId(Integer sellerId) {
        if (sellerId == null) return List.of();
        EntityManager em = JpaUtil_24110240.getEntityManager();
        try {
            TypedQuery<Product> query = em.createQuery(
                "SELECT p FROM Product p LEFT JOIN FETCH p.category WHERE p.seller.sellerId = :sid ORDER BY p.productId DESC", 
                Product.class);
            query.setParameter("sid", sellerId);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    public void create(Product product) {
        EntityManager em = JpaUtil_24110240.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            em.persist(product);
            trans.commit();
        } catch (Exception ex) {
            if (trans.isActive()) trans.rollback();
            throw new RuntimeException("Lỗi lưu Product: " + ex.getMessage(), ex);
        } finally {
            em.close();
        }
    }

    public void update(Product product) {
        EntityManager em = JpaUtil_24110240.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            em.merge(product);
            trans.commit();
        } catch (Exception ex) {
            if (trans.isActive()) trans.rollback();
            throw new RuntimeException("Lỗi cập nhật Product: " + ex.getMessage(), ex);
        } finally {
            em.close();
        }
    }

    public void delete(Integer id) {
        EntityManager em = JpaUtil_24110240.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            Product product = em.find(Product.class, id);
            if (product != null) {
                em.remove(product);
            }
            trans.commit();
        } catch (Exception ex) {
            if (trans.isActive()) trans.rollback();
            throw new RuntimeException("Lỗi xóa Product: " + ex.getMessage(), ex);
        } finally {
            em.close();
        }
    }

    public List<Product> findPaginated(int page, int pageSize) {
        EntityManager em = JpaUtil_24110240.getEntityManager();
        try {
            TypedQuery<Product> query = em.createQuery(
                "SELECT p FROM Product p LEFT JOIN FETCH p.category LEFT JOIN FETCH p.seller ORDER BY p.productId DESC", 
                Product.class);
            query.setFirstResult((page - 1) * pageSize);
            query.setMaxResults(pageSize);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    public long countAll() {
        EntityManager em = JpaUtil_24110240.getEntityManager();
        try {
            TypedQuery<Long> query = em.createQuery("SELECT COUNT(p) FROM Product p", Long.class);
            return query.getSingleResult();
        } finally {
            em.close();
        }
    }
}
