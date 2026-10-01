package vn.edu.hcmute.dao;

import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;
import vn.edu.hcmute.model.Seller;
import vn.edu.hcmute.util.JpaUtil_24110240;

import java.util.List;

public class SellerDAO_24110240 {

    public List<Seller> findAll() {
        EntityManager em = JpaUtil_24110240.getEntityManager();
        try {
            TypedQuery<Seller> query = em.createQuery("SELECT s FROM Seller s WHERE s.status = 1", Seller.class);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    public Seller findById(Integer sellerId) {
        if (sellerId == null) return null;
        EntityManager em = JpaUtil_24110240.getEntityManager();
        try {
            return em.find(Seller.class, sellerId);
        } finally {
            em.close();
        }
    }
}
