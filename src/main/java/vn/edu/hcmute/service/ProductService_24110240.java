package vn.edu.hcmute.service;

import vn.edu.hcmute.dao.ProductDAO_24110240;
import vn.edu.hcmute.dao.SellerDAO_24110240;
import vn.edu.hcmute.model.Product;
import vn.edu.hcmute.model.Seller;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

public class ProductService_24110240 {

    private final ProductDAO_24110240 productDAO = new ProductDAO_24110240();
    private final SellerDAO_24110240 sellerDAO = new SellerDAO_24110240();

    public List<Product> getAllProducts() {
        return productDAO.findAll();
    }

    public Product getProductById(Integer id) {
        return productDAO.findById(id);
    }

    public void saveProduct(Product product) {
        if (product.getProductId() == null || product.getProductId() == 0) {
            productDAO.create(product);
        } else {
            productDAO.update(product);
        }
    }

    public void deleteProduct(Integer id) {
        productDAO.delete(id);
    }

    public List<Product> getProductsPaginated(int page, int pageSize) {
        return productDAO.findPaginated(page, pageSize);
    }

    public int getTotalPages(int pageSize) {
        long count = productDAO.countAll();
        return (int) Math.ceil((double) count / pageSize);
    }

    public long getTotalCount() {
        return productDAO.countAll();
    }

    /**
     * Phục vụ Câu 3: Lấy danh sách sản phẩm gom nhóm theo từng Seller
     */
    public Map<Seller, List<Product>> getProductsGroupedBySeller() {
        Map<Seller, List<Product>> map = new LinkedHashMap<>();
        List<Seller> sellers = sellerDAO.findAll();
        for (Seller seller : sellers) {
            List<Product> products = productDAO.findBySellerId(seller.getSellerId());
            map.put(seller, products);
        }
        return map;
    }
}
