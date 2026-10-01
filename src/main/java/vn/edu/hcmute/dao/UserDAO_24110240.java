package vn.edu.hcmute.dao;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.NoResultException;
import jakarta.persistence.TypedQuery;
import vn.edu.hcmute.model.User;
import vn.edu.hcmute.model.UserRole;
import vn.edu.hcmute.util.JpaUtil_24110240;

public class UserDAO_24110240 {

    public User findByUsername(String username) {
        if (username == null) return null;
        EntityManager em = JpaUtil_24110240.getEntityManager();
        try {
            TypedQuery<User> query = em.createQuery("SELECT u FROM User u WHERE u.username = :uname", User.class);
            query.setParameter("uname", username.trim());
            return query.getSingleResult();
        } catch (NoResultException e) {
            return null;
        } finally {
            em.close();
        }
    }

    public User findByEmail(String email) {
        if (email == null) return null;
        EntityManager em = JpaUtil_24110240.getEntityManager();
        try {
            TypedQuery<User> query = em.createQuery("SELECT u FROM User u WHERE u.email = :email", User.class);
            query.setParameter("email", email.trim());
            return query.getSingleResult();
        } catch (NoResultException e) {
            return null;
        } finally {
            em.close();
        }
    }

    public User findByUsernameAndCode(String username, String code) {
        EntityManager em = JpaUtil_24110240.getEntityManager();
        try {
            TypedQuery<User> query = em.createQuery(
                "SELECT u FROM User u WHERE u.username = :uname AND u.code = :code", User.class);
            query.setParameter("uname", username.trim());
            query.setParameter("code", code.trim());
            return query.getSingleResult();
        } catch (NoResultException e) {
            return null;
        } finally {
            em.close();
        }
    }

    public UserRole findRoleByName(String roleName) {
        EntityManager em = JpaUtil_24110240.getEntityManager();
        try {
            TypedQuery<UserRole> query = em.createQuery("SELECT r FROM UserRole r WHERE r.roleName = :rname", UserRole.class);
            query.setParameter("rname", roleName);
            return query.getSingleResult();
        } catch (NoResultException e) {
            return null;
        } finally {
            em.close();
        }
    }

    public void create(User user) {
        EntityManager em = JpaUtil_24110240.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            em.persist(user);
            trans.commit();
        } catch (Exception ex) {
            if (trans.isActive()) trans.rollback();
            throw new RuntimeException("Lỗi lưu User: " + ex.getMessage(), ex);
        } finally {
            em.close();
        }
    }

    public void update(User user) {
        EntityManager em = JpaUtil_24110240.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            em.merge(user);
            trans.commit();
        } catch (Exception ex) {
            if (trans.isActive()) trans.rollback();
            throw new RuntimeException("Lỗi cập nhật User: " + ex.getMessage(), ex);
        } finally {
            em.close();
        }
    }
}
