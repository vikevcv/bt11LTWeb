package vn.edu.hcmute.dao;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;
import vn.edu.hcmute.model.Category;
import vn.edu.hcmute.util.JpaUtil_24110240;

import java.util.List;

public class CategoryDAO_24110240 {

    public List<Category> findAll() {
        EntityManager em = JpaUtil_24110240.getEntityManager();
        try {
            TypedQuery<Category> query = em.createQuery("SELECT c FROM Category c ORDER BY c.categoryId DESC", Category.class);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    public Category findById(Integer id) {
        if (id == null) return null;
        EntityManager em = JpaUtil_24110240.getEntityManager();
        try {
            return em.find(Category.class, id);
        } finally {
            em.close();
        }
    }

    public void create(Category category) {
        EntityManager em = JpaUtil_24110240.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            em.persist(category);
            trans.commit();
        } catch (Exception ex) {
            if (trans.isActive()) trans.rollback();
            throw new RuntimeException("Lỗi lưu Category: " + ex.getMessage(), ex);
        } finally {
            em.close();
        }
    }

    public void update(Category category) {
        EntityManager em = JpaUtil_24110240.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            em.merge(category);
            trans.commit();
        } catch (Exception ex) {
            if (trans.isActive()) trans.rollback();
            throw new RuntimeException("Lỗi cập nhật Category: " + ex.getMessage(), ex);
        } finally {
            em.close();
        }
    }

    public void delete(Integer id) {
        EntityManager em = JpaUtil_24110240.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            Category category = em.find(Category.class, id);
            if (category != null) {
                em.remove(category);
            }
            trans.commit();
        } catch (Exception ex) {
            if (trans.isActive()) trans.rollback();
            throw new RuntimeException("Lỗi xóa Category: " + ex.getMessage(), ex);
        } finally {
            em.close();
        }
    }

    public List<Category> findPaginated(int page, int pageSize) {
        EntityManager em = JpaUtil_24110240.getEntityManager();
        try {
            TypedQuery<Category> query = em.createQuery("SELECT c FROM Category c ORDER BY c.categoryId DESC", Category.class);
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
            TypedQuery<Long> query = em.createQuery("SELECT COUNT(c) FROM Category c", Long.class);
            return query.getSingleResult();
        } finally {
            em.close();
        }
    }
}
